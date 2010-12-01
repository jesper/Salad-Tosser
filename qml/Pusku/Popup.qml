import Qt 4.7

Item {
    id: popupWindow

    width: parent.width/2
    height: parent.height/2

    Rectangle {
        id:popupShadow
        color: "black"
        opacity: 0.5
        radius: 10
        anchors.fill: parent
    }

    Rectangle {
        id:popupContent
        color: "#A2EF00"
        opacity: 1
        radius: 10
        x: 10
        y: 10
        width: parent.width - 20
        height: parent.height - 20
    }
}
