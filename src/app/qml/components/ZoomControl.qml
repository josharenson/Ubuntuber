import QtQuick 2.0
import Ubuntu.Components 1.1

Rectangle {
    id: zoomControl

    signal zoomIn
    signal zoomOut

    height: units.gu(8); width: units.gu(4)
    color: "transparent"

    UbuntuShape {
        id: zoomIn

        height: parent.height / 2
        width: parent.width

        anchors.top: parent.top

        color: "lightgrey"

        Text {
            text: "+"
            anchors.centerIn: parent
            font.pointSize: units.gu(2)
            font.weight: Font.Bold
        }

        MouseArea {
            id: zoomInMouseArea

            anchors.fill: parent
            onClicked: zoomControl.zoomIn();
        }
    }

    UbuntuShape {
        id: zoomOut

        height: parent.height / 2
        width: parent.width

        anchors.bottom: parent.bottom

        color: "lightgrey"

        Text {
            text: "-"
            anchors.centerIn: parent
            font.pointSize: units.gu(2)
            font.weight: Font.Bold
        }

        MouseArea {
            id: zoomOutMouseArea

            anchors.fill: parent
            onClicked: zoomControl.zoomOut();
        }
    }
}
