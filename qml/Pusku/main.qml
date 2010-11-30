import Qt 4.7
import "salad.js" as SaladLogic


Item {
    width: 800
    height: 480

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

            PropertyAnimation on y { to:(menuScreen.height/2+50); duration: 2000; easing.type: Easing.OutBounce}

            MouseArea {
                anchors.fill:  parent
                onClicked: {
                    SaladLogic.startGame();
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
            width: 50
            height: 50
            x: parent.width - width
            opacity: 0
            PropertyAnimation on opacity { to: 1; duration: 2000; easing.type: Easing.InOutSine}

            Text {
                id:aboutText
                anchors.centerIn:  parent
                text: "?"
                font.pointSize: 40
                font.bold: true
                color: "#E567B1"
            }

            MouseArea {
                anchors.fill:  parent
                onClicked: {
                    aboutScreen.opacity = 1
                }
            }

        }

    }

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
        property int margin: 80
        anchors.fill:  parent


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
                    SaladLogic.shaking();
                }
            }
        }

        /*--------.
        | HUD bar |
        `--------*/
        // Display information about the game.
        Rectangle {
            id: hud
            color: "#000000"
            width: parent.margin
            height: parent.height
            x: 0
            y: 0
            z: gamearea.z + 1

            // Insects count.
            Item {
                id: insectsCount;
                anchors.fill:  parent

                property int numberOfInsectsRemaining;

                Text {
                    id: insectsCountText
                    x:10; y:0
                    color: "white"
                }

                onNumberOfInsectsRemainingChanged: {
                    insectsCountText.text = numberOfInsectsRemaining
                }
            }

        }
    }

    function shake() {
        SaladLogic.shaking();
    }
}
