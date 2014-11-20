import QtQuick 2.0
import Ubuntu.Web 0.2
import Ubuntu.Components 1.1
import "../components"

StyledPage{
    id: registration_view

    anchors.fill: parent

    WebView {
        id: web_view

        anchors.fill: parent
        url: "https://get.uber.com/sign-up/"

        LoadingAnimation {
            id: loading_animation

            height: units.gu(1); width: parent.width
            visible: web_view.loading
            anchors.top: parent.top 
        }
    }
}
