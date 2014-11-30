/*
 * Copyright: 2014 Josh Arenson
 *
 * This file is part of QtBer
 *
 * QtBer is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * QtBer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Author: Josh Arenson <josharenson@gmail.com>
 */

import QtQuick 2.0
import Ubuntu.Components 1.0
import "assets/api.js" as API
import "components/"

MainView {
    id: main

    objectName: "main"
    applicationName: "com.gmail.josharenson.qtber"
    width:  units.gu(40)
    height: units.gu(71)

    Component.onCompleted: {
        var initialView = API.bearerTokenIsValid() ?
            "views/MapView.qml" : "views/HomeView.qml";
        page_stack.push(Qt.resolvedUrl(initialView))
    }

    PageStack {
        id: page_stack

        Connections {
            ignoreUnknownSignals: true
            target: page_stack.currentPage
            onChangeViews: {
                console.log("Loding view: views/" + viewName)
                page_stack.push(Qt.resolvedUrl("views/" + viewName))
                console.log("Current page is: " + page_stack.currentPage)
            }
        }
    }
}
