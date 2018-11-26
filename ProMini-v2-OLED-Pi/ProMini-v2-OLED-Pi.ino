#include <EEPROM.h>
#include <U8x8lib.h>
#include "Adafruit_MCP23017.h"
#include <Wire.h>
#include <OneWire.h>

U8X8_SSD1327_MIDAS_128X128_4W_SW_SPI u8x8(12, 13, 11, 10, 9);           // u8x8(clock, data, cs, dc, reset)
Adafruit_MCP23017 mcp;                                                  // MCP23017 Port Expander

byte ACC = 4, VOLT = 14, FUEL = 15, TEMP = 16, OIL = 17,  DALLAS = 8;   // Pin assignment
volatile unsigned long   micros_sp = 0, micros_th = 0, millis_ds = 0, millis_t  = 0, millis_d  = 0;;    // Timers
volatile boolean st = false, tt = false;                                // Triggers 
volatile byte sz = 0, tz = 0;                                           // Reset counters
volatile unsigned int sp = 0, th = 0, vo = 0, fu = 0, tm = 0, oi= 0, ds_tm = 0;
unsigned long trip1, trip1_old, trip2;
String  speedometer, tahometer, voltage, fuel, temperature, oil, dallastemp, mcparray;
char * txtOLED[16] ={ "Blackheart Board", "", "Speed :", "  RPM :", "", "Volts :", "  Oil :", " Fuel :", "TempA :", "TempB :", "", "TripA :",  "TripB :", "", "PortA :", "PortB :" };
OneWire ds(DALLAS);                                                     // Temperature sensor DS18B20 port

int pin = 0;
        
void setup(){
    Serial.begin(115200);
    attachInterrupt(0, spd, FALLING);                                   // Speedometer falling interrupt INT0
    attachInterrupt(1, tah, RISING);                                    // Tahometer rising interrupt INT1
    mcp.begin(7);                                                       // addr 7 = A2 high, A1 high, A0 high 111
    for (pin = 0; pin  < 16; pin ++) { mcp.pinMode(pin, INPUT); }       // MCP23017 readonly init
    trip1 = EEPROM_ulong_read(0);
    trip2 = EEPROM_ulong_read(1);
    trip1_old = trip1;
    u8x8.begin();
    u8x8.setPowerSave(0);
    u8x8.setFont(u8x8_font_victoriabold8_r);
    u8x8.setInverseFont(1);
    u8x8.drawString(0,  0,txtOLED[0]);
    u8x8.setFont(u8x8_font_chroma48medium8_r);
    u8x8.setInverseFont(0);
    for (pin = 1; pin  < 16; pin ++) u8x8.drawString(0,  pin,txtOLED[pin]);
}


