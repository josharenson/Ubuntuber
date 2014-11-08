import QtQuick 2.0
import Ubuntu.Web 0.2
import Ubuntu.Components 1.1
import "../components"


StyledPage {
    id: map_view

    anchors.fill: parent
    visible: false

    WebView {
        anchors.fill: parent
        url: "../assets/google_maps.html"
    }

}
