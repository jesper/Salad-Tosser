import Qt 4.7

// Would really like to use the "radius" property, but this yields weird painting on openvg.
Rectangle {
    id: popupButton
    property alias buttonText: buttonText.text
    width: buttonText.width + 25
    height: buttonText.height + 22
    color: "#CBF76F"

    Text {
        id: buttonText
        text: ""
        font.pixelSize: parent.height - 5
        color: "#E567B1"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -1
    }
}
