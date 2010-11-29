import Qt 4.7

Rectangle {
    id: about
    color: "#A2EF00"
    anchors.fill:  parent

    Text {
        id: instructionsText
        y: 10
        text: "Start the game by clicking the logo."
        font.underline: true
        font.bold: true
        font.pointSize: 32
        color: "#CB0077"

    }

    Text {
        text: "Game written by..."
        y: instructionsText.height + 50
        color: "#CB0077"
        font.pointSize: 30
        font.italic: true
    }

    Rectangle {
        id: closeButton
        color: "#CBF76F"
        width: 50
        height: 50
        x: parent.width - width
        opacity: 1

        Text {
            id:aboutText
            anchors.centerIn:  parent
            text: "X"
            font.pointSize: 40
            font.bold: true
            color: "#E567B1"
        }

        MouseArea {
            anchors.fill:  parent
            onClicked: {
                about.opacity = 0

            }
        }

    }

    Image {
        id:fabsAvatar
        source: "fabs.png"
        height: 150
        width: 150
        fillMode: Image.PreserveAspectFit
        y: parent.height - height - 30
        x: 0

        Text {
            text: "Fabien"
            y: parent.height
        }
    }


    states: [
        State {
            name: "visible"; when: about.opacity == 1
            PropertyChanges { target: fabsAvatar; x: 500; rotation: 360 }
        }
    ]

    transitions: [
        Transition {
            from: "";
            to: "visible";
            NumberAnimation { target: fabsAvatar; properties: "rotation,x"; duration: 800 }
        }

    ]
}
