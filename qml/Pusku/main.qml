import Qt 4.7
import "salad.js" as SaladLogic
import QtMobility.sensors 1.1

Rectangle {
    id: gamescreen
    color: "#ddddff"

    Text {
        text: "Pusku Project"
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            SaladLogic.startGame();
            SaladLogic.shaking();
        }
    }

}
