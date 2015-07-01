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
import Ubuntu.Components.Popups 1.2

Popover {
    id: popover

    property var startCoords: null
    property string selectedProductType: ""

    Rectangle {
        id: leftButtonContainer
        height: units.gu(5); width: parent.width / 2;
        anchors.left: parent.left
        Button {
            anchors.centerIn: parent
            width: parent.width * 0.8
            text: "Order " + selectedProductType
        }
    }

    Rectangle {
        id: rightButtonContainer
        height: units.gu(5); width: parent.width / 2;
        anchors.right: parent.right

        Button {
            anchors.centerIn: parent
            width: parent.width * 0.8
            text: "Fare estimate"

            onClicked: {
                var params = {}
                changeViews("FareEstimateView.qml", params);
                PopupUtils.close(popover);
            }
        }
    }
}
