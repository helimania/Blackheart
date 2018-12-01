import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtMultimedia 5.0
import "../variables.js" as Global


Rectangle {
    id: lamp
    width: 320
    height: 38
    anchors.centerIn: parent
    color: "#141215";
    anchors.verticalCenterOffset: 170
    border.color: "#232323"
    border.width: 1

    Image {
        id: batt
        x: 10
        source: "qrc:images/batt.png"
        asynchronous: true
        opacity: valueSource.battLamp
        Behavior on opacity { OpacityAnimator {duration: 100} }
        sourceSize {
            width: 38
            height: height
        }
    }

    Image {
        id: oil
        anchors.left: batt.right;
        source: "qrc:images/oil.png"
        asynchronous: true
        opacity: valueSource.oilLamp
        Behavior on opacity { OpacityAnimator {duration: 100} }
        sourceSize {
            width: 38
            height: height
        }
    }

    Image {
        id: corners
        anchors.left: oil.right;
        source: "qrc:images/corners.png"
        asynchronous: true
        opacity: valueSource.cornersLamp
        Behavior on opacity { OpacityAnimator {duration: 100} }
        sourceSize {
            width: 38
            height: height
        }
    }

    Image {
        id: loBeam
        anchors.left: corners.right;
        source: "qrc:images/lobeam.png"
        asynchronous: true
        opacity: valueSource.lobeamLamp
        Behavior on opacity { OpacityAnimator {duration: 100} }
        sourceSize {
            width: 38
            height: height
        }
    }

    Image {
        id: hiBeam
        anchors.left: loBeam.right;
        source: "qrc:images/hibeam.png"
        asynchronous: true
        opacity: valueSource.hibeamLamp
        Behavior on opacity { OpacityAnimator {duration: 100} }
        sourceSize {
            width: 38
            height: height
        }
    }

    Image {
        id: fogF
        anchors.left: hiBeam.right;
        source: "qrc:images/fogs.png"
        asynchronous: true
        opacity: valueSource.fogFLamp
        Behavior on opacity { OpacityAnimator {duration: 100} }
        sourceSize {
            width: 38
            height: height
        }
    }
    Image {
        id: fogR
        anchors.left: fogF.right;
        source: "qrc:images/tailfogs.png"
        asynchronous: true
        opacity: valueSource.fogRLamp
        Behavior on opacity { OpacityAnimator {duration: 100} }
        sourceSize {
            width: 38
            height: height
        }
    }

    Image {
        id: fuel
        anchors.left: fogR.right;
        source: "qrc:images/fuel.png"
        asynchronous: true
        opacity: valueSource.fuelLamp
        Behavior on opacity { OpacityAnimator {duration: 100} }
        sourceSize {
            width: 38
            height: height
        }
    }

}
