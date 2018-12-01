# Blackheart
Digital instrument cluster

![preview 1](https://github.com/helimania/Blackheart/blob/master/preview1.jpg)

Requires:
- Raspberry PI Zero
- Atmega328P with Arduino bootloader
- Microchip MCP23017 port expander
- 1.5inch OLED display Module (if needed)
- Buildroot 2018.08.3 or higher
- QT 5.11.1
- А little time and patience

# Schematic

However, I did not redraw the scheme for this project, but I hope you will understand how it should look.

![schematic](https://github.com/helimania/Blackheart/blob/master/ProMini-v2-OLED-Pi/ProMini-v1-schematic.jpg)

Arduino and Raspberry connected with only one wire TX (arduino) -> RX (raspberry) and scheme taken from here https://elinux.org/RPi_GPIO_Interface_Circuits

# Prepare QT 5.11.1

Get raspbian images from here https://www.raspberrypi.org/downloads/raspbian/ and follow an official installation guide to boot it up.

[RPI]

```ruby
sudo raspi-config (enable SSH, disable X windows, setup network)
sudo passwd root (setup root password)
sudo rpi-update
sudo reboot

sudo nano /etc/apt/sources.list (uncomment deb-src)
sudo apt-get update
sudo apt-get upgrade
sudo reboot

sudo apt-get build-dep qt4-x11
sudo apt-get build-dep libqt5gui5
sudo apt-get install libudev-dev libinput-dev libts-dev libxcb-xinerama0-dev libxcb-xinerama0

sudo mkdir /usr/local/qt5pi
sudo chmod -R 777 /usr/local/qt5pi
```

[HOST]

```ruby
sudo apt-get install lib32z1 lib32ncurses5 lib32stdc++6

mkdir ~/raspi
cd ~/raspi

git clone https://github.com/raspberrypi/tools

ssh-keygen -t rsa -C pi@raspberrypi.local -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | ssh -o StrictHostKeyChecking=no pi@raspberrypi.local "mkdir -p .ssh && chmod 700 .ssh && cat >> .ssh/authorized_keys"

mkdir sysroot sysroot/usr sysroot/opt
rsync -avz pi@raspberrypi.local:/lib sysroot
rsync -avz pi@raspberrypi.local:/usr/include sysroot/usr
rsync -avz pi@raspberrypi.local:/usr/lib sysroot/usr
rsync -avz pi@raspberrypi.local:/opt/vc sysroot/opt

wget https_://raw.githubusercontent.com/riscv/riscv-poky/priv-1.10/scripts/sysroot-relativelinks.py
chmod +x sysroot-relativelinks.py
./sysroot-relativelinks.py sysroot

git clone git://code.qt.io/qt/qtbase.git -b 5.11
cd qtbase

./configure -no-gbm -no-glib -no-gstreamer -qt-xcb -no-pch -no-zlib -no-use-gold-linker -release -opengl es2 -device linux-rasp-pi-g++ -device-option CROSS_COMPILE=~/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf- -sysroot ~/raspi/sysroot -opensource -confirm-license -make libs -prefix /usr/local/qt5pi -extprefix ~/raspi/qt5pi -hostprefix ~/raspi/qt5 -v

make -j4
make install
```

# Prepare Raspberry Pi Zero

Download Buildroot https://buildroot.org/download.html and make raspberry immage using included config and overlays.

I personally flashing image on my Mac OS with Etcher. You may download it here https://www.balena.io/etcher/ or flash image from console.

Edit wpa_supplicant.conf to set up ssid and psk for you WiFi access point.

# Example for make and run application

```ruby

cd ~
git clone https://github.com/helimania/Blackheart.git
cd Blackheart

~/raspi/qt5/bin/qmake
make
scp Blackheart root@192.168.1.116:/root
ssh -t root@192.168.1.116 "./Blackheart"
```

After reboot, application runs automaticaly.

![preview 2](https://github.com/helimania/Blackheart/blob/master/preview2.jpg)

