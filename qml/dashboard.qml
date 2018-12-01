import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtMultimedia 5.0
import "../variables.js" as Global

import SerialPortLib 1.0

Window {
    id: root
    visible: true
    width: 1024
    height: 550
    color: "#101010"
    title: qsTr("Blackheart ARM kernel V0.2.s1")

    property variant sourceData: [000,0000,0156,0160,0156,0,0,0,0,0,0,0,0,0,0,200,0,0100000011111111111100]

    Image {
        anchors.fill: parent
        source: "qrc:images/qt-bg2.jpg"
        asynchronous: true
        sourceSize {
            width: width
        }
    }

    FontLoader{id: thinkFont; source: "../fonts/europe-ex.ttf"}
    ValueSource { id: valueSource; }
    Warnings { id: warnings }

    Item {
        id: container
        width: 1024
        height: 550
        anchors.centerIn: parent

        Indicators {
            id: indicators
        }

        TurnIndicator {                                                 // Turn left indicator
            id: leftIndicator
            x: 207
            y: 208
            anchors.verticalCenter: parent.verticalCenter
            width: height
            height: container.height * 0.08
            anchors.verticalCenterOffset: -48

            direction: Qt.LeftArrow
            on: valueSource.turnSignal == Qt.LeftArrow
        }

        Item {
            id: speedometerBox
            width: 420
            height: 420
            x: 302
            y: 15
            anchors.verticalCenterOffset: -48
            anchors.verticalCenter: parent.verticalCenter
            Item {
                id: counters
                x: 135
                y: 328
                width: 150
                height: 60
                anchors.verticalCenterOffset: 138
                anchors.horizontalCenterOffset: 0
                anchors.centerIn: parent
//****************************************************************************************************************************
                Text {
                    id: time0to50
                    font.pixelSize: 12
                    font.family: thinkFont.name
                    font.letterSpacing: 1
                    opacity: valueSource.clusterOpacity
                    text: "   0 . . 50                s"
                    horizontalAlignment: Text.AlignCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    color: valueSource.clusterColor
                }
                Text {
                    font.pixelSize: 14
                    text: t0to50  //"--.-"
                    horizontalAlignment: Text.AlignCenter
                    anchors.right: time0to50.right
                    anchors.top: time0to50.top
                    anchors.rightMargin: 12
                    anchors.topMargin: -1
                    color: valueSource.clusterColor
                    opacity: valueSource.clusterOpacity*2
                    readonly property string t0to50: valueSource.i0to50 //.toFixed(2)
                }
//****************************************************************************************************************************
                Text {
                    id: time0to100
                    font.pixelSize: 12
                    font.family: thinkFont.name
                    font.letterSpacing: 1
                    opacity: valueSource.clusterOpacity
                    text: "0 . . 100                s"
                    horizontalAlignment: Text.AlignCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 22
                    color: valueSource.clusterColor
                }
                Text {
                    font.pixelSize: 14
                    text: t0to100 //"--.-"
                    horizontalAlignment: Text.AlignCenter
                    anchors.right: time0to100.right
                    anchors.top: time0to100.top
                    anchors.rightMargin: 12
                    anchors.topMargin: -1
                    color: valueSource.clusterColor
                    opacity: valueSource.clusterOpacity*2
                    readonly property string t0to100: valueSource.i0to100 //.toFixed(2)
                }
//****************************************************************************************************************************
                Text {
                    id: maxSpeed
                    font.pixelSize: 12
                    font.family: thinkFont.name
                    font.letterSpacing: 1
                    opacity: valueSource.clusterOpacity
                    text: "MAX SPEED                km/h"   //tempInt
                    horizontalAlignment: Text.AlignCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 44
                    color: valueSource.clusterColor
                }
                Text {
                    font.pixelSize: 14
                    text: maxSpeedInt
                    horizontalAlignment: Text.AlignCenter
                    anchors.right: maxSpeed.right
                    anchors.top: maxSpeed.top
                    anchors.rightMargin: 36
                    anchors.topMargin: -1
                    color: valueSource.clusterColor
                    opacity: valueSource.clusterOpacity*2
                    readonly property int maxSpeedInt: valueSource.maxSpeed
                }
            }

            CircularGauge {                                             // Speedometer gauge
                id: speedometer
                width: 420
                height: 420
                value: valueSource.kph
                maximumValue: 160
                style: SpeedometerStyle {}
                Behavior on value {
                    NumberAnimation {
                        duration: 300
                    }
                }
            }
        }

        TurnIndicator {                                                 // Turn right indicator
            id: rightIndicator
            x: 775
            y: 215
            anchors.verticalCenter: parent.verticalCenter
            width: height
            height: container.height * 0.08
            anchors.verticalCenterOffset: -48

            direction: Qt.RightArrow
            on: valueSource.turnSignal == Qt.RightArrow
        }

        CircularGauge {                                                 // Tahometer gauge
            id: tachometer
            x: 23
            y: 358
            width: 320
            height: 320
            anchors.verticalCenterOffset: 94
            value: valueSource.rpm
            maximumValue: 8
            anchors.verticalCenter: parent.verticalCenter
            style: TachometerStyle {}
            Behavior on value {
                NumberAnimation {
                    duration: 300
                }
            }
        }

        Item {
            id: tempANDfuel
            x: 679
            y: 352
            width: height
            height: 320
            visible: true
            anchors.verticalCenterOffset: 94
            anchors.verticalCenter: parent.verticalCenter
            Image {
                anchors.fill: parent
                source: "qrc:images/half-bg.png"
                asynchronous: true
                mirror: true
                sourceSize {
                    width: width
                }
            }

            CircularGauge {
                id: tempGauge
                x: 0
                y: 0                                             // Temperature gaugess
                maximumValue: 120
                width: parent.width
                height: 320
                value: valueSource.temperature
                visible: true
                style: TempGaugeStyle {}
            }

            CircularGauge {                                                 // Fuel gauge
                id: fuelGauge
                x: 0
                y: 0
                width: 320
                height: 320
                value: valueSource.fuel
                maximumValue: 100
                style: FuelGaugeStyle {}
            }


        }


        SerialPort {
            onSerial_data_Changed: {
                sourceData = "%1".arg(serial_data).split(',')
                console.log(serial_data)
                valueSource.kph = sourceData[0]
                valueSource.rpm = sourceData[1]/1000
                valueSource.batt = sourceData[2]/68.9
                valueSource.fuel = sourceData[3]/10
                valueSource.temperature = sourceData[4]/10
            }
        }

        /*
        Row {
            id: gaugeRow
            width: 568
            height: 420
            anchors.verticalCenterOffset: -21
            anchors.horizontalCenterOffset: -13
            spacing: container.width * 0.02
            anchors.centerIn: parent

        }
        */


    }
}

