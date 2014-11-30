import QtQuick 2.0
import Ubuntu.Components 1.1

Rectangle {
    id: root

    signal destinationRequested()

    height: the_text.paintedHeight + units.gu(10)
    width: the_text.paintedWidth + units.gu(2)
    color: "transparent"

    UbuntuShape {
        id: horiz_rect
        height: the_text.paintedHeight + 4; width: parent.width
        color: "black"

        Text {
            id: the_text

            anchors.centerIn: parent
            color: "lightgrey"
            text: "Request A Quote"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                destinationRequested()
            }
        }
    }

    Rectangle {
        id: vert_rect

        height: parent.height - horiz_rect.height; width: 3
        anchors.top: horiz_rect.bottom
        anchors.centerIn: parent
        color: "black"
        z: -1 // There are a few pixels I can't acocunt for, so hide the overlap
    }
}
