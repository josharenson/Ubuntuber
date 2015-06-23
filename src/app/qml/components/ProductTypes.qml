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
import Ubuntu.Components 1.1

import "../assets/api.js" as API

Rectangle {
    id: productTypes

    property alias _SETTINGS_INDEX: productTypesModel.count;

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
        onDelegateClicked: {
            console.log("Clicked: " + selectedIndex + " _SETTINGS_INDEX:" + _SETTINGS_INDEX);
            //if (selectedIndex == _SETTINGS_INDEX) {
                productTypes.parent.changeViews("SettingsView.qml");
            //}
        }
    }

    Component.onCompleted: {
        var location = {"latitude":coords.latitude, "longitude":coords.longitude};
        console.log(API.get_product_types(onSuccess, location));

        function onSuccess(data) {
            // Astring is returned for some reason so we eval to make it
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

            // Append the settings icon to the ProductType selector
            var settings = {};
            settings["index"] = index++;
            settings["display_name"] = "Settings"
            settings["image"] = Qt.resolvedUrl("../assets/settings_icon.svg");
            productTypesModel.append(settings);
        }
    }
}
