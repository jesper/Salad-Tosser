import Qt 4.7

Entity {
    id:insect
    property bool killed: false
    property int type: Math.random() < 0.5 ? 0 : 1;
    property alias representation: insectImage.source

    signal destroyed;

    Image {
        id: insectImage
        source: type == 0 ? "insect.svg" : "ladybug.svg"
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
        enabled: gamescreen.running && !insect.killed
        anchors.fill: parent
        anchors.margins: -15
        onClicked: {
            killed = true
            insect.state = "dead"
            main.insectKilled(insect);
        }
    }

    states: State {
        name: "dead";
        PropertyChanges { target: insect; scale: 1.5 }
        PropertyChanges { target: insect; representation: "splash.svg"}
        PropertyChanges { target: insect; opacity: 0.3 }
        PropertyChanges { target: insect; z: 1}
    }

    transitions: [
        Transition {
            from: ""
            to: "dead"
            SequentialAnimation {
                NumberAnimation { target: insect; property: "scale"; easing.type: Easing.OutInQuad; duration: 300 }
                NumberAnimation { target: insect; property: "opacity"; duration: 800 }
            }
        }
    ]
}
