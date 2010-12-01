import Qt 4.7

Popup {
    width: parent.width * 0.8
    height: parent.height * 0.8
    anchors.centerIn: parent

    PopupButton {
        id: mainScreenButton
        x: (parent.width/4) * 1 - width/2
        y: (parent.height/4) * 3 - height/4
        buttonText: "Main Screen"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                menuScreen.opacity = 1
                parent.parent.opacity = 0
                // Reset game state
                // FIXME
                menuScreen.state = ""
            }
        }
    }

    PopupButton {
        id: quitButton
        buttonText: "Quit"
        x: (parent.width/4) * 3 - width/2
        y: (parent.height/4) * 3 - height/4

        MouseArea {
            anchors.fill: parent
            onClicked: {
                Qt.quit()
            }
        }
    }

}
