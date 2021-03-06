/*
 * Copyright (C) 2014, 2015 Josh Arenson
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
import Ubuntu.Web 0.2
import Ubuntu.Components 1.2
import "../components"

import "../assets/api.js" as API

StyledPage {
    id: login_view

    WebView {
        id: web_view

        anchors.fill: parent

        url: API.authorizationUrl()
        onUrlChanged: {
            if (API.saveBearerToken(url)) {
                // Clear the stack because the only way a user should go back from
                // here is if they logout
                login_view.clearPageStack("MapView.qml");
            }
        }

        LoadingAnimation {
            id: loading_animation

            height: units.gu(1); width: parent.width;
            visible: web_view.loading
            anchors.top: parent.top
        }
    }
}
