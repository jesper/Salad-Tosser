import Qt 4.7

Rectangle {
    id: popupButton
    property alias buttonText: buttonText.text
    width: buttonText.width + 10
    height: buttonText.height + 10
    color: "#CBF76F"
    radius:10

    Text {
        id: buttonText
        text: ""
        font.pointSize: 24
        color: "#E567B1"
        x: 5
        y: parent.height/2 - height/2
    }
}
