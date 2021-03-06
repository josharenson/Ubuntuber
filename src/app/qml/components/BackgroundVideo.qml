/*
 * Copyright (C) 2014, 2015 Josh Arenson
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.3
import QtMultimedia 5.0

Rectangle {

    property string video_source: ""

    width: parent.width
    height: parent.height
    color: "transparent"

    MediaPlayer {
        id: player
        autoPlay: true
        source: video_source
        loops: Animation.Infinite
    }

    VideoOutput {
        id: videoOutput

        source: player
        anchors.fill: parent

        fillMode: VideoOutput.Stretch
    }
}
