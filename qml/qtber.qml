import QtQuick 2.0
import Ubuntu.Components 1.0
import "components/"

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
        page_stack.push(Qt.resolvedUrl("views/HomeView.qml"))
    }

    PageStack {
        id: page_stack

        Connections {
            target: page_stack.currentPage
            onChangeViews: {
                page_stack.push(Qt.resolvedUrl("views/" + viewName))
            }
        }
    }
}
