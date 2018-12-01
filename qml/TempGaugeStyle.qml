import QtQuick 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

DashboardGaugeStyle {
    id: tempGaugeStyle
    tickmarkStepSize: 30
    labelStepSize: 30
    labelInset: outerRadius / 19.2
    tickmarkInset: outerRadius / 5.2
    minorTickmarkInset: outerRadius / 5.2
    minimumValueAngle: 115
    maximumValueAngle: 30

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
        color: valueSource.clusterColor
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

            ctx.beginPath();
            ctx.strokeStyle = valueSource.clusterColor;
            ctx.lineWidth = 1.5;

            ctx.arc(outerRadius, outerRadius, outerRadius * 0.85 - ctx.lineWidth / 2,
                    degToRad(valueToAngle(0) - minimumValueAngle-60), degToRad(valueToAngle(120) - minimumValueAngle-250));

            ctx.stroke();
        }
    }
}
