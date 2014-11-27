import QtQuick 2.0
import QtPositioning 5.3
import Ubuntu.Web 0.2
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

    // FIXME Did you know there are native Qt Maps?!?!?!!?
    WebView {
        //anchors.fill: parent
        anchors.top: product_types.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        url: "../assets/google_maps.html"
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
