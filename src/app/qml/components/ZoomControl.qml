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
    id: zoomControl

    signal zoomIn
    signal zoomOut

    height: units.gu(8); width: units.gu(4)
    color: "transparent"

    Button {
        height: parent.height / 2.1; width: parent.width
        anchors.top: parent.top

        iconName: "list-add"
        onClicked: zoomControl.zoomIn();
    }

    Button {
        height: parent.height / 2.1; width: parent.width
        anchors.bottom: parent.bottom

        iconName: "list-remove"
        onClicked: zoomControl.zoomOut();
    }
}
