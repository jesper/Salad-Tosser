import Qt 4.7

Popup {
    id: menuWindow
    width: mainScreenButton.width + 40

    PopupButton {
        id: returnButton

        x: parent.width/2 - width/2
        y: (parent.height/4) - height/2

        buttonText: "Return"

        MouseArea {
            anchors.fill:  parent
            onClicked:  {
                audio.playReturnToGame();
                menuWindow.opacity = 0;
                countdown.freeze = false
                gamescreen.running = true
            }
        }
    }

    PopupButton {
        id: mainScreenButton
        x: parent.width/2 - width/2
        y: (parent.height/4) * 2 - height/2 + 3
        buttonText: "Main Screen"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                audio.playReturnToMenu();
                menuScreen.opacity = 1
                menuWindow.opacity = 0
                menuScreen.state = ""
            }
        }
    }

    PopupButton {
        id: quitButton
        buttonText: "Quit"
        x: parent.width/2 - width/2
        y: (parent.height/4) * 3 - height/2 + 6

        MouseArea {
            anchors.fill: parent
            onClicked: {
                quitAnimation.start();

            }
        }
    }


}