void loop(){
    DallasRd();
    if(((millis() - millis_t) >= 20) && digitalRead(ACC)){              // Serial refresh interval in milliseconds if ACC present
        millis_t = millis();
        vo = analogRead(VOLT);
        fu = analogRead(FUEL);
        tm = analogRead(TEMP);
        oi = analogRead(OIL);
        speedometer = (sp/10/100) % 10; speedometer += (sp/10/ 10) % 10; speedometer += (sp/10) % 10;
        tahometer = (th*10/1000) % 10; tahometer += (th*10/100) % 10; tahometer += (th*10/10) % 10; tahometer += (th*10) % 10;
        voltage = (vo/1000) % 10; voltage += (vo/100) % 10; voltage += (vo/10) % 10; voltage += (vo) % 10;
        fuel = (fu/1000) % 10; fuel += (fu/100) % 10; fuel += (fu/10) % 10; fuel += (fu) % 10;
        temperature = (tm/1000) % 10; temperature += (tm/100) % 10; temperature += (tm/10) % 10; temperature += (tm) % 10;
        oil = (oi/1000) % 10; oil += (oi/100) % 10; oil += (oi/10) % 10; oil += (oi) % 10;
        if(ds_tm > 295) dallastemp = "   ";
        else { dallastemp = (ds_tm/10/100) % 10; dallastemp += (ds_tm/10/10) % 10; dallastemp += (ds_tm/10) % 10; }
        mcparray = "";
        for (pin = 0; pin  < 16; pin ++) { mcparray += ","; mcparray += mcp.digitalRead(pin); }
        Serial.print(speedometer + "," + tahometer + "," + voltage + "," + fuel + "," + temperature + "," + dallastemp + mcparray + "," + trip1 + "," + trip2 +":\n");
        // Example output string: 000,0000,1023,1008,1008,022,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,171,54:
        Serial.flush();
        if(tz != 0){tz--;}else{th = 0;}; 
        if(sz != 0){sz--;}else{sp = 0;};
    } 

    if(((millis() - millis_d) >= 100) && digitalRead(ACC)){             // OLED refresh interval in milliseconds if ACC present
        millis_d = millis();
        u8x8.setCursor(8, 2); u8x8.print(speedometer);
        u8x8.setCursor(8, 3); u8x8.print(tahometer);
        u8x8.setCursor(8, 5); u8x8.print(vo * (12.100 / 1024));
        u8x8.setCursor(8, 6); u8x8.print(oil);
        u8x8.setCursor(8, 7); u8x8.print(fuel);
        u8x8.setCursor(8, 8); u8x8.print(temperature);
        u8x8.setCursor(8, 9); u8x8.print(dallastemp);
        u8x8.setCursor(8, 11); u8x8.print(trip1);
        u8x8.setCursor(8, 12); u8x8.print(trip2);
        mcparray = "";
        for (pin=0; pin  < 8; pin ++)  mcparray += mcp.digitalRead(pin);
        u8x8.setCursor(8, 14); u8x8.print(mcparray);
        mcparray = "";
        for (pin=8; pin  < 16; pin ++)  mcparray += mcp.digitalRead(pin);
        u8x8.setCursor(8, 15); u8x8.print(mcparray);
    }
    if (!digitalRead(ACC) && trip1 > trip1_old) {                   // Write EEPROM if not ACC present
        //EEPROM_ulong_write(0, trip1);
        //EEPROM_ulong_write(1, trip2);
        delay(2000);
    }
}

// Speedometer *****************************************************************************************
void spd(){
  if(!st){micros_sp = micros();}
  else   {sp = (3600000/6/(micros() - micros_sp));}                     // Sensor pulses per rotation
  st = !st;
  sz = 30;
  trip1 ++;
  trip2 ++;
}

// Tahometer *******************************************************************************************
void tah(){
  if(!tt){micros_th = micros();}
  else   {th = (30000000/(micros() - micros_th))*2;}
  tt = !tt;
  tz = 10;
}

// Write EEPROM ****************************************************************************************
unsigned long EEPROM_ulong_read(int addr) {
    byte raw[4];
    for(byte i = 0; i < 4; i++) raw[i] = EEPROM.read(addr+i);
    unsigned long &num = (unsigned long&)raw;
    return num;
}

// Read EEPROM *****************************************************************************************
void EEPROM_ulong_write(int addr, unsigned long num) {
    byte raw[4];
    (unsigned long&)raw = num;
    for(byte i = 0; i < 4; i++) EEPROM.write(addr+i, raw[i]);
}

// Temperature sensor DS18B20 **************************************************************************
int DallasRd(){
    byte data[2];
    if ((millis() - millis_ds) > 1000){                             // DS18B20 read interval in milliseconds
        ds.reset(); ds.write(0xCC); ds.write(0xBE);
        data[0] = ds.read(); data[1] = ds.read();
        ds_tm = (data[1] << 8) + data[0];
        ds_tm = (ds_tm >> 4) + 200;
        millis_ds = millis();
        ds.reset(); ds.write(0xCC); ds.write(0x44);              // 2 wire connection - (0x44,1) / 3 wire connection (0x44)
    }
}
