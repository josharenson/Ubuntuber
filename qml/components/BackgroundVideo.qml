import QtQuick 2.0
import QtMultimedia 5.0


Rectangle {

    property string video_source: ""

    width: parent.width
    height: parent.height
    color: "transparent"

    MediaPlayer {
        id: player
        autoPlay: true
        source: "../assets/wth-02.mpg"
        loops: Animation.Infinite
    }

    VideoOutput {
        id: videoOutput

        source: player
        anchors.fill: parent

        fillMode: VideoOutput.Stretch
    }
}
