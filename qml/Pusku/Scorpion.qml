import Qt 4.7
import "salad.js" as SaladLogic

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

    Behavior on x {
         enabled: true;
         NumberAnimation {easing.type: Easing.OutInQuad; duration: 200}
     }

    Behavior on y {
         enabled: true;
         NumberAnimation {easing.type: Easing.OutInQuad; duration: 200}
     }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            scorpion.state = "pushed"
        }
    }

    Timer {
        id: moveTimer
        interval: 4000 + 1000 * Math.random(); running: true; repeat: true
        onTriggered: {
            SaladLogic.moveScorpion(parent);
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
