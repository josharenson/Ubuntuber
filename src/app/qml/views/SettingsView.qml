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
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import "../components"

StyledPage {
    id: settingsPage

    anchors.fill: parent

    Column {
        width: parent.width

        ListItem.Header{
            text: "Settings"
        }
        ListItem.Divider{}

        ListItem.Standard {
            text: "About"
            iconSource: Qt.resolvedUrl("../assets/about_icon.svg");
        }

        ListItem.Standard {
            text: "Logout"
            iconSource: Qt.resolvedUrl("../assets/logout_icon.svg");
        }
    }
}


