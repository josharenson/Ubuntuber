import QtQuick 2.0
import Ubuntu.Web 0.2
import Ubuntu.Components 1.1
import "../components"

import "../assets/api.js" as API

StyledPage {
    id: login_view

    anchors.fill: parent

    WebView {
        id: web_view

        anchors.fill: parent
        url: API.authorizationUrl()

        onUrlChanged: {
            if (API.urlHasBearerToken(url)) {
                API.saveBearerToken(url)
                API.bearerToken()
            }
        }
    }
}
