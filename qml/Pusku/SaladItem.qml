import Qt 4.7

Entity {
    id: saladItem
    property int type: 0

    Image {
        id: saladItemImage
        source: {
            var random_value = Math.random();
            if (random_value < 0.4) {
                parent.type = 1;
                return "salad_leaf.svg";
            } else if (random_value < 0.8) {
                parent.type = 2;
                return "vegetable.svg";
            } else {
                parent.type = 3;
                return "tomato.svg";
            }
        }

        sourceSize.height: 96
        sourceSize.width: 96

        anchors.fill: parent
        smooth: true
    }

    MouseArea {
        id: mouseArea
        enabled: gamescreen.running
        anchors.fill: parent
        anchors.margins: 15
        drag.target: parent;
    }

    Behavior on rotation {
         enabled: saladItem.placed;
         NumberAnimation {easing.type: Easing.OutInQuad; duration: 100}
     }
    Behavior on x {
         enabled: saladItem.placed;
         NumberAnimation {easing.type: Easing.OutInQuad; duration: 100}
     }
    Behavior on y {
         enabled: saladItem.placed;
         NumberAnimation {easing.type: Easing.OutInQuad; duration: 100}
     }

    states: [
        State {
        name: "held"; when: mouseArea.pressed == true
        PropertyChanges { target: saladItem; scale: 1.2 }
        },
        State {
        name: "shaking"
        }
    ]

    transitions: [
        Transition {
            from: "";
            to: "held";
            reversible: true;
            NumberAnimation { target: saladItem; property: "scale"; duration: 100 }
        },
        Transition {
            from: ""
            to: "shaking"
            SequentialAnimation {
                NumberAnimation { target: saladItem; property: "scale"; to: 1.2; duration: 100 }
                NumberAnimation { target: saladItem; property: "scale"; to: 1.0; duration: 100 }
                PropertyAnimation { target: saladItem; property: "state"; to: ""; duration: 1 }
            }
        }

    ]
}
