import Qt 4.7

Text {
    id: timeBonus;
    text: "+3s"
    color: "white";

    x: countdownText.x + 80;
    y: countdownText.y;
    z: 500;

    function startAnimation() {
        timeBonusAnimation.start();
    }


    ParallelAnimation {

            id: timeBonusAnimation;

            NumberAnimation { target: timeBonus; property: "opacity"; easing.type: Easing.InCubic; to: 0; duration: 600 }
            NumberAnimation { target: timeBonus; property: "x"; easing.type: Easing.Linear; to: countdownText.x; duration: 600 }

            SequentialAnimation {
                PauseAnimation { duration: 200 }
                ScriptAction { script: main.increaseTimer(); }
                PauseAnimation { duration: 200 }
                ScriptAction { script: main.increaseTimer(); }
                PauseAnimation { duration: 200 }
                ScriptAction { script: main.increaseTimer(); }

                ScriptAction { script: main.destroyTimeBonus(timeBonus); }
            }
    }
}
