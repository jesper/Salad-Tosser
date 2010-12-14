import Qt 4.7

Entity {
    id: scorpion
    property bool bitten: false
    property int pointsValue: -2


    Text {
        id: pointsText
        text: parent.pointsValue;
        opacity: 1
        anchors.centerIn: parent
        z: parent.z - 3
        smooth: true
        color: "red"
    }

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
        enabled: scorpion.placed;
        NumberAnimation {easing.type: Easing.OutInQuad; duration: scorpion.moveDuration}
    }

    Behavior on y {
        enabled: scorpion.placed;
        NumberAnimation {easing.type: Easing.OutInQuad; duration: scorpion.moveDuration}
    }

    MouseArea {
        id: mouseArea
        enabled: gamescreen.running
        anchors.fill: parent
        anchors.leftMargin: 26
        anchors.rightMargin: 8
        anchors.topMargin: 26
        anchors.bottomMargin: 8
        onClicked: {
            if (!bitten) {
                bitten = true;
                scorpion.state = "pushed"
                main.bittenByInsect(scorpion);
            }
        }
    }

    Timer {
        id: moveTimer
        interval: 4000 + 1000 * Math.random(); running: true; repeat: true
        onTriggered: {
            scorpion.moveDuration = 250;
            if (gamescreen.running)
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
            PropertyChanges { target: scorpion; scale: 1.5 }
            PropertyChanges { target: pointsText; z: parent.z+1; opacity: 0; scale: 2}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "pushed"
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; duration: 300 }
                    NumberAnimation { target: scorpion; property: "opacity"; duration: 400 }
                }
                NumberAnimation { target: pointsText; properties: "scale,opacity,z"; duration: 800 }

            }
        }
    ]
}
