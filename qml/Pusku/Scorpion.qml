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
        onProgressChanged: { console.log("foo"); }
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
            scorpion.state = "triggered"
        }
    }

    Timer {
        interval: 4000; running: true; repeat: true
        onTriggered: {
            SaladLogic.moveScorpion(parent);
        }
    }

    states: State {
        name: "triggered";
        PropertyChanges { target: scorpion; opacity: 0 }
        PropertyChanges { target: scorpion; scale: 2 }
    }

    transitions: [
        Transition {
            from: ""
            to: "triggered"
            SequentialAnimation {
                NumberAnimation { target: scorpion; property: "scale"; easing.type: Easing.OutInQuad; duration: 300 }
                NumberAnimation { target: scorpion; property: "opacity"; duration: 400 }
            }
        }
    ]
}
