/*
 * Copyright (C) 2014 Josh Arenson
 *
 * Authors:
 *   Josh Arenson <josharenson@gmail.com>
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
