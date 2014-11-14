import QtQuick 2.0
import QtWebKit 3.0
import "../components"

StyledPage{
    id: registration_view

    anchors.fill: parent

    LoadingAnimation {
        id: loading_animation

        height: units.gu(4)
        width: units.gu(4)

        visible: false
        z: 10
    }

    WebView {
        id: registration_window

        anchors.fill: parent
        url: "https://get.uber.com/sign-up/"

        onLoadingChanged: {
            if (loadRequest.status == WebView.LoadStartedStatus) {
                loading_animation.visible = true
            } else {
                loading_animation.visible = false
            }
        }
    }
}
