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
    id: map_view

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
        property var pickupLocation: null
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

        anchors.top: product_types.bottom
        anchors.bottom: parent.bottom
        width: parent.width

        center: d.currentLocation
        zoomLevel: 18

        plugin: Plugin {
            name: "osm"
        }


        // Mark current location with a fancy symbol
        MapQuickItem {
            id: position_marker
            sourceItem: CurrentLocationSymbol{}
            coordinate: d.currentLocation
            z: 3
            anchorPoint.x: width / 2
            anchorPoint.y: height / 2
        }

        // Not loaded as a MapQuickItem so that it's position stays static
        PickupLocationSymbol {
            id: pickupLocationSymbol

            anchors.centerIn: parent
            z: 10

            canClick: product_types.carsAvailable
            text: product_types.carsAvailable ?
                "Set Pickup Location" : "NO CARS AVAILABLE";

            onPickupRequested: {
                d.pickupLocation = map.toCoordinate(x + (width / 2) ,y + (height))
                PopupUtils.open(
                    Qt.resolvedUrl("../components/RideRequestPopover.qml"),
                    pickupLocationSymbol,
                    {"selectedProductType": d.selectedProductType}
                )
            }
        }

        UbuntuShape {
            id: center_on_current_position

            height: zoom_control.height / 2
            width: zoom_control.width

            color: "lightgrey"
            anchors.right: parent.right
            anchors.rightMargin: units.gu(1)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gu(4)
            z: 10

            Rectangle {
                id: center_on_current_position_image_holder

                height: parent.height * 0.7; width: parent.width * 0.7
                anchors.centerIn: parent
                color: "transparent"

                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    source: "../assets/center-current-location.png"
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: map.center = d.currentLocation
            }

        }

        ZoomControl {
            id: zoom_control

            anchors.left: parent.left
            anchors.leftMargin: units.gu(1)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gu(4)
            z: 10
        }

        Connections {
            target: zoom_control
            onZoomIn: map.zoomLevel += 1
            onZoomOut: map.zoomLevel -= 1
        }

        MouseArea {
            anchors.fill: parent
            onDoubleClicked: map.zoomLevel += 1
        }
    }

    ProductTypes {
        id: product_types

        anchors.top: parent.top
        anchors.topMargin: 2
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2

        coords: d.currentLocation
        onProductSelected: {
            d.selectedProductType = productDisplayName
        }
    }
}
