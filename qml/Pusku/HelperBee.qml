import Qt 4.7

Image {
    id: body
    source: "helper_bee.svg"
    x: 0
    HelperBeePairLegs {
        x: parent.width/7 * 2
    }

    HelperBeePairLegs {
        x: parent.width/7 * 3
    }

    HelperBeePairLegs {
        x: parent.width/7 * 4
    }

    Rectangle
    {
        id:sign
        x: parent.width/2 - width
        width: signText.width + 3
        height: signText.height + 3
        Text {
            id:signText
            font.pointSize: 12
            text: "Click the logo to start!"
        }
    }
}
