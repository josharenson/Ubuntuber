import QtQuick 2.0
import QtWebKit 3.0
import "../components"
import "../assets/OAuth.js" as OAuth

StyledPage {

    height: parent.height
    width: parent.width

    // For debugging now, load a new view here
    Text {
        id: next_state

        visible: false
        anchors.centerIn: parent
        text: "Log in successful!"
    }

    Item {
        id: stack_oauth

        property string next_state: "AuthDone"
        property string token: ""

        anchors.fill: parent
        Component.onCompleted: {
            // Set this to true during development to always force an authentication
            OAuth.checkToken(true)
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

        /*Rectangle {
            height: 50
            width: parent.width
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            Text {
                text: login_webview.url
            }
        }*/

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
                PropertyChanges {
                    target: next_state
                    visible: true
                }
            }
        ]
    }
}
