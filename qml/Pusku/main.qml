import Qt 4.7
import "salad.js" as SaladLogic


Item {
    width: helper.getScreenWidth();
    height: helper.getScreenHeight();

    id: main

    InGameMenu {
        id: inGameMenu
        z: menuScreen.z + 1
        anchors.centerIn: parent
        opacity: 0
    }


    /*-------------.
    | Title screen |
    `-------------*/
    Rectangle {
        id: menuScreen
        color: "#A2EF00"
        anchors.fill:  parent
        z: gamearea.z + 1


        Image {
            id: logoImage
            source: "tossmysalad.png"
            smooth: true
            height: parent.height/3 * 2
            width: parent.width/3 * 2
            fillMode: Image.PreserveAspectFit
            y:height * -1
            x:menuScreen.width/2 - width/2
            PropertyAnimation on y { to:((main.height/2) - (logoImage.height/2)); duration: 2000; easing.type: Easing.OutBounce}


            SequentialAnimation on scale {
                loops: Animation.Infinite;
                PropertyAnimation { to:1.05; duration: 500; easing.type: Easing.InOutQuad}
                PropertyAnimation { to:1; duration: 500; easing.type: Easing.InOutQuad}
            }

            MouseArea {
                anchors.fill:  parent
                enabled: !gamescreen.running
                onClicked: {
                    audio.playStartGame();
                    SaladLogic.restartGame();
                    menuScreen.state = "hidden";
                    gamearea.opacity = 1
                }
            }
        }

        states: [
            State {
                name: "hidden"
                PropertyChanges { target: menuScreen; scale: 1.5; opacity: 0 }
            }
        ]

        transitions: [
            Transition {
                from: "";
                to: "hidden";
                reversible: true;
                NumberAnimation { target: menuScreen; properties: "scale,opacity"; duration: 800 }
            }
        ]

        CloseButton {
            MouseArea {
                anchors.fill:  parent
                onClicked: {
                    quitAnimation.start();
                }
            }
        }

        Rectangle {
            id: aboutButton
            color: "#CBF76F"
            width: 75
            height: 75
            opacity: 0
            radius:10

            PropertyAnimation on opacity { to: 1; duration: 2000; easing.type: Easing.InOutSine}

            Text {
                id:aboutText
                anchors.centerIn:  parent
                text: "?"
                font.pixelSize: parent.height
                font.bold: true
                color: "#E567B1"
            }

            MouseArea {
                anchors.fill:  parent
                onClicked: {
                    audio.playAbout();
                    aboutScreen.state = "visible"
                }
            }

        }

        HelperBee {
            id:bee
            height: parent.height/6
            width: parent.width/6
            fillMode: Image.PreserveAspectFit
            z: menuScreen.z + 1
            y: parent.height - height
            x: parent.width + width

            PropertyAnimation on x {
                running:!gamescreen.running; from: (main.width + bee.width); to: 0-width; duration: 10000; loops: Animation.Infinite
            }

        }



    }

    /*-------------.
    | About screen |
    `-------------*/
    About {
        id: aboutScreen
        z: menuScreen.z + 1
        opacity: 0
    }

    /*-----------------.
    | Main game screen |
    `-----------------*/
    Rectangle {
        id: gamescreen
        property int margin: 80 // Width of the HUD bar.
        property int level: 1
        anchors.fill:  parent
        property bool paused: false
        property bool running: false
        property bool timerPaused: false

        /*---------------.
        | Main game area |
        `---------------*/
        Rectangle {
            id: gamearea
            color: "#ddddff"

            x: parent.margin; y: 0
            width: parent.width - parent.margin
            height: parent.height
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (!accelerometer.isEnabled())
                        SaladLogic.shaking(0, 0);
                }
            }

            Rectangle {
                id: fader
                color: "black"

                Behavior on opacity {
                    enabled: true
                    NumberAnimation {easing.type: Easing.OutInQuad; duration: 200}
                }

                opacity: gamescreen.running ? 0 : 0.75

                z: 1000

                anchors.fill: parent
            }
        }

        /*--------.
        | HUD bar |
        `--------*/
        // Display information about the game.
        Rectangle {
            id: hud
            color: "#333333"
            width: parent.margin
            height: parent.height
            x: 0
            y: 0
            z: gamearea.z + 1

            // In-Game menu
            Rectangle {
                id: menuButton
                color: "#CBF76F"
                radius:10
                width: parent.width - 20
                height: width
                x: 10
                y: 10

                Text {
                    id: returnScreenText
                    text: "?"
                    font.pixelSize: parent.height
                    font.bold: true
                    color: "#E567B1"
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: gamescreen.running
                    onClicked: {
                        inGameMenu.opacity = 1
                        countdown.freeze = true
                        gamescreen.running = false
                    }
                }
            }

            // Insects count.
            Item {
                id: insectsCount;
                anchors.fill:  parent

                property int numberOfInsectsRemaining;

                Text {
                    id: insectsCountText
                    x:15
                    y:parent.height - height - countdownText.height - 18
                    color: "white"
                }

                onNumberOfInsectsRemainingChanged: {
                    insectsCountText.text = numberOfInsectsRemaining
                }

                Image {
                    source: "insect.svg"
                    sourceSize.height: 35
                    sourceSize.width: 35
                    width: 35
                    height: 35
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    x: 35
                    y: parent.height - height - countdownText.height - 20;
                }
            }

            // Countdown
            Item {
                id: countdown
                anchors.fill: parent

                property int sec : 20;
                property int min : 0;
                property int realTime : 20;

                property string secString;
                property bool freeze: true;

                Timer {
                    interval: 1000; running: true; repeat: true
                    onTriggered: {
                        if (gamescreen.running && !parent.freeze && !gamescreen.timerPaused) {
                            --parent.sec;
                            parent.realTime = parent.min * 60 + parent.sec;

                            if (parent.sec == -1) {
                                if (parent.min != 0) {
                                    --parent.min
                                    parent.sec = 59
                                } else {
                                    // Time up!
                                    parent.sec = 0
                                    parent.freeze = true;
                                    if (insectsCount.numberOfInsectsRemaining > 0) {
                                        // We have lost! :(
                                        SaladLogic.gameOver("timeout")

                                    }
                                }
                            } else if (parent.sec <= 5) {
                                audio.playBeep();
                            }
                        }

                        SaladLogic.updateTimerString();
                    }
                }

                Text {
                    id: countdownText
                    color: countdown.sec <= 5 ? "red" : "white"
                    x: 20; y: parent.height - height - 10;
                    smooth: true

                    SequentialAnimation {
                        running: gamescreen.running && countdown.sec <= 5;
                        loops: Animation.Infinite;
                        alwaysRunToEnd: true

                        NumberAnimation { target: countdownText; property: "scale"; easing.type: Easing.OutInQuad; to: 1.5; duration: 500 }
                        NumberAnimation { target: countdownText; property: "scale"; easing.type: Easing.OutInQuad; to: 1.0; duration: 500 }
                    }
                }
            }

            // Health
            Item {
                id: health
                anchors.fill:  parent

                property int healthCount: 2

                onHealthCountChanged: {
                    healthText.text = healthCount
                }

                Text {
                    id: healthText
                    text: parent.healthCount
                    x: 15
                    y: parent.height - height - countdownText.height - insectsCountText.height - 30
                    color: "white"
                }

                Image {
                    source: "heart.svg"
                    sourceSize.height: 30
                    sourceSize.width: 30
                    width: 30
                    height: 30
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    x: 35
                    y: parent.height - height - countdownText.height - insectsCountText.height - 30
                }
            }

            // Score
            Item {
                id: scoreBox
                anchors.fill:  parent

                property int score: 0

                onScoreChanged: {
                    if (score < 0)
                        score = 0;

                    scoreText.text = ""
                    if (score < 100)
                        scoreText.text += "0"
                    if (score < 10)
                        scoreText.text += "0"

                    scoreText.text += score

                    gameoverMenu.finalScoreText = score
                }

                Text {
                    id: scoreText
                    text: "000"
                    x: 20
                    y: parent.height - height - countdownText.height - insectsCountText.height - healthText.height - 35
                    color: "white"
                }
            }
        }

        /*---------------.
        | Game Over menu |
        `---------------*/
        GameOver {
            id: gameoverMenu
            opacity: 0
            z: hud.z + 1
        }

        Popup {
            id: levelUp

            property bool active: false

            width: parent.width / 2
            height: parent.height / 3

            anchors.centerIn: parent
            opacity: 0
            scale: 0.5

            Text {
                id: timeBonusText
                font.pixelSize: parent.height/5
                text: "Good job!"
                anchors.bottom: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#803963"
            }

            Text {
                font.pixelSize: parent.height/5
                text: "Prepare for level " + gamescreen.level
                anchors.top: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#803963"
            }

            MouseArea {
                enabled: levelUp.active
                anchors.fill: parent
                onClicked: {
                    goToNextLevelAnimation.restart();
                }
            }

            SequentialAnimation {
                id: levelUpAnimation
                ScriptAction { script: audio.playLevelUp(); }
                ParallelAnimation {
                    NumberAnimation { target: levelUp; property: "opacity"; easing.type: Easing.OutInQuad; to: 1; duration: 400 }
                    NumberAnimation { target: levelUp; property: "scale"; easing.type: Easing.OutInQuad; to: 1; duration: 400 }
                }
                ScriptAction { script: levelUp.active = true; }
            }
            SequentialAnimation {
                id: goToNextLevelAnimation
                ScriptAction { script: audio.playArite(); }
                NumberAnimation { target: levelUp; property: "opacity"; easing.type: Easing.OutInQuad; to: 0; duration: 200 }
                ScriptAction { script: { levelUp.active = false; levelUp.scale = 0.5; SaladLogic.startGame(); } }
            }
        }

        states: [
            State {
                name: "paused"
                PropertyChanges {
                    target: gamescreen; paused: true
                }
            }
        ]
    }

    function shake(x, y) {
        SaladLogic.shaking(x, y);
    }

    function insectKilled(insect) {
        SaladLogic.insectKilled(insect);
    }

    function bittenByInsect(scorpion) {
        SaladLogic.bittenByInsect(scorpion);
    }

    function moveScorpion(scorpioni) {
        SaladLogic.moveScorpion(scorpioni);
    }

    function destroyTimeBonus(timeBonus) {
        SaladLogic.destroyTimeBonus(timeBonus);
    }

    function destroyScoreIncrement(scoreIncrement) {
        SaladLogic.destroyScoreIncrement(scoreIncrement);
    }

    function increaseTimer() {
        countdown.sec++;
        SaladLogic.updateTimerString();
    }

    SequentialAnimation {
        id: quitAnimation
        ScriptAction { script: audio.playQuit(); }
        PauseAnimation { duration: 500 }
        ScriptAction { script: Qt.quit(); }
    }

    SequentialAnimation {
        id: themeAnimation;
        running: gamescreen.running;
        PauseAnimation { duration: 2500; }
        SequentialAnimation {
            loops: Animation.Infinite;

            ScriptAction { script: audio.playTheme(); }
            PauseAnimation { duration: 3000 }
            PauseAnimation { duration: 3000 }
            PauseAnimation { duration: 3000 }
            PauseAnimation { duration: 2000 }
        }
    }

    SequentialAnimation {
        id: gameOverAnimation
        ScriptAction { script: audio.playDeath(); }
        PauseAnimation { duration: 500; }
        ScriptAction { script: SaladLogic.gameOverScreen(); }
    }
}
