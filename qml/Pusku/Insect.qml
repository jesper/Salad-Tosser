import Qt 4.7
import "salad.js" as SaladLogic

Rectangle {
    id:insect
    color: "transparent"
    Image {
        source: "insect.svg"
        sourceSize.height: 40
        sourceSize.width: 40
        fillMode: Image.PreserveAspectFit
        anchors.fill: parent
        smooth: true
    }

    Behavior on x {
         enabled: true;
         NumberAnimation {easing.type: Easing.OutInQuad}
     }
    Behavior on y {
         enabled: true;
         NumberAnimation {easing.type: Easing.OutInQuad}
     }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            insect.state = "dead"
            SaladLogic.insectKilled();
        }
    }

//    GestureArea {
//        anchors.fill: parent
//        onPan: {console.log("pan gesture")}
//    }

    states: State {
        name: "dead";
        PropertyChanges { target: insect; opacity: 0 }
    }

    transitions: [
        Transition {
            from: ""
            to: "dead"
            NumberAnimation { target: insect; property: "opacity"; duration: 200 }
        }
    ]
}
