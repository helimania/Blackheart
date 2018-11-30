#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFont>
#include <QFontDatabase>

#include "serialport.h"

#define WIDTH   "800"
#define HEIGHT  "480"


int main(int argc, char *argv[])
{
    //
    //Qt environment
    //
    qputenv("QT_QPA_EGLFS_HIDECURSOR", "1");
    qputenv("QT_QPA_EGLFS_DISABLE_INPUT", "1");
    qputenv("FB_MULTI_BUFFER", "2");
    qputenv("QT_QPA_EGLFS_WIDTH", WIDTH);
    qputenv("QT_QPA_EGLFS_HEIGHT", HEIGHT);
    qputenv("QT_QPA_EGLFS_PHYSICAL_WIDTH", WIDTH);
    qputenv("QT_QPA_EGLFS_PHYSICAL_HEIGHT", HEIGHT);

    QGuiApplication app(argc, argv);

    QFontDatabase::addApplicationFont(":/fonts/europedemi.ttf");
    app.setFont(QFont("Europe Demi"));

    qmlRegisterType<SerialPort>("SerialPortLib", 1, 0, "SerialPort");

    QQmlApplicationEngine engine(QUrl("qrc:/qml/BlackheartMain.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
