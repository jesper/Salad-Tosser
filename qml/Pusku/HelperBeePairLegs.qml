import Qt 4.7

Item {
    z: body.z - 5

    Rectangle {
        id:leg
        width: 5
        height: body.height/3
        color: "black"

        SequentialAnimation on y {
            loops: Animation.Infinite
            PropertyAnimation { to:(body.height/5)*3; duration: 300;}
            PropertyAnimation { to:(body.height/5)*2; duration: 300;}
        }

    }

    Rectangle {
        id:legdos
        width: 5
        height: body.height/3
        color: "black"
        x: 10


        SequentialAnimation on y {
            loops: Animation.Infinite
            PropertyAnimation { to:(body.height/5)*2; duration: 300;}
            PropertyAnimation { to:(body.height/5)*3; duration: 300;}
        }

    }
}
