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
import "assets/api.js" as API
import "components/"

MainView {
    id: main

    objectName: "main"
    applicationName: "com.gmail.josharenson.qtber"
    width:  units.gu(40)
    height: units.gu(71)

    Component.onCompleted: {
        // CLI Option
        if (clearSettings) {
            console.log("Clearing settings...");
            API.dropDbTable();
        }

        var initialView = API.bearerTokenIsValid() || testWithoutConnectivity ?
            "views/MapView.qml" : "views/HomeView.qml";
        page_stack.push(Qt.resolvedUrl(initialView))
    }

    PageStack {
        id: page_stack

        Connections {
            ignoreUnknownSignals: true
            target: page_stack.currentPage
            onChangeViews: d.changeViews(viewName);
            onClearPageStack: {
                page_stack.clear();
                d.changeViews(viewName);
            }
        }

        QtObject {
            id: d
            function changeViews(viewName) {
                page_stack.push(Qt.resolvedUrl("views/" + viewName));
            }
        }
    }
}
