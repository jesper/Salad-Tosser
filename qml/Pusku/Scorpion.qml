import Qt 4.7

Rectangle {
    id: scorpion
    color: "transparent"

    Image {
        source: "scorpion.svg"
        sourceSize.height: 80
        sourceSize.width: 80
        smooth: true

        fillMode: Image.PreserveAspectFit
        anchors.fill: parent
    }

    property real moveDuration: 100;

    Behavior on x {
         enabled: true;
         NumberAnimation {easing.type: Easing.OutInQuad; duration: scorpion.moveDuration}
     }

    Behavior on y {
         enabled: true;
         NumberAnimation {easing.type: Easing.OutInQuad; duration: scorpion.moveDuration}
     }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            scorpion.state = "pushed"
//            scorpion.state = "triggered"
            main.bittenByInsect();
        }
    }

    Timer {
        id: moveTimer
        interval: 4000 + 1000 * Math.random(); running: true; repeat: true
        onTriggered: {
            scorpion.moveDuration = 250;
            main.moveScorpion(parent);
        }
    }

    Timer {
        id: calmDownTimer
        interval: 4000; running: false; repeat: false
        onTriggered: {
            moveTimer.interval = 4000 + 1000 * Math.random();
        }
    }

    function shake() {
        if (state != "pushed") {
            scorpion.moveDuration = 100;
            moveTimer.interval = 500 + 200 * Math.random();
            shakeAnimation.restart();
        }
    }

    SequentialAnimation {
        id: shakeAnimation
        ScriptAction { script: moveTimer.stop(); }
        PauseAnimation { duration: 200 }
        NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; to: 1.2; duration: 50 }
        NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; to: 1.0; duration: 50 }
        NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; to: 1.2; duration: 50 }
        NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; to: 1.0; duration: 50 }
        NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; to: 1.2; duration: 50 }
        NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; to: 1.0; duration: 50 }
        NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; to: 1.2; duration: 50 }
        NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; to: 1.0; duration: 50 }
        NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; to: 1.2; duration: 50 }
        NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; to: 1.0; duration: 50 }
        NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; to: 1.2; duration: 50 }
        NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; to: 1.0; duration: 50 }
        ScriptAction { script: { moveTimer.restart(); calmDownTimer.restart(); } }
    }

    states: [
        State {
            name: "pushed";
            PropertyChanges { target: scorpion; opacity: 0 }
            PropertyChanges { target: scorpion; scale: 2 }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "pushed"
            SequentialAnimation {
                NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; duration: 300 }
                NumberAnimation { target: scorpion; property: "opacity"; duration: 400 }
            }
        }
    ]
}
