import QtQuick 2.0
import Ubuntu.Components 1.1

import "JSONListModel"
import "../assets/api.js" as API

Rectangle {
    height: units.gu(4); width: parent.width;
    property var location: {"latitude":47.599675,"longitude":-122.333863};
    Component.onCompleted: {
        console.log(API.get_product_types(helloWorld, location));
        function helloWorld(data) {
            console.log("HI");
        }
    }
}
