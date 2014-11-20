import QtQuick 2.0
import Ubuntu.Components 1.1
import "../components"

StyledPage {
    id: home_view

    readonly property int button_height: units.gu(5)
    readonly property int button_width:  parent.width * .4

    readonly property int h_ten_percent: parent.height * .1
    readonly property int w_ten_percent: parent.width  * .1

    BackgroundVideo {
        video_source: "../assets/wth-02.mpg"
    }

    StyledButton {
        id: register_button

        height: button_height
        width:  button_width

        anchors.top: parent.top
        anchors.topMargin: h_ten_percent

        anchors.left: parent.left
        anchors.leftMargin: w_ten_percent - units.gu(0.5)

        text: "Register"

        onClicked: {
            parent.changeViews("RegistrationView.qml")
        }
    }

    StyledButton {
        id: login_button

        height: button_height
        width:  button_width

        anchors.top: parent.top
        anchors.topMargin: h_ten_percent

        anchors.right: parent.right
        anchors.rightMargin: w_ten_percent - units.gu(0.5)

        text: "Login"

        onClicked: {
            parent.changeViews("NewLoginView.qml")
        }
    }
}


