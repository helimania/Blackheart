#include <EEPROM.h>
#include <U8x8lib.h>
#include "Adafruit_MCP23017.h"
#include <Wire.h>
#include <OneWire.h>
/*************************************************************************************
**  Definition section
*************************************************************************************/
const int tm_lo_val = 85, tm_hi_val = 40;                                           // Temperature sensor value
const float tm_lo_tmp = 54.0, tm_hi_tmp = 88.2;                                     // Real sensor temperature

const int oi_num = 100, fu_num = 100, tm_num = 100;                                 // Average constants:
int oi_buf[oi_num], oi_idx = 0, oi_tot = 0;                                         // Oil
int fu_buf[fu_num], fu_idx = 0, fu_tot = 0;                                         // Fuel
int tm_buf[tm_num], tm_idx = 0, tm_tot = 0;                                         // Temperature

U8X8_SSD1327_MIDAS_128X128_4W_SW_SPI u8x8(12, 13, 11, 10, 9);                       // u8x8(clock, data, cs, dc, reset)
Adafruit_MCP23017 mcp;                                                              // MCP23017 Port Expander

byte ACC = 4, VOLT = 14, FUEL = 15, TEMP = 16, OIL = 17,  DALLAS = 8;               // Pin assignment
volatile unsigned long   micros_sp = 0, micros_th = 0, millis_ds = 0, millis_t  = 0, millis_d  = 0, millis_fu  = 0, millis_vo  = 0, millis_tm  = 0, millis_oi  = 0; // Timers
volatile boolean st = false, tt = false;                                            // Triggers 
volatile byte sz = 0, tz = 0;                                                       // Reset counters
volatile unsigned int sp = 0, th = 0, vo = 0, fu = 0, tm = 0, oi= 0, ds_tm = 0;
unsigned long trip1, trip1_old, trip2;
int pin = 0;
String  mcparray;
char * txtOLED[16] ={ "Blackheart Board", "", "Speed :", "  RPM :", "", "Volts :", "  Oil :", " Fuel :", "TempA :", "TempB :", "", "TripA :",  "TripB :", "", "PortA :", "PortB :" };
OneWire ds(DALLAS);                                                                 // Temperature sensor DS18B20 port
/*************************************************************************************
**  Setup section
*************************************************************************************/
void setup(){
    Serial.begin(115200);
    attachInterrupt(0, spd, FALLING);                                               // Speedometer falling interrupt INT0
    attachInterrupt(1, tah, RISING);                                                // Tahometer rising interrupt INT1
    mcp.begin(7);                                                                   // addr 7 = A2 high, A1 high, A0 high 111
    for (pin = 0; pin  < 16; pin ++) { mcp.pinMode(pin, INPUT); }                   // MCP23017 readonly init
    trip1 = EEPROM_ulong_read(0);                                                   // Read Trip1 from EEPROM
    trip2 = EEPROM_ulong_read(1);                                                   // Read Trip2 from EEPROM
    trip1_old = trip1;
    u8x8.begin();
    u8x8.setPowerSave(0);
    u8x8.setFont(u8x8_font_victoriabold8_r);
    u8x8.setInverseFont(1);
    u8x8.drawString(0,  0,txtOLED[0]);
    u8x8.setFont(u8x8_font_chroma48medium8_r);
    u8x8.setInverseFont(0);
    for (pin = 1; pin  < 16; pin ++) u8x8.drawString(0, pin, txtOLED[pin]);

    for (int idx = 0; idx < oi_num; idx++) oi_buf[idx] = 0;                         // Buffer reset for oil 
    for (int idx = 0; idx < oi_num; idx++) oi_buf[idx] = 0;                         // Buffer reset for fuel 
    for (int idx = 0; idx < oi_num; idx++) oi_buf[idx] = 0;                         // Buffer reset for temperature
}
/*************************************************************************************
**  Main loop section
*************************************************************************************/
void loop(){
    DallasRd();
    if(((millis() - millis_t) >= 20) && digitalRead(ACC)){                          // Serial refresh interval in milliseconds if ACC present
        millis_t = millis();

        if ((millis() - millis_fu)  >= 2000) {                                      // Fuel refresh interval in milliseconds
            // Full - 70~73 / Empty - ?
            millis_fu = millis();
            fu = constrain(analogRead(FUEL), 70, 200);
            fu_tot -= fu_buf[fu_idx];                                               // Average fuel buffer
            fu_buf[fu_idx] = fu; 
            fu_tot += fu_buf[fu_idx];
            fu_idx++; if (fu_idx >= fu_num) fu_idx = 0; 
            fu = fu_tot / fu_num;        
            fu = map(fu, 70, 200, 100, 0);
        }

        if ((millis() - millis_vo)  >= 500) {                                       // Voltage refresh interval in milliseconds
            millis_vo = millis();
            vo = analogRead(VOLT);
        }

        if ((millis() - millis_tm)  >= 1000) {                                      // Temperature refresh interval in milliseconds
            millis_tm = millis();
            tm = constrain(analogRead(TEMP), 10, 200);
            tm_tot -= tm_buf[tm_idx];                                               // Average temperature buffer
            tm_buf[tm_idx] = tm; 
            tm_tot += tm_buf[tm_idx];
            tm_idx++; if (tm_idx >= tm_num) tm_idx = 0; 
            tm = tm_tot / tm_num;        
            //tm = 90;
            //tm = map(tm, 20, 100, 120, 0);
            tm = tm_hi_tmp + (tm_lo_tmp - tm_hi_tmp) / (tm_lo_val - tm_hi_val) * (tm - tm_hi_val);
        }

        if ((millis() - millis_oi)  >= 1000) {                                      // Oil pressure refresh interval in milliseconds
            millis_oi = millis();
            //oi = map(analogRead(OIL), 0, 730, 100, 0);
            oi = analogRead(OIL);
            oi_tot -= oi_buf[oi_idx];                                               // Average oil buffer
            oi_buf[oi_idx] = oi; 
            oi_tot += oi_buf[oi_idx];
            oi_idx++; if (oi_idx >= oi_num) oi_idx = 0; 
            oi = oi_tot / oi_num;        

        }

        mcparray = "";
        for (pin = 0; pin  < 16; pin ++) { mcparray += ","; mcparray += mcp.digitalRead(pin); }
        
        Serial.print(az(sp) + "," + az(th) + "," + az(vo) + "," + az(fu) + "," + az(tm) + "," + az(ds_tm) + "," + az(oi) + mcparray + "," + trip1 + "," + trip2 +"\n");
        
        // Example output string: 0000,0000,1023,1008,1008,0022,1001,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,171,54
        
        Serial.flush();
        if(tz != 0){tz--;}else{th = 0;}; 
        if(sz != 0){sz--;}else{sp = 0;};
    } 

    if(((millis() - millis_d) >= 100) && digitalRead(ACC)){                         // OLED refresh interval in milliseconds if ACC present
        millis_d = millis();
        u8x8.setCursor(8, 2); u8x8.print(az(sp));
        u8x8.setCursor(8, 3); u8x8.print(az(th));
        u8x8.setCursor(8, 5); u8x8.print(vo * (15.800 / 1024));
        u8x8.setCursor(8, 6); u8x8.print(az(analogRead(OIL)));
        u8x8.setCursor(8, 7); u8x8.print(az(analogRead(FUEL)));
        u8x8.setCursor(8, 8); u8x8.print(az(analogRead(TEMP)));
        u8x8.setCursor(8, 9); u8x8.print(az(ds_tm));
        u8x8.setCursor(8, 11); u8x8.print(trip1);
        u8x8.setCursor(8, 12); u8x8.print(trip2);
        mcparray = "";
        for (pin=0; pin  < 8; pin ++)  mcparray += mcp.digitalRead(pin);
        u8x8.setCursor(8, 14); u8x8.print(mcparray);
        mcparray = "";
        for (pin=8; pin  < 16; pin ++)  mcparray += mcp.digitalRead(pin);
        u8x8.setCursor(8, 15); u8x8.print(mcparray);
    }
    
    if (!digitalRead(ACC) && trip1 > trip1_old) {                                   // Write EEPROM if not ACC present
        //EEPROM_ulong_write(0, trip1);
        //EEPROM_ulong_write(1, trip2);
        //delay(2000);
    }
}
/*************************************************************************************
**  Functions section
*************************************************************************************/
void spd() {                                                                        // Speedometer interupt
    if (!st) { micros_sp = micros(); }
    else { sp = 3600000 / 4 / (micros() - micros_sp); }                             // Sensor pulses per rotation
    st = !st; sz = 30;
    trip1 ++; trip2 ++;
}

