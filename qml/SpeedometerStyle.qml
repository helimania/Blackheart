import QtQuick 2.0
import QtQuick.Controls.Styles 1.4

CircularGaugeStyle {
    labelStepSize: 10
    labelInset: outerRadius / 19.2
    tickmarkInset: outerRadius / 5.2
    minorTickmarkInset: outerRadius / 5.2
    minimumValueAngle: -140     // -144
    maximumValueAngle: 140      // 144
    id: speedStyle

    function degreesToRadians(degrees) {
        return degrees * (Math.PI / 180);
    }


    background: Canvas {
        opacity: valueSource.clusterOpacity*1.5
        antialiasing: true
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
//          paintBackground(ctx);

            ctx.beginPath();
            ctx.strokeStyle = valueSource.clusterColor //"#e5e5e5";
            ctx.lineWidth = 1.5;

            ctx.arc(outerRadius, outerRadius, outerRadius * 0.85 - ctx.lineWidth / 2,
                degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(160) - 90));
            ctx.stroke();
        }
    }


    tickmark: Rectangle {
        radius: width*0.5
        visible: styleData.value < 80 || styleData.value % 10 == 0
        antialiasing: true
        width: 4
        height: 4
        color: valueSource.clusterColor //styleData.value >= 170 ? "#e34c22" : "#c5e5f5"
        opacity: valueSource.clusterOpacity*1.5
    }

    minorTickmark: Rectangle {
        radius: width*0.5
        antialiasing: true
        width: 1
        height: 1
        color: valueSource.clusterColor //"#c5e5f5"
        opacity: valueSource.clusterOpacity*1.5
    }

    tickmarkLabel:  Text {
        font.family: thinkFont.name
        font.pixelSize: 11
        font.letterSpacing: 0
        opacity: valueSource.clusterOpacity
        text: styleData.value
        color: styleData.value >= 170 ? "#922a3c" : valueSource.clusterColor //"#e5e5e5"
        antialiasing: true
    }

    needle: Rectangle {
        id: needleGlow
        y: -outerRadius * 0.48 // 0.15
        antialiasing: true
        width: outerRadius * 0.02
        height: outerRadius * 0.28
        color: "#e51032"
    }

    foreground: Item {
        Rectangle {
            width: outerRadius * 0.9
            height: width
            radius: width / 2
            color: "#222222"
            anchors.centerIn: parent
            border.color: bColor //"#007f8a"
            border.width: 2
            readonly property string bColor: valueSource.speedColor
            Behavior on border.color { ColorAnimation {} }
        }
        Rectangle {
            width: outerRadius * 0.7
            height: 1
            color: "#2e2e2e"
            anchors.centerIn: parent

//****************************************************************************************************************************
            Text {
                id: trip1
                font.pixelSize: 10
                font.family: thinkFont.name
                font.letterSpacing: 1
                text: "TRIP1                    km"   //tempInt
                horizontalAlignment: Text.AlignCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 14
                color: valueSource.clusterColor
                opacity: valueSource.clusterOpacity
            }
            Text {
                font.pixelSize: 11
                text: tripInt
                horizontalAlignment: Text.AlignCenter
                anchors.right: trip1.right
                anchors.top: trip1.top
                anchors.rightMargin: 22
                anchors.topMargin: -1
                color: valueSource.clusterColor
                opacity: valueSource.clusterOpacity*2
                readonly property string tripInt: valueSource.trip1.toFixed(1)
            }
//****************************************************************************************************************************
            Text {
                id: trip2
                font.pixelSize: 10
                font.family: thinkFont.name
                font.letterSpacing: 1
                text: "TRIP2                km"   //tempInt
                horizontalAlignment: Text.AlignCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: trip1.bottom;
                anchors.topMargin: 6
                color: valueSource.clusterColor
                opacity: valueSource.clusterOpacity
            }
            Text {
                font.pixelSize: 11
                text: tripInt
                horizontalAlignment: Text.AlignCenter
                anchors.right: trip2.right
                anchors.top: trip2.top
                anchors.rightMargin: 22
                anchors.topMargin: -1
                color: valueSource.clusterColor
                opacity: valueSource.clusterOpacity*2
                readonly property string tripInt: valueSource.trip2.toFixed(0)
            }
//****************************************************************************************************************************
            Text {
                id: trip3
                font.pixelSize: 10
                font.family: thinkFont.name
                font.letterSpacing: 1
                text: "TRIP3         km"   //tempInt
                horizontalAlignment: Text.AlignCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: trip2.bottom;
                anchors.topMargin: 6
                color: valueSource.clusterColor
                opacity: valueSource.clusterOpacity
             }
            Text {
                font.pixelSize: 11
                text: tripInt
                horizontalAlignment: Text.AlignCenter
                anchors.right: trip3.right
                anchors.top: trip3.top
                anchors.rightMargin: 22
                anchors.topMargin: -1
                color: valueSource.clusterColor
                opacity: valueSource.clusterOpacity*2
                readonly property string tripInt: valueSource.trip3.toFixed(0)
            }
//****************************************************************************************************************************
        }

        Text {                                                              // SPEED
            id: speedText
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height/2-48
            text: kphInt
            font.pixelSize: 40
            color: "#b6b6b6"
            readonly property int kphInt: control.value
        }
        Text {
            font.pixelSize: 11
            font.family: thinkFont.name
            font.letterSpacing: 1
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height/2-72
            text: "km/h"
            color: valueSource.clusterColor
            opacity: valueSource.clusterOpacity
        }
    }


}
