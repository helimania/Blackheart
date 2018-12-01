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
    width: 800
    height: 480
    color: "#141215"
    title: qsTr("Blackheart ARM V0.3")

    property variant sourceData: [000,0000,1023,1008,1008,022,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,171,22]

    FontLoader{id: thinkFont; source: "../fonts/europe-ex.ttf"}
    ValueSource { id: valueSource; }
    Warnings { id: warnings }

    Canvas {
        id: background
        width: 800; height: 480
        onPaint: {
            var ctx = getContext("2d")
            ctx.lineWidth = 1
            ctx.strokeStyle = "#232323"
            ctx.fillStyle = "#101010"
            ctx.beginPath()
            ctx.moveTo(-1,190)
            ctx.lineTo(130,190)

            ctx.lineTo(280,360)
            ctx.lineTo(520,360)

            ctx.lineTo(670,190)
            ctx.lineTo(801,190)
            ctx.lineTo(801,480)
            ctx.lineTo(-1,480)
            ctx.closePath()
            ctx.fill()
            ctx.stroke()
        }
    }

    Item {
        id: container
        width: 800
        height: 480
        anchors.centerIn: parent

        Indicators {
            id: indicators
        }

        TurnIndicator {                                                 // Turn left indicator
            id: leftIndicator
            anchors.right: speedometerBox.left;
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 20
            width: height
            height: container.height * 0.08
            anchors.verticalCenterOffset: -48

            direction: Qt.LeftArrow
            on: valueSource.turnSignal == Qt.LeftArrow
        }

        Item {
            id: speedometerBox
            width: 380
            height: 380
            y: 15
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: -48
            anchors.verticalCenter: parent.verticalCenter
            Item {
                id: counters
                anchors.horizontalCenter: parent.horizontalCenter
                width: maxSpeed.width;
                height: 60
                anchors.verticalCenterOffset: 126
                anchors.horizontalCenterOffset: 0
                anchors.centerIn: parent
//****************************************************************************************************************************
                Text {
                    id: time0to50
                    font.pixelSize: 11
                    font.family: thinkFont.name
                    font.letterSpacing: 1
                    opacity: valueSource.clusterOpacity
                    text: "   0 . . 50             s"
                    horizontalAlignment: Text.AlignCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    color: valueSource.clusterColor
                }
                Text {
                    font.pixelSize: 11
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
                    font.pixelSize: 11
                    font.family: thinkFont.name
                    font.letterSpacing: 1
                    opacity: valueSource.clusterOpacity
                    text: "0 . . 100             s"
                    horizontalAlignment: Text.AlignCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: time0to50.bottom;
                    anchors.topMargin: 6
                    color: valueSource.clusterColor
                }
                Text {
                    font.pixelSize: 11
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
                    font.pixelSize: 11
                    font.family: thinkFont.name
                    font.letterSpacing: 1
                    opacity: valueSource.clusterOpacity
                    text: "MAX SPEED             km/h"   //tempInt
                    horizontalAlignment: Text.AlignCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: time0to100.bottom;
                    anchors.topMargin: 6
                    color: valueSource.clusterColor
                }
                Text {
                    font.pixelSize: 11
                    text: maxSpeedInt
                    horizontalAlignment: Text.AlignCenter
                    anchors.right: maxSpeed.right
                    anchors.top: maxSpeed.top
                    anchors.rightMargin: 39
                    anchors.topMargin: -1
                    color: valueSource.clusterColor
                    opacity: valueSource.clusterOpacity*2
                    readonly property int maxSpeedInt: valueSource.maxSpeed
                }
//****************************************************************************************************************************
            }

            CircularGauge {                                             // Speedometer gauge
                id: speedometer
                width: 380
                height: 380
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
            anchors.left: speedometerBox.right;
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            width: height
            height: container.height * 0.08
            anchors.verticalCenterOffset: -48

            direction: Qt.RightArrow
            on: valueSource.turnSignal == Qt.RightArrow
        }

        CircularGauge {                                                 // Tahometer gauge
            id: tachometer
            width: 280
            height: width
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            value: valueSource.rpm/1000
            maximumValue: 8
            style: TachometerStyle {}
            Behavior on value {
                NumberAnimation {
                    duration: 300
                }
            }
        }

        Item {
            id: tempANDfuel
            width: 280
            height: width
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            visible: true
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
                anchors.left: parent.left
                anchors.top: parent.top
                maximumValue: 120
                width: 280
                height: width
                value: valueSource.temperature
                visible: true
                style: TempGaugeStyle {}
                Behavior on value {
                    NumberAnimation {
                        duration: 300
                    }
                }
            }

            CircularGauge {                                                 // Fuel gauge
                id: fuelGauge
                anchors.left: parent.left
                anchors.top: parent.top
                maximumValue: 100
                width: 280
                height: width
                value: valueSource.fuel
                style: FuelGaugeStyle {}
                Behavior on value {
                    NumberAnimation {
                        duration: 300
                    }
                }
            }
        }
        /*
        Text {
            id: connect
            font.pixelSize: 10
            font.family: thinkFont.name
            font.letterSpacing: 2
            opacity: valueSource.clusterOpacity
            text: "OIL PRESSURE " + valueSource.oil + " PSI"
            horizontalAlignment: Text.AlignCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 12
            color: valueSource.clusterColor
        }
        */
    }

    SerialPort {
        onSerial_data_Changed: {
            valueSource.connected = "Connected"
            sourceData = "%1".arg(serial_data).split(',')
            //console.log(serial_data)

            valueSource.kph = sourceData[0]                                                                         //  0
            valueSource.rpm = sourceData[1]                                                                         //  1
            valueSource.batt = sourceData[2]* (15.800 / 1024)                                                       //  2
            valueSource.fuel = sourceData[3]                                                                        //  3
            valueSource.temperature = sourceData[4]                                                                 //  4
            valueSource.dallas = sourceData[5]                                                                      //  5
            valueSource.oil = sourceData[6]                                                                         //  6


            if (sourceData[15] === "1") valueSource.turnSignal = Qt.LeftArrow;                                      // 15
            else if (sourceData[16] === "1") valueSource.turnSignal = Qt.RightArrow;                                // 16
            else valueSource.turnSignal = 0;

            if (sourceData[9] === "1") valueSource.fogFLamp = 0.7; else valueSource.fogFLamp = 0.1;                 //  9
            if (sourceData[11] === "1") valueSource.fogRLamp = 0.7; else valueSource.fogRLamp = 0.1;                // 11

            //if (sourceData[17] === "1") valueSource.kph = 999; else valueSource.kph = 0;                          // 17 Revers
            if (sourceData[18] === "1") valueSource.cornersLamp = 0.7; else valueSource.cornersLamp = 0.1;          // 18
            if (sourceData[19] === "1") valueSource.lobeamLamp = 0.7; else valueSource.lobeamLamp = 0.1;            // 19
            if (sourceData[20] === "1") valueSource.hibeamLamp = 0.7; else valueSource.hibeamLamp = 0.1;            // 20

            valueSource.trip1 = sourceData[23]/10;                                                                  // 23
            valueSource.trip2 = sourceData[24]/10;                                                                  // 24

            /*


            if (varLams[6] === "1") valueSource.battLamp = 0.7; else valueSource.battLamp = 0.1;
            if (varLams[7] === "1") valueSource.oilLamp = 0.7; else valueSource.oilLamp = 0.1;

            */
        }
    }

}