void tah() {                                                                        // Tahometer interrupt
    if (!tt) { micros_th = micros(); }
    else { th = 30000000 / (micros() - micros_th) * 2; }
    tt = !tt; tz = 10;
}

unsigned long EEPROM_ulong_read(int addr) {                                         // Write EEPROM
    byte raw[4];
    for(byte i = 0; i < 4; i++) raw[i] = EEPROM.read(addr+i);
    unsigned long &num = (unsigned long&)raw;
    return num;
}

void EEPROM_ulong_write(int addr, unsigned long num) {                              // Read EEPROM
    byte raw[4];
    (unsigned long&)raw = num;
    for(byte i = 0; i < 4; i++) EEPROM.write(addr+i, raw[i]);
}

int DallasRd(){                                                                     // Read DS18B20 temperature sensor 
    byte data[2];
    if ((millis() - millis_ds) > 1000){                                             // DS18B20 read interval in milliseconds
        ds.reset(); ds.write(0xCC); ds.write(0xBE);
        data[0] = ds.read(); data[1] = ds.read();
        ds_tm = (data[1] << 8) + data[0];
        ds_tm = (ds_tm >> 4) + 200;
        millis_ds = millis();
        ds.reset(); ds.write(0xCC); ds.write(0x44);                                 // 2 wire connection - (0x44,1) / 3 wire connection (0x44)
    }
}

String az(const int& src) {                                                         // Adding zeroes
    String result;
    result  = (src/1000)  % 10; 
    result += (src/100)   % 10; 
    result += (src/10)    % 10; 
    result += (src)       % 10;
    return result;
}
