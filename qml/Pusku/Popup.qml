import Qt 4.7

Item {
    id: popupWindow

    width: parent.width/2
    height: parent.height/2

    Behavior on opacity {
        enabled: true
        NumberAnimation {easing.type: Easing.OutInQuad; duration: 200}
    }

    Rectangle {
        id:popupShadow
        color: "black"
        opacity: 0.5
        anchors.fill: parent
    }

    Rectangle {
        id:popupContent
        color: "#A2EF00"
        opacity: 1
        x: 10
        y: 10
        width: parent.width - 20
        height: parent.height - 20
    }
}
