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
import Ubuntu.Components.Popups 1.0
import "../assets/api.js" as API

Popover {
    id: popover

    property var startLocation;
    property var destLocation;

    Rectangle {
        height: units.gu(40)
        color: "grey"

        Text {
            anchors.fill: parent
            text: destLocation.latitude
        }
    }

}