import QtQuick 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

DashboardGaugeStyle {
    id: fuelGaugeStyle
    tickmarkStepSize: 25
    labelStepSize: 25
    labelInset: outerRadius / 19.2
    tickmarkInset: outerRadius / 5.2
    minorTickmarkInset: outerRadius / 5.2
    minimumValueAngle: 125
    maximumValueAngle: 210

    needleLength: toPixels(0.85)
    needleBaseWidth: toPixels(0.08)
    needleTipWidth: toPixels(0.03)




    tickmark: Rectangle {
        radius: width*0.5
        visible: styleData.value < 80 || styleData.value % 10 == 0
        implicitWidth: 4
        antialiasing: true
        implicitHeight: 4
        color: valueSource.clusterColor
        opacity: valueSource.clusterOpacity*1.5
    }

    minorTickmark: Rectangle {
        radius: width*0.5
        implicitWidth: 1
        antialiasing: true
        implicitHeight: 1
        color:valueSource.clusterColor
        opacity: valueSource.clusterOpacity*1.5
    }

    tickmarkLabel: Text {
        font.pixelSize: 11
        font.letterSpacing: 0
        opacity: valueSource.clusterOpacity
        font.family: thinkFont.name
        text: styleData.value
        color: valueSource.clusterColor
        antialiasing: true
    }

    needle: Rectangle {
        y: -outerRadius * 0.50 //0.15
        implicitWidth: outerRadius * 0.023
        implicitHeight: outerRadius * 0.25 //0.90
        antialiasing: true
        color: "#e51032"
    }

    background: Canvas {
        opacity: valueSource.clusterOpacity*1.5
        antialiasing: true
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
//            paintBackground(ctx);

            ctx.beginPath();
            ctx.strokeStyle = valueSource.clusterColor;
            ctx.lineWidth = 1.5;

            ctx.arc(outerRadius, outerRadius, outerRadius * 0.85 - ctx.lineWidth / 2,
                    degToRad(valueToAngle(0) - minimumValueAngle+25), degToRad(valueToAngle(100) - minimumValueAngle+35)); // +35 +35

            ctx.stroke();
        }
    }

    foreground: Item {
        Rectangle {
            width: outerRadius * 0.9
            height: width
            radius: width / 2
            color: "#222222"
            anchors.centerIn: parent
            border.color: bColor //"#007f8a" //"#da243d"
            border.width: 2
            readonly property string bColor: valueSource.fuelColor
            Behavior on border.color { ColorAnimation {} }

            Text {
                id: tText
                text: "TEMP"
                color: valueSource.clusterColor
                font.pixelSize: 11
                opacity: valueSource.clusterOpacity
                font.family: thinkFont.name
                font.letterSpacing: 0.5
                y: parent.height/2-50
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: tempText
                font.pixelSize: 20
                text: tempInt
                horizontalAlignment: Text.AlignCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: tText.bottom;
                anchors.topMargin: 7
                color: tColor //"#b6b6b6"
                //antialiasing: true
                readonly property int tempInt: valueSource.temperature
                readonly property string tColor: valueSource.tempTxtColor
                Behavior on color { ColorAnimation {} }
            }

            Text {
                id: fuelText
                text: fuelInt
                color: tColor // "#b6b6b6"
                font.pixelSize: 20
                y: parent.height/2+8
                anchors.horizontalCenter: parent.horizontalCenter
                readonly property int fuelInt: valueSource.fuel
                readonly property string tColor: valueSource.fuelTxtColor
                Behavior on color { ColorAnimation {} }
            }

            Text {
                text: "LITERS"
                color: valueSource.clusterColor
                font.pixelSize: 11
                opacity: valueSource.clusterOpacity
                font.family: thinkFont.name
                font.letterSpacing: 0.5
                y: parent.height/2+38
                anchors.horizontalCenter: parent.horizontalCenter
            }

        }
        Rectangle {
            width: outerRadius * 0.7
            height: 1
            color: "#2e2e2e"
            anchors.centerIn: parent
        }

    }

}
