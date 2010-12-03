import Qt 4.7

Text {
    property int increment: 0;
    property int sign: 1;

    id: scoreIncrement;
    text: sign > 0 ? "+" + increment : "-" + increment;
    color: "white";

    x: scoreText.x + 80;
    y: scoreText.y;
    z: 500;

    function startAnimation() {
        scoreIncrementAnimation.start();
    }


    ParallelAnimation {
        id: scoreIncrementAnimation;

        NumberAnimation { target: scoreIncrement; property: "opacity"; easing.type: Easing.InCubic; to: 0; duration: 600 }
        NumberAnimation { target: scoreIncrement; property: "x"; easing.type: Easing.Linear; to: countdownText.x; duration: 600 }

        SequentialAnimation {
            SequentialAnimation {
                loops: increment

                PauseAnimation { duration: 200 }
                ScriptAction { script: scoreBox.score += sign; }
            }

            ScriptAction { script: main.destroyScoreIncrement(scoreIncrement); }
        }
    }
}
