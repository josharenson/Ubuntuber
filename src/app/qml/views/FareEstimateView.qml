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
import "../assets/api.js" as API
import "../components"

StyledPage {
    title: "Fare Estimate"

    implicitHeight: units.gu(70)
    implicitWidth: units.gu(41)

    QtObject {
        id: d
        readonly property real buttonWidth: parent.width * 0.8
    }

    TextField {
        id: destinationTextField

        anchors.top: parent.top
        anchors.topMargin: units.gu(5)
        anchors.horizontalCenter: parent.horizontalCenter
        width: d.buttonWidth
        placeholderText: "Enter destination address..."
    }

    Button {
        id: submit

        anchors.bottom: parent.bottom
        anchors.bottomMargin: units.gu(5)
        anchors.horizontalCenter: parent.horizontalCenter
        width: d.buttonWidth
        color: UbuntuColors.green
        text: "Get Fare Estimate"
    }
}


