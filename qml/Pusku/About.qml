import Qt 4.7

Rectangle {
    id: about
    color: "#A2EF00"
    anchors.fill:  parent
    opacity:0

    MouseArea {
        anchors.fill: parent
    }


    Text {
        id: instructionsText1
        y: 20
        x: 20
        text: "Shake the salad..."
        font.underline: true
        font.bold: true
        font.pixelSize: parent.height/13
        color: "#CB0077"

    }

    Text {
        id: instructionsText2
        y: 20 + instructionsText1.height
        x: instructionsText1.x + instructionsText1.width/5 * 4
        text: "squash bugs..."
        font.underline: true
        font.bold: true
        font.pixelSize: parent.height/13
        color: "#CB0077"

    }

    Text {
        id: instructionsText3
        y: 20 + instructionsText1.height + instructionsText2.height
        x: instructionsText2.x + instructionsText2.width/5 * 4
        text: "avoid scorpions!"
        font.underline: true
        font.bold: true
        font.pixelSize: parent.height/13
        color: "#CB0077"

    }

    Text {
        text: "Game written by..."
        y: instructionsText3.y + instructionsText3.height + 30
        x: parent.width/2 - width/2
        color: "#CB0077"
        font.pixelSize: parent.height/13
        font.italic: true
    }

    CloseButton {
        MouseArea {
            anchors.fill:  parent
            onClicked: {
                about.state = ""
            }
        }
    }

    Image {
        id:fabsAvatar
        source: "fabs.png"
        height: parent.height/3
        width: parent.height/3
        fillMode: Image.PreserveAspectFit
        y: parent.height - height - 50
        x: width * -1

        Text {
            text: "Fabien"
            y: parent.height
            x: parent.width/2 - width/2
        }

        MouseArea {
            anchors.fill: parent
            onClicked: { audio.playLevelUp(); }
        }
    }

    Image {
        id:sammiAvatar
        source: "sammi.png"
        height: parent.height/3
        width: parent.height/3
        fillMode: Image.PreserveAspectFit
        y: parent.height - height - 50
        x: width * -1

        Text {
            text: "Samuel"
            y: parent.height
            x: parent.width/2 - width/2
        }

        MouseArea {
            anchors.fill: parent
            onClicked: { audio.playAbout(); }
        }
    }

    Image {
        id:jefeAvatar
        source: "jefe.png"
        height: parent.height/3
        width: parent.height/3
        fillMode: Image.PreserveAspectFit
        y: parent.height - height - 50
        x: width * -1

        Text {
            text: "Jesper"
            y: parent.height
            x: parent.width/2 - width/2
        }

        MouseArea {
            anchors.fill: parent
            onClicked: { audio.playArite(); }
        }
    }

    states: [
        State {
            name: "visible";
            PropertyChanges { target: fabsAvatar; x: (about.width/4)*3-fabsAvatar.width/2; rotation: 360 }
            PropertyChanges { target: sammiAvatar; x: (about.width/4)*2-sammiAvatar.width/2; rotation: 360 }
            PropertyChanges { target: jefeAvatar; x: (about.width/4)-jefeAvatar.width/2; rotation: 360 }
            PropertyChanges { target: about; opacity: 1;}

        }
    ]

    transitions: [
        Transition {
            from: "";
            to: "visible";
            SequentialAnimation {
                NumberAnimation { target: about; property: "opacity"; duration: 1000 }
                NumberAnimation { target: fabsAvatar; properties: "rotation,x"; duration: 1000 }
                NumberAnimation { target: sammiAvatar; properties: "rotation,x"; duration: 1000 }
                NumberAnimation { target: jefeAvatar; properties: "rotation,x"; duration: 1000 }

            }},
            Transition {
                from: "visible";
                to: "";
                SequentialAnimation {
                    NumberAnimation { target: about; property: "opacity"; duration: 1000 }
                }
            }

    ]
        }
