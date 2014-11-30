import QtQuick 2.0
import QtLocation 5.0
import QtPositioning 5.3
import Ubuntu.Components 1.1
import "../components"

StyledPage {
    id: map_view

    property var currentLocation: null

    anchors.fill: parent
    visible: false

    PositionSource {
        id: positionSource

        updateInterval: 1000
        active: true

        onPositionChanged: {
            currentLocation = positionSource.position.coordinate;
        }
    }

    Map {
        id: map

        anchors.top: product_types.bottom
        anchors.bottom: parent.bottom
        width: parent.width

        center: currentLocation

        plugin: Plugin {
            name: "osm"
        }
    }

    ProductTypes {
        id: product_types

        anchors.top: parent.top
        anchors.topMargin: 2
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2

        coords: currentLocation
    }
}
