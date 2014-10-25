import QtQuick 2.0
import Ubuntu.Components 1.1

Button {
    id: styled_button

    /* User is responsible for setting
     * - Text
     * - Anchors
     * - onClicked

     * Styled button is responsible for setting
     * - Color
     * - Shape
    */

    signal changeViews(string viewName)
    color: "grey"
}
