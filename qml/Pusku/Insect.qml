import Qt 4.7

Entity {
    id:insect
    property bool killed: false

    signal destroyed;

    Image {
        source: "insect.svg"
        sourceSize.height: 75
        sourceSize.width: 75
        fillMode: Image.PreserveAspectFit
        anchors.fill: parent
        smooth: true
    }

    Behavior on x {
         enabled: insect.placed;
         NumberAnimation {easing.type: Easing.OutInQuad; duration: 100}
     }
    Behavior on y {
         enabled: insect.placed;
         NumberAnimation {easing.type: Easing.OutInQuad; duration: 100}
     }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            if (!killed) {
                killed = true
                insect.state = "dead"
                main.insectKilled();
            }
        }
    }

//    GestureArea {
//        anchors.fill: parent
//        onPan: {console.log("pan gesture")}
//    }

    states: State {
        name: "dead";
        PropertyChanges { target: insect; opacity: 0 }
        PropertyChanges { target: insect; scale: 2 }
    }

    transitions: [
        Transition {
            from: ""
            to: "dead"
            SequentialAnimation {
                NumberAnimation { target: insect; property: "scale"; easing.type: Easing.OutInQuad; duration: 300 }
                NumberAnimation { target: insect; property: "opacity"; duration: 400 }
            }
        }
    ]
}
