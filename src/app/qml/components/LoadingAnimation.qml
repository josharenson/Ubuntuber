import QtQuick 2.0


// FIXME This is fucking ugly
Image {
        anchors.centerIn: parent
        source: "../assets/WaitNote.png"
        NumberAnimation on rotation {
            loops: Animation.Infinite
            from: 0
            to: 360
            duration: 1500 // Define the desired rotation speed.
        }
}
