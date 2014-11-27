import QtQuick 2.0
import Ubuntu.Components 1.1

import "../assets/api.js" as API

Rectangle {
    id: productTypes

    property var coords;
    property int lastX: 0

    //height: childRect.height; width: parent.width;

    //radius: 8
    color: "lightgrey"

    ListModel {
        id: productTypesModel
    }

    Component {
        id: productTypesDelegate
        OptionSelectorDelegate {
            text: display_name
            iconSource: image
        }
    }

    OptionSelector {
        id: productTypesView
        anchors.centerIn: parent
        //text: "Ride Type"
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
