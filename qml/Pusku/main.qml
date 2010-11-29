import Qt 4.7
import "salad.js" as SaladLogic


Item {
    Rectangle {
        id: menuScreen
        color: "#A2EF00"
        anchors.fill:  parent


        Text {
            id: logoText
            text:"Toss my Salad!"
            font.pointSize: 64
            x: parent.width/2 - width/2
            color: "#CB0077"
            Text {
                id: logoTextShadow
                text: parent.text
                font.pointSize: parent.font.pointSize
                y: y+4
                x: x+4
                z: parent.z - 1
                opacity: 0.7
            }
        }

        Rectangle {
            id: startButton
            color: "#CBF76F"
            width: parent.width/2
            height: parent.height/10
            anchors.centerIn: parent

            Text {
                anchors.centerIn:  parent
                text: "Start!"
                font.pointSize: 32
                color: "#E567B1"
            }

            MouseArea {
                anchors.fill:  parent
                onClicked: {
                    SaladLogic.startGame();
                    gamescreen.opacity = 1
                    menuScreen.opacity = 0
                }
            }

        }
    }


    Rectangle {
        id: gamescreen
        color: "#ddddff"
        opacity: 0
        anchors.fill:  parent
        MouseArea {
            anchors.fill: parent
            onClicked: {
                SaladLogic.shaking();
            }
        }

    }
}
