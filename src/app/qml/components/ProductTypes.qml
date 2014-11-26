import QtQuick 2.0
import Ubuntu.Components 1.1

import "../assets/api.js" as API

Rectangle {
    id: productTypes

    property var coords;

    height: units.gu(40); width: parent.width;

    ListModel {
        id: productTypesModel
    }

    /*Component {
        id: productTypesDelegate

    }*/

    ListView {
        id: productTypesView
        anchors.fill: parent
        model: productTypesModel
        delegate: Text {
            text: display_name
        }
    }


    Component.onCompleted: {
        var location = {"latitude":coords.latitude, "longitude":coords.longitude};
        console.log(API.get_product_types(onSuccess, location));

        function onSuccess(data) {
            // FIXME a string is returned for some reason so we eval to make it
            // an Object
            var data = eval(data);
            data["products"].forEach(
                function(product) {
                    productTypesModel.append(product);
                }
            );
        }
    }
}
