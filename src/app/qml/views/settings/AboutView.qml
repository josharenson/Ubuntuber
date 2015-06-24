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
import Ubuntu.Components.ListItems 1.2 as ListItem
import "../../components"

StyledPage {
    id: about_page

    title: "About"
    visible: false

    Column {
        anchors.fill: parent

        ListItem.Standard {
            text: "An Uber Clone for Ubuntu by Josh Arenson"
        }

        ListItem.Standard {
            TextArea {
                anchors.fill: parent
                readOnly: true
                text:"This project is licensed under the terms of the GPLv3. This project uses Open Street Maps and ajaxme (https://github.com/peppelorum/ajaxmee). Please see these projects to view their licenses.
                "
            }
        }
    }
}


