import QtQuick 2.0
import Ubuntu.Components 1.0
import "views"

MainView {
    id: main

    objectName: "main"
    applicationName: "com.gmail.josharenson.qtber"
    width:  units.gu(40)
    height: units.gu(71)

    /* FIXME Make this remember if the user is logged in, and go
     * straight to the map if they are
     */
    Component.onCompleted: {
        main_loader.source = "views/HomeView.qml"
    }

    Loader {
        id: main_loader

        height: parent.height
        width:  parent.width

        Connections {
            target: main_loader.item
            onChangeViews: {
                main_loader.source = viewName
            }
        }
    }
}
