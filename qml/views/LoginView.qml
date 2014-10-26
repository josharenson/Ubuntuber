import QtQuick 2.0
import QtWebKit 3.0
import "../assets/OAuth.js" as OAuth

Rectangle {

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
            OAuth.checkToken()
        }

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
                    url: "https://login.uber.com/oauth/authorize?client_id=1xRXYLdYXuNSQBSfmHzbDfnNUmZtuxZn&response_type=code&redirect_uri=qrc://LoginView.qml#code"
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
                    target: next_state
                    visible: true
                }
            }
        ]
    }
}
