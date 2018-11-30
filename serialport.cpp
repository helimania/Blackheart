//
// https://github.com/eyllanesc/stackoverflow/tree/master/Arduino-QML
//
// sudo stty -F /dev/ttyACM0 115200 && sudo chmod 666 /dev/ttyACM0
//
#include "serialport.h"
#include <QDebug>

SerialPort::SerialPort(QObject *parent):QObject(parent)
{
    arduino = new QSerialPort(this);
    connect(arduino, &QSerialPort::readyRead, this, &SerialPort::onReadData);
    openDefault();
}

SerialPort::~SerialPort()
{
    delete arduino;
}

void SerialPort::set_serial_data(QString newValue)
{
    mSerial_data = newValue;
    emit serial_data_Changed(mSerial_data);
}

void SerialPort::onReadData()
{
    while (arduino->canReadLine()) {
        QByteArray data = arduino->readLine();
        QString value = QString(data).trimmed();
        set_serial_data(value);
    }
}


void SerialPort::openDefault()
{
    arduino->setPortName("/dev/ttyAMA0");
    arduino->setBaudRate(QSerialPort::Baud115200);
    if (arduino->open(QSerialPort::ReadOnly))
        qDebug()<<"Connected to:"<< arduino->portName();
    else
        qCritical()<<"Serial Port error: " << arduino->errorString();
}

QString SerialPort::get_serial_data() const
{
    return mSerial_data;
}
