import Qt 4.7

Entity {
    id: saladItem

    Image {
        source: {
            if (Math.random() < 0.5)
                return "salad_leaf.svg";
            else
                return "vegetable.svg";
        }

        sourceSize.height: 96
        sourceSize.width: 96

        anchors.fill: parent
        smooth: true
    }

    MouseArea {
        id: mouseArea
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
