import Qt 4.7
import Qt.labs.gestures 1.0

Rectangle {
    id:insect
    color: "transparent"
    Image {
        source: "/Users/fabien/Desktop/Pusku/insect.svg"
        anchors.fill: parent
    }


    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            insect.state = "dead"
        }
    }
    states: State {
        name: "dead";
        PropertyChanges { target: insect; opacity: 0 }
    }

    transitions: [
        Transition {
            from: ""
            to: "dead"
            NumberAnimation { target: insect; property: "opacity"; duration: 200 }
        }
    ]
}
