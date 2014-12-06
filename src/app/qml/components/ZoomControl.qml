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
import Ubuntu.Components 1.1

Rectangle {
    id: zoomControl

    signal zoomIn
    signal zoomOut

    height: units.gu(8); width: units.gu(4)
    color: "transparent"

    UbuntuShape {
        id: zoomIn

        height: parent.height / 2
        width: parent.width

        anchors.top: parent.top

        color: "lightgrey"

        Text {
            text: "+"
            anchors.centerIn: parent
            font.pointSize: units.gu(2)
            font.weight: Font.Bold
        }

        MouseArea {
            id: zoomInMouseArea

            anchors.fill: parent
            onClicked: zoomControl.zoomIn();
        }
    }

    UbuntuShape {
        id: zoomOut

        height: parent.height / 2
        width: parent.width

        anchors.bottom: parent.bottom

        color: "lightgrey"

        Text {
            text: "-"
            anchors.centerIn: parent
            font.pointSize: units.gu(2)
            font.weight: Font.Bold
        }

        MouseArea {
            id: zoomOutMouseArea

            anchors.fill: parent
            onClicked: zoomControl.zoomOut();
        }
    }
}
