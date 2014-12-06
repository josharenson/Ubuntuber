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

import "../assets/api.js" as API

Rectangle {
    id: productTypes

    property var coords;
    property int lastX: 0

    height: productTypesView.itemHeight; width: parent.width;

    // Expand and contract at the same rate as the OptionSelector
    // This value came from trial and error
    Behavior on height { SmoothedAnimation { velocity: 500 } }

    color: "transparent"

    ListModel {
        id: productTypesModel
    }

    Component {
        id: productTypesDelegate
        OptionSelectorDelegate {
            text: display_name
            constrainImage: true
            iconSource: image // FIXME make the width a resonable value
        }
    }

    OptionSelector {
        id: productTypesView

        anchors.top: parent.top
        model: productTypesModel
        delegate: productTypesDelegate
        onCurrentlyExpandedChanged: {
            if (currentlyExpanded) {
                parent.height = (itemHeight * productTypesModel.count) + 4
            }
            else {
                parent.height = itemHeight + 4
            }
        }
    }

    Component.onCompleted: {
        var location = {"latitude":coords.latitude, "longitude":coords.longitude};
        console.log(API.get_product_types(onSuccess, location));

        function onSuccess(data) {
            // FIXME a string is returned for some reason so we eval to make it
            // an Object
            var data = eval(data);
            var index = 0;
            data["products"].forEach(
                function(product) {
                    product["index"] = index++;
                    productTypesModel.append(product);
                    console.log("Added: " + product["display_name"]);
                }
            );
        }
    }
}
