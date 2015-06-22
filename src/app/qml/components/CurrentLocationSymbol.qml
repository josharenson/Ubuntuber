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

Rectangle {
    id: container

    height: units.gu(2); width: units.gu(2)
    color: "transparent"

    Rectangle {
        id: shaddow

        height: parent.height; width: parent.width
        color: "#11111111"
        radius: height / 2

        Rectangle {
            id: the_dot

            anchors.centerIn: parent
            color: "lightblue"
            height: parent.height * 0.8
            width: parent.width * 0.8
            radius: height / 2
        }
    }
}
