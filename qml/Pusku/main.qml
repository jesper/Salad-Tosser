import Qt 4.7
import "salad.js" as SaladLogic


Item {
    Rectangle {
        id: menuScreen
        color: "#A2EF00"
        anchors.fill:  parent

        Image {
            id: logoImage
            source: "tossmysalad.png"
            fillMode: Image.PreserveAspectFit
            y: height * -1
            x: parent.width/2 - width/2
            PropertyAnimation on y { to: height+10; duration: 1000; easing.type: Easing.OutBounce}
        }

        Rectangle {
            id: startButton
            color: "#CBF76F"
            width: parent.width/2
            height: parent.height/10
            y: parent.height - height - 10
            x: parent.width/2 - width/2
            opacity: 0
            PropertyAnimation on opacity { to: 1; duration: 2000; easing.type: Easing.InOutSine}


            Text {
                anchors.centerIn:  parent
                text: "Start!"
                font.pointSize: 34
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

    function shake() { SaladLogic.shaking() }
}
