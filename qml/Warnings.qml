import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtMultimedia 5.0
import "../variables.js" as Global


Item {
    SoundEffect { id: playWarning; source: "../sounds/warning.wav" }
    SoundEffect { id: tahoWarning; source: "../sounds/purr.wav" }

    Item { id: speedWarning; visible: valueSource.playSpeed; onVisibleChanged: if(visible && valueSource.sounds) playWarning.play(); }
    Item { id: fuelWarning; visible: valueSource.playFuel; onVisibleChanged: if(visible && valueSource.sounds) playWarning.play(); }
    Item { id: temperatureWarning; visible: valueSource.playTemp; onVisibleChanged: if(visible && valueSource.sounds) playWarning.play(); }
    Item { id: batteryWarning; visible: valueSource.playBatt; onVisibleChanged: if(visible && valueSource.sounds) playWarning.play(); }
    Item { id: tahometerWarning; visible: valueSource.playTaho; onVisibleChanged: if(visible && valueSource.sounds) tahoWarning.play(); }

}
