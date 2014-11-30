import QtQuick 2.0
import Ubuntu.Components 1.1

Rectangle {
    id: container

    height: units.gu(2); width: units.gu(2)
    color: "transparent"

    Rectangle {
        id: shaddow

        height: parent.height; width: parent.width
        color: "#11111111"
        radius: height / 2

        Rectangle {
            id: the_dot

            anchors.centerIn: parent
            color: "lightblue"
            height: parent.height * 0.8
            width: parent.width * 0.8
            radius: height / 2
        }
    }
}
