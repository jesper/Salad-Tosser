import Qt 4.7

Rectangle {
    id: about
    color: "#A2EF00"
    anchors.fill:  parent

    Text {
        id: instructionsText
        y: 20
        x: parent.width/2 - width/2
        text: "Start the game by clicking the logo."
        font.underline: true
        font.bold: true
        font.pointSize: 28
        color: "#CB0077"

    }

    Text {
        text: "Game written by..."
        y: instructionsText.height + 100
        x: parent.width/2 - width/2
        color: "#CB0077"
        font.pointSize: 28
        font.italic: true
    }

    Rectangle {
        id: closeButton
        color: "#CBF76F"
        width: 75
        height: 75
        x: parent.width - width
        opacity: 1
        radius:10

        Text {
            id:aboutText
            anchors.centerIn:  parent
            text: "X"
            font.pointSize: 60
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
        y: parent.height - height - 50
        x: width * -1

        Text {
            text: "Fabien"
            y: parent.height
            x: parent.width/2 - width/2
        }
    }

    Image {
        id:sammiAvatar
        source: "sammi.png"
        height: 150
        width: 150
        fillMode: Image.PreserveAspectFit
        y: parent.height - height - 50
        x: width * -1

        Text {
            text: "Samuel"
            y: parent.height
            x: parent.width/2 - width/2
        }
    }

    Image {
        id:jefeAvatar
        source: "jefe.png"
        height: 150
        width: 150
        fillMode: Image.PreserveAspectFit
        y: parent.height - height - 50
        x: width * -1

        Text {
            text: "Jesper"
            y: parent.height
            x: parent.width/2 - width/2
        }
    }

    states: [
        State {
            name: "visible"; when: about.opacity == 1
            PropertyChanges { target: fabsAvatar; x: (about.width/4)*3-fabsAvatar.width/2; rotation: 360 }
            PropertyChanges { target: sammiAvatar; x: (about.width/4)*2-sammiAvatar.width/2; rotation: 360 }
            PropertyChanges { target: jefeAvatar; x: (about.width/4)-jefeAvatar.width/2; rotation: 360 }
        }
    ]

    transitions: [
        Transition {
            from: "";
            to: "visible";
            SequentialAnimation {
                NumberAnimation { target: fabsAvatar; properties: "rotation,x"; duration: 800 }
                NumberAnimation { target: sammiAvatar; properties: "rotation,x"; duration: 800 }
                NumberAnimation { target: jefeAvatar; properties: "rotation,x"; duration: 800 }
            }
        }

    ]
}
