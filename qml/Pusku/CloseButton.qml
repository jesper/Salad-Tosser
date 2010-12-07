import Qt 4.7

Rectangle {
    id: closeButton
    color: "#CBF76F"
    width: 75
    height: 75
    x: parent.width - width
    opacity: 0
    radius:10

    Text {
        id:aboutText
        anchors.centerIn:  parent
        text: "X"
        font.pixelSize: parent.height
        font.bold: true
        color: "#E567B1"
    }

    PropertyAnimation on opacity { to: 1; duration: 2000; easing.type: Easing.InOutSine}

}
