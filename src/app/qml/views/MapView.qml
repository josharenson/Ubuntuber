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
import QtLocation 5.4
import QtPositioning 5.2
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 1.2
import "../assets/api.js" as API
import "../components"

StyledPage {
    id: mapView

    title: "QTBER"
    visible: false

    head.actions: [
        Action {
            iconName: "settings"
            onTriggered: changeViews("../views/SettingsView.qml")
        }
    ]

    QtObject {
        id: d

        property var currentLocation: null

        // pickupLocation is the center of the map, which is where the symbol is
        property var pickupLocation: map.center
        property string selectedProductType: ""
    }

    PositionSource {
        id: positionSource

        updateInterval: 1000
        active: true

        onPositionChanged: {
            d.currentLocation = positionSource.position.coordinate;
        }
    }

    Map {
        id: map

        anchors.top: productTypes.bottom
        anchors.bottom: parent.bottom
        width: parent.width

        center: d.currentLocation
        zoomLevel: 18

        plugin: Plugin {
            name: "osm"
        }

        // Mark current location with a fancy symbol
        MapQuickItem {
            id: positionMarker
            sourceItem: CurrentLocationSymbol{}
            coordinate: d.currentLocation
            z: 3
            anchorPoint.x: width / 2
            anchorPoint.y: height / 2
        }

        // Not loaded as a MapQuickItem so that it's position stays static
        // This must be at the EXACT CENTER of the map, or cars will arrive at the
        // wrong place!
        PickupLocationSymbol {
            id: pickupLocationSymbol

            anchors.centerIn: parent
            z: 10

            canClick: productTypes.carsAvailable
            text: productTypes.carsAvailable ?
                "Set Pickup Location" : "NO CARS AVAILABLE";

            onPickupRequested: {
                d.pickupLocation = map.toCoordinate(map.x + (map.width / 2) ,map.y + (map.height))
                PopupUtils.open(
                    Qt.resolvedUrl("../components/RideRequestPopover.qml"),
                    pickupLocationSymbol,
                    {
                        "selectedProductType": d.selectedProductType,
                        "startCoords" : d.pickupLocation
                    }
                )
            }
        }

        Button {
            id: centerMapButton

            height: zoomControl.height / 2
            width: zoomControl.width

            anchors.right: parent.right
            anchors.rightMargin: units.gu(1)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gu(4)
            z: 10

            iconName: "location"
            onClicked: map.center = d.currentLocation

        }

        ZoomControl {
            id: zoomControl

            anchors.left: parent.left
            anchors.leftMargin: units.gu(1)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gu(4)
            z: 10
        }

        Connections {
            target: zoomControl
            onZoomIn: map.zoomLevel += 1
            onZoomOut: map.zoomLevel -= 1
        }

        MouseArea {
            anchors.fill: parent
            onDoubleClicked: map.zoomLevel += 1
        }
    }

    ProductTypes {
        id: productTypes

        anchors.top: parent.top
        anchors.topMargin: 2
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2

        coords: d.pickupLocation
        onProductSelected: {
            d.selectedProductType = productDisplayName
        }
    }
}
