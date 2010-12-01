import Qt 4.7

Popup {
    id: gameoverMenu

    PopupButton {
        id: quitButton
        MouseArea {
            anchors.fill: parent
            onClicked: {
                Qt.quit()
            }
        }
    }
}
