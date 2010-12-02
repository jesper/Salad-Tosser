import Qt 4.7

Popup {
    width: parent.width * 0.8
    height: parent.height * 0.8
    anchors.centerIn: parent

    property string source;
    property string finalScoreText;
    property string highScoreText;

    Image {
        source: parent.source
        width: parent.width * 0.6
        height: parent.width * 0.6
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: scorePlaceholder
        text: "Score:"
        font.pointSize: 24.0
        color: "#E567B1"

        anchors.horizontalCenter: parent.horizontalCenter
        y: 20
    }

    Text {
        id: finalScore

        text: parent.finalScoreText
        font.bold: true
        font.pointSize: 64.0
        color: "#E567B1"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: scorePlaceholder.bottom
    }

    Text {
        id: highScore

        text: parent.highScoreText
        font.bold: true
        font.pointSize: 64.0
        color: "#E567B1"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: finalScore.bottom
    }


    PopupButton {
        id: mainScreenButton
        x: (parent.width/4) * 1 - width/2
        y: parent.height - height * 1.5
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
        y: parent.height - height * 1.5

        MouseArea {
            anchors.fill: parent
            onClicked: {
                audio.playQuit();
                Qt.quit()
            }
        }
    }

}
