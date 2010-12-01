import Qt 4.7

Popup {
    id: menuWindow



    Rectangle {
        id: returnButton
        width: returnScreenText.width + 10
        height: returnScreenText.height + 10
        color: "#CBF76F"
        x: parent.width/2 - width/2
        y: (parent.height/4) - height/2
        radius:10

        Text {
            id: returnScreenText
            text: "Return to Game"
            font.pointSize: 24
            color: "#E567B1"
            x: 5
        }

        MouseArea {
            anchors.fill:  parent
            onClicked:  {
                menuWindow.opacity = 0
            }
        }
    }

    Rectangle {
        id: mainScreenButton
        width: mainScreenText.width + 10
        height: mainScreenText.height + 10
        color: "#CBF76F"
        x: parent.width/2 - width/2
        y: (parent.height/4) * 2 - height/2
        radius:10

        Text {
            id: mainScreenText
            text: "Exit to Main Screen"
            font.pointSize: 24
            color: "#E567B1"
            x: 5
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                menuScreen.opacity = 1
                menuWindow.opacity = 0
                menuScreen.state = ""
            }
        }
    }

    Rectangle {
        id: quitButton
        width: quitText.width + 10
        height: quitText.height + 10
        color: "#CBF76F"
        x: parent.width/2 - width/2
        y: (parent.height/4) * 3 - height/2
        radius:10

        Text {
            id: quitText
            text: "Quit Game"
            font.pointSize: 24
            color: "#E567B1"
            x: 5
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                Qt.quit()
            }
        }
    }


}
