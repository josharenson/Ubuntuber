import QtQuick 2.0
import Ubuntu.Components 1.0
import com.gmail.josharenson.qtber 0.1

import "../assets/api.js" as API

Rectangle {
    id: product_type

    height: units.gu(8); width: units.gu(20)

    ConfigFile{id:config}

    LoadingAnimation {
        visible: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            var data = {
                "latitude":47.599675, 
                "longitude":-122.333863
            };
            //API.get_procuts_types(onProductTypesRetrieved, data, config);
            API.auth_url()
        }
    }

    function onProductTypesRetrieved(data) {
        console.log(data) 
    }
}
