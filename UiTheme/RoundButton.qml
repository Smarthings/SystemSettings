import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2
import QtQuick.Templates 2.2 as T

import "./"

T.RoundButton {
    id: control

    property color color: Theme.primary
    property alias textStyle: textStyle

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem.implicitHeight + topPadding + bottomPadding)
    baselineOffset: contentItem.y + contentItem.baselineOffset

    enabled: true
    opacity: enabled? 1.0 : 0.75

    contentItem: Text {
        id: textStyle
        text: control.text
        font.bold: flat

        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        visible: !control.flat || control.down || control.checked || control.highlighted
        implicitWidth: Theme.implicitHeightComponents
        implicitHeight: Theme.implicitHeightComponents


        color: !control.flat? (control.checked || control.highlighted ?
                                (control.visualFocus ? (control.down ? Theme.checkedFocus(control.color): Theme.focus(control.color)) : (control.down ? Theme.checkedPressed(control.color) : Theme.checked(control.color))) :
                                (control.visualFocus ? (control.down ? Theme.focusPressed(control.color) : Theme.focusLight(control.color)) : (control.down ? Theme.pressed(control.color) : control.color))) : "transparent"
        radius: control.radius
    }
}
