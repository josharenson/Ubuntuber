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

import "../assets/api.js" as API

Rectangle {
    id: productTypes

    readonly property bool carsAvailable: d.carsAvailable
    property var coords: null // To be set from outside

    signal productSelected(string productDisplayName)

    height: productTypesView.itemHeight; width: parent.width;

    // Expand and contract at the same rate as the OptionSelector
    // This value came from trial and error
    Behavior on height { SmoothedAnimation { velocity: 500 } }

    color: "transparent"

    QtObject {
        id: d
        property bool carsAvailable: false
    }

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

        onDelegateClicked: {
            var product = productTypesModel.get(index);
            productSelected(product["display_name"]);
        }
    }

    onCoordsChanged: {
        if (coords != null)
            updateProducts(coords);
    }

    property bool locked: false
    function updateProducts(coords) {
        if (locked) {
            return;
        } else {
            locked = true;
        }
        var location = {"latitude":coords.latitude, "longitude":coords.longitude};
        productTypesModel.clear();
        API.get_product_types(onSuccess, noProductsFound, location);
    }

    function noProductsFound(data) {
        var product = {};
        product["display_name"] = "NO CARS AVAILABLE"
        // FIXME: Make this a resonable icon
        product["image"] = Qt.resolvedUrl("../assets/settings_icon.svg");
        productTypesModel.append(product);
        locked = false;
    }

    function onSuccess(data) {
        // Astring is returned for some reason so we eval to make it
        // an Object
        var data = eval(data);
        var index = 0;

        if (data === undefined || data["products"].length == 0) {
            noProductsFound();
        } else {
            d.carsAvailable = true;
            data["products"].forEach(
                function(product) {
                    product["index"] = index++;
                    productTypesModel.append(product);
                    console.log("Added: " + product["display_name"]);
                }
            );

            // If a user wants the first result, they won't click it,
            // so this will update anyone listening
            productSelected(productTypesModel.get(0)["display_name"]);
            locked = false;
        }
    }
}
