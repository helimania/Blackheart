#!/bin/bash

~/rpi/qt5/bin/qmake
make
scp Blackheart root@192.168.1.116:/root
ssh -t root@192.168.1.116 "./Blackheart"
