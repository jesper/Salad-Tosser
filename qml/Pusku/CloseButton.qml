import Qt 4.7

Rectangle {
    id: closeButton
    color: "#CBF76F"
    width: 75
    height: 75
    x: parent.width - width
    opacity: 1
    radius:10

    Text {
        id:aboutText
        anchors.centerIn:  parent
        text: "X"
        font.pointSize: 60
        font.bold: true
        color: "#E567B1"
    }

}
