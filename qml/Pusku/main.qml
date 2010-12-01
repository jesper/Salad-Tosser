import Qt 4.7
import "salad.js" as SaladLogic


Item {
    width: 800
    height: 480

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
            fillMode: Image.PreserveAspectFit
            y:height*-1
            x:menuScreen.width/2 - width/2

            PropertyAnimation on y { to:(menuScreen.height/2 - (logoImage.height/2)); duration: 2000; easing.type: Easing.OutBounce}

            MouseArea {
                anchors.fill:  parent
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


        Rectangle {
            id: aboutButton
            color: "#CBF76F"
            width: 75
            height: 75
            x: parent.width - width
            opacity: 0
            radius:10

            PropertyAnimation on opacity { to: 1; duration: 2000; easing.type: Easing.InOutSine}

            Text {
                id:aboutText
                anchors.centerIn:  parent
                text: "?"
                font.pointSize: 60
                font.bold: true
                color: "#E567B1"
            }

            MouseArea {
                anchors.fill:  parent
                onClicked: {
                    audio.playAbout();
                    aboutScreen.opacity = 1
                }
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
        anchors.fill:  parent
        property bool paused: false

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
                    SaladLogic.shaking(0, 0);
                }
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
                    font.pointSize: 38
                    font.bold: true
                    color: "#E567B1"
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        inGameMenu.opacity = 1
                        countdown.freeze = true
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

                property int sec;
                property int min;
                property string secString;
                property bool freeze: true;

                Timer {
                    interval: 1000; running: true; repeat: true
                    onTriggered: {
                        if (!parent.freeze) {
                            --parent.sec;
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
                            }
                        }

                        if (parent.sec > 9) {
                            parent.secString = parent.sec
                        } else {
                            parent.secString = "0" + parent.sec
                        }
                        countdownText.text = parent.min + ":" + parent.secString
                    }
                }

                Text {
                    id: countdownText
                    color: "white"
                    x: 20; y: parent.height - height - 10;
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
        }

        /*---------------.
        | Game Over menu |
        `---------------*/
        GameOver {
            id: gameoverMenu
            opacity: 0
            z: hud.z + 1
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
}
