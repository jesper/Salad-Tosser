import Qt 4.7

Popup {
    id: menuWindow

    PopupButton {
        id: returnButton

        x: parent.width/2 - width/2
        y: (parent.height/4) - height/2

        buttonText: "Return to Game"

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
        y: (parent.height/4) * 2 - height/2
        buttonText: "Exit to Main Screen"

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
        y: (parent.height/4) * 3 - height/2

        MouseArea {
            anchors.fill: parent
            onClicked: {
                audio.playQuit();
                Qt.quit()
            }
        }
    }


}
