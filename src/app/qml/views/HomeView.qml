/*
 * Copyright (C) 2015 Josh Arenson
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.3
import Ubuntu.Components 1.2
import "../components"

StyledPage {
    id: home_view

    readonly property int button_height: units.gu(5)
    readonly property int button_width:  parent.width * .4

    readonly property int h_ten_percent: parent.height * .1
    readonly property int w_ten_percent: parent.width  * .1

    BackgroundVideo {
        id: backgroundVideo
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
            parent.changeViews("LoginView.qml")
        }
    }
}


