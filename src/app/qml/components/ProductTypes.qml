import QtQuick 2.0
import Ubuntu.Components 1.0
import com.gmail.josharenson.qtber 0.1

import "../assets/ajaxmee.js" as Ajaxmee

Rectangle {
    id: product_type

    height: units.gu(8); width: units.gu(20)

    function product_types_url() {
        return config.uberApiBaseUrl +
        config.uberApiProductsUrl;
    }

    function get_data() {
        var data = {"latitude":47.599675, "longitude":-122.333863}
        console.log(data)
    Ajaxmee.ajaxmee('GET', product_types_url(), data,
        function(data) {
            console.log('ok', data)
        },
        function(status, statusText) {
            console.log('error', status, statusText)
        })
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log(get_data())
        }
    }

    ConfigFile{id:config}
}
