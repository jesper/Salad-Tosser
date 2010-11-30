import Qt 4.7
import Qt.labs.gestures 1.0

Rectangle {
    id:insect
    color: "transparent"
    Image {
        source: "insect.svg"
        sourceSize.height: 50
        sourceSize.width: 50
        fillMode: Image.PreserveAspectFit
        anchors.fill: parent
        smooth: true
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
