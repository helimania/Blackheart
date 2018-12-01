# Blackheart
Digital instrument cluster

![preview 1](https://github.com/helimania/Blackheart/blob/master/preview1.jpg)

![preview 2](https://github.com/helimania/Blackheart/blob/master/preview2.jpg)

Requires:
- Raspberry PI Zero
- Atmega328P with Arduino bootloader
- Microchip MCP23017 port expander
- 1.5inch OLED display Module (if needed)
- Buildroot 2018.08.3 or higher
- QT 5.11.1
- А little time and patience

# Prepare Raspberry Pi Zero

Download Buildroot https://buildroot.org/download.html and make raspberry immage using included config and overlays.

I personally flashing image on my Mac OS with Etcher. You may download it here https://www.balena.io/etcher/ or flash image from console.

Edit wpa_supplicant.conf to set up ssid and psk for you WiFi access point.

# Prepare QT 5.11.1
