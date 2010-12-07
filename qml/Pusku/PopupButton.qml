import Qt 4.7

Rectangle {
    id: popupButton
    property alias buttonText: buttonText.text
    width: buttonText.width + 25
    height: buttonText.height + 22
    color: "#CBF76F"
    radius:10

    Text {
        id: buttonText
        text: ""
        font.pixelSize: parent.height - 5
        color: "#E567B1"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -1
    }
}
