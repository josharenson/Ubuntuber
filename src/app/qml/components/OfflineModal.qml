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
import Ubuntu.Components 1.1
import "../assets/fonts"

Rectangle {
    id: background

    anchors.fill: parent
    // An alpha channel is specified as setting opacity here would cause children
    // to inherit it
    color: "#80000000"
    z: 100

    UbuntuShape {
        id: modal

        anchors.centerIn: parent
        height: theText.paintedHeight; width: parent.width * 0.8

        color: "#D9D9D9"

        FontLoader {
            id: fontLoader
            source: "../assets/fonts/Exo-Bold.ttf"
        }

        Text {
            id: theText

            anchors.fill: parent
            font.family: fontLoader.name
            horizontalAlignment: Text.AlignHCenter
            text: "OY. IT SEEMS THAT THERE IS CURRENTLY NO NETWORK CONNECTIVITY :-/"
            wrapMode: Text.Wrap
        }
    }

    // Disable ineraction with underlying layers
    MouseArea {
        anchors.fill: parent
    }

}
