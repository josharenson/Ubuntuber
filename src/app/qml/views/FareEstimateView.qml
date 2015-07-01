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
import "../assets/api.js" as API
import "../components"

StyledPage {
    id: fareEstimateView

    title: "Fare Estimate"

    QtObject {
        id: d
        readonly property real buttonWidth: parent.width * 0.9

        function reverseGeocodeSubmit(addressString) {
            API.get_reverse_geocode(addressString,
                onReverseGeocodeSuccess, onReverseGeocodeFailure);
        }

        // TODO: Implement something nice here
        function onReverseGeocodeFailure(data) {
            console.log("FAILED: ");
        }

        function onReverseGeocodeSuccess(data) {
            console.log(data);
            var data = eval(data);
            addressModel.clear();
            for (var i = 0; i < data.length; i++) {
                addressModel.append(data[i]);
            }
        }

        function onFareEstimateSuccess(data) {
            console.log(data);
        }

        function onFareEstimateFailure(data) {
           console.log("FAILED: ");
        }
    }

    TextField {
        id: destinationTextField

        anchors.top: parent.top
        anchors.topMargin: units.gu(1)
        anchors.horizontalCenter: parent.horizontalCenter
        width: d.buttonWidth
        placeholderText: "Enter destination address..."

        onAccepted: d.reverseGeocodeSubmit(text);
    }

    ListModel {
        id: addressModel
    }

    Component {
        id: addressDelegate
        Item {
            height: theText.contentHeight
            width: parent.width
            TextArea {
                id: theText
                width: parent.width
                readOnly: true

                text: display_name
            }
            ListItem.ThinDivider {}
        }
    }

    UbuntuListView {
        anchors {
            top: destinationTextField.bottom
            topMargin: units.gu(1)
            left: parent.left
            right: parent.right
            bottom: submitButton.top
            bottomMargin: units.gu(1)
        }
        clip: true

        model: addressModel
        delegate: addressDelegate
    }

    Button {
        id: submitButton

        anchors.bottom: parent.bottom
        anchors.bottomMargin: units.gu(5)
        anchors.horizontalCenter: parent.horizontalCenter
        width: d.buttonWidth
        color: UbuntuColors.green
        text: "Search"

        onClicked: d.reverseGeocodeSubmit(destinationTextField.text);
    }
}


