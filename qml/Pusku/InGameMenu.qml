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
                audio.playClick();
                menuWindow.opacity = 0;
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
                audio.playClick();
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
                audio.playClick();
                Qt.quit()
            }
        }
    }


}
