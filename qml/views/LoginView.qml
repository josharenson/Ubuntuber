import QtQuick 2.0
import QtWebKit 3.0
import "../assets/OAuth.js" as OAuth

Rectangle {
    height: parent.height
    width: parent.width

    Text {
        id: nextState
        visible: false
        anchors.centerIn: parent
        text: "Log in successful!"
    }

    Item {
        id: stackOAuth
        property string nextState: "AuthDone"
        anchors.fill: parent
        Component.onCompleted: OAuth.checkToken()
        property string token: ""
        WebView {
            id: loginView
            visible: false
            anchors.fill: parent
            onUrlChanged: OAuth.urlChanged(url)
        }
        Rectangle {
            height: 50
            width: parent.width
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            Text {
                text: loginView.url
            }
        }

        states: [
            State {
                name: "Login"
                PropertyChanges {
                    target: loginView
                    visible: true
                    url: "https://login.uber.com/oauth/authorize"
                }
            },
            State {
                name: "AuthDone"
                PropertyChanges {
                    target: loginView
                    visible: false
                    opacity: 0
                }
                PropertyChanges {
                    target: nextState
                    visible: true
                }
            }
        ]
    }
}
