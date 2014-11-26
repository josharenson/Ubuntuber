import QtQuick 2.0
import Ubuntu.Components 1.1

import "JSONListModel"
import "../assets/api.js" as API

Rectangle {
    id: productTypes

    property var coords;

    height: units.gu(4); width: parent.width;

    Text {
        anchors.fill: parent
        anchors.centerIn: parent
        text: "PLACEHOLDER FOR PRODUCT TYPES: \n" + coords.latitude + " " + coords.longitude;
    }

    ListModel {
        id: productTypesModel
    }

    Component.onCompleted: {
        var location = {"latitude":coords.latitude, "longitude":coords.longitude};
        console.log(API.get_product_types(onSuccess, location));

        function onSuccess(data) {
            // FIXME a string is returned for some reason so we eval to make it
            // an Object
            var data = eval(data);
            console.log(data["products"]);
        }
    }
}
