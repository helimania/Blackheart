cache()
TEMPLATE += app
QT += quick serialport
QT -= network xml
CONFIG += c++11

TARGET = Blackheart
INCLUDEPATH += .

SOURCES += \
    main.cpp \
    serialport.cpp

RESOURCES += \
    dashboard.qrc

OTHER_FILES += \
    qml/BlackheartMain.qml \
    qml/DashboardGaugeStyle.qml \
    qml/SpeedometerStyle.qml \
    qml/FuelGaugeStyle.qml \
    qml/TempGaugeStyle.qml \
    qml/TachometerStyle.qml \
    qml/TurnIndicator.qml \
    qml/Indicators.qml \
    qml/Warnings.qml \
    qml/ValueSource.qml

INSTALLS = target
target.path = /root


Release:DESTDIR = release

Debug:DESTDIR = debug

HEADERS += \
    serialport.h



