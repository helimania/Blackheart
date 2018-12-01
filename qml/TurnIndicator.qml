import QtQuick 2.2
import QtMultimedia 5.0

Item {
    SoundEffect { id: turnON; source: "../sounds/turn-on.wav" }
    SoundEffect { id: turnOFF; source: "../sounds/turn-off.wav" }

    Item { id: turnOn; visible: turn.on && turn.flashing; onVisibleChanged: if(visible && valueSource.sounds) turnON.play(); }
    Item { id: turnOff; visible: turn.on && turn.flashing; onVisibleChanged: if(!visible && valueSource.sounds) turnOFF.play(); }

    id: turn

    property int direction: Qt.LeftArrow
    property bool on: true
    property bool flashing: true //false

    scale: direction === Qt.LeftArrow ? 1 : -1

    /*
    Timer {
        id: flashTimer
        interval: 500
        running: on
        repeat: true
        onTriggered: flashing = !flashing
    }
    */

    function paintOutlinePath(ctx) {
        ctx.beginPath();
        ctx.moveTo(0, height * 0.5);
        ctx.lineTo(0.6 * width, 0);
        ctx.lineTo(0.6 * width, height * 0.28);
        ctx.lineTo(width, height * 0.28);
        ctx.lineTo(width, height * 0.72);
        ctx.lineTo(0.6 * width, height * 0.72);
        ctx.lineTo(0.6 * width, height);
        ctx.lineTo(0, height * 0.5);
    }

    Canvas {
        id: backgroundCanvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            paintOutlinePath(ctx);

            ctx.lineWidth = 1;
            ctx.strokeStyle = "black";
            ctx.stroke();
        }
    }

    Canvas {
        id: foregroundCanvas
        anchors.fill: parent
        visible: on && flashing
       // Behavior on visible { OpacityAnimator {duration: 100} }

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            paintOutlinePath(ctx);

            ctx.fillStyle = "green";
            ctx.fill();
        }
    }
}
