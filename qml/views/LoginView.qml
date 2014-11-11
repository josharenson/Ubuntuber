import QtQuick 2.0
import QtWebKit 3.0
import QtBer 0.1
import "../components"
import "../assets/OAuth.js" as OAuth

StyledPage {
    id: login_view

    height: parent.height
    width: parent.width

    visible: false

    ConfigFile {

    }

    // For debugging now, load a new view here
    Text {
        id: next_state

        visible: false
        anchors.centerIn: parent
        text: "Log in successful!"
        /*onVisibleChanged: {
            if (visible)
                parent.changeViews("MapView.qml")
        }*/
    }

    Item {
        id: stack_oauth

        property string next_state: "AuthDone"
        property string token: ""

        anchors.fill: parent
        Component.onCompleted: {
            // Set this to true during development to always force an authentication
            OAuth.checkToken(false)
        }

        LoadingAnimation {
            id: loading_animation

            height: units.gu(4)
            width: units.gu(4)

            visible: false
            z: 10
        }

        WebView {
            id: login_webview

            visible: false
            anchors.fill: parent

            onUrlChanged: {
                OAuth.urlChanged(url)
            }

            onLoadingChanged: {
                if (loadRequest.status == WebView.LoadStartedStatus) {
                    loading_animation.visible = true
                } else {
                    loading_animation.visible = false
                }
            }
        }

        // FIXME This jank shit works around a bug 1390593
        Timer {
            id: the_timer
            interval: 1000; running: false; repeat: false
            onTriggered: {
                console.log("TIMER TRIGGERED")
                login_view.changeViews("MapView.qml")
            }
        }
        onStateChanged: {
            if (state == "AuthDone") {
                the_timer.running = true
            }
        }

        states: [
            State {
                name: "Login"
                PropertyChanges {
                    target: login_webview
                    visible: true
                    url: "https://login.uber.com/oauth/authorize?client_id=1xRXYLdYXuNSQBSfmHzbDfnNUmZtuxZn&response_type=code"
                }
            },
            State {
                name: "AuthDone"
                PropertyChanges {
                    target: login_webview
                    visible: false
                    opacity: 0
                }
            }
        ]
    }
}
