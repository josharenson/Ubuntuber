/*
 * Copyright (C) 2014, 2015 Josh Arenson
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

import QtQuick 2.3
import QtLocation 5.4
import QtPositioning 5.2
import Ubuntu.Components 1.1
import "../assets/api.js" as API
import "../components"

StyledPage {
    id: map_view

    signal pricingDataReceived();
    property var currentLocation: null
    property var destLocation: null

    anchors.fill: parent
    visible: false

    PositionSource {
        id: positionSource

        updateInterval: 1000
        active: true

        onPositionChanged: {
            currentLocation = positionSource.position.coordinate;
        }
    }

    Map {
        id: map

        anchors.top: product_types.bottom
        anchors.bottom: parent.bottom
        width: parent.width

        center: currentLocation
        zoomLevel: 15

        plugin: Plugin {
            name: "osm"
        }


        // Mark current location with a fancy symbol
        MapQuickItem {
            id: position_marker
            sourceItem: CurrentLocationSymbol{}
            coordinate: currentLocation
            z: 3
            anchorPoint.x: width / 2
            anchorPoint.y: height / 2
        }

        // Not loaded as a MapQuickItem so that it's position stays static
        DestinationLocationSymbol {
            id: destination_marker

            anchors.centerIn: parent
            z: 10
            onDestinationRequested: {
                destLocation = map.toCoordinate(x + (width / 2) ,y + (height))
                API.get_price_estimate(
                    currentLocation.latitude,
                    currentLocation.longitude,
                    destLocation.latitude,
                    destLocation.longitude,
                    displayPriceEstimate
                );
            }
            function displayPriceEstimate(data) {
                pricingDataReceived();
            }
        }

        PriceEstimateDialog {
            id: price_estimate_dialog

            startLocation: currentLocation
            z: 100

            Connections {
                target: map_view
                onDestLocationChanged: {
                    console.log();
                }
            }

            Connections {
                target: destination_marker
                onPricingDataReceived: Ubuntu.PopupUtils.open(price_estimate_dialog);
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
                onClicked: map.center = currentLocation
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

        coords: currentLocation
    }
}
