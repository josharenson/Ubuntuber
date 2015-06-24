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
import Ubuntu.Components 1.2

Rectangle {
    id: root

    signal pickupRequested()

    height: the_text.paintedHeight + units.gu(10)
    width: the_text.paintedWidth + units.gu(2)
    color: "transparent"

    UbuntuShape {
        id: horiz_rect
        height: the_text.paintedHeight + 4; width: parent.width
        color: "black"

        Text {
            id: the_text

            anchors.centerIn: parent
            color: "lightgrey"
            text: "Set Pickup Location"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                pickupRequested()
            }
        }
    }

    Rectangle {
        id: vert_rect

        height: parent.height - horiz_rect.height; width: 3
        anchors.top: horiz_rect.bottom
        anchors.centerIn: parent
        color: "black"
        z: -1 // There are a few pixels I can't acocunt for, so hide the overlap
    }
}
