import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Templates 2.2 as T

import "./"
import "../"

T.Button {
    id: control
    property color color: Theme.primary
    property alias textStyle: textStyle

    enabled: true
    opacity: enabled? 1.0 : 0.75

    padding: 6
    leftPadding: padding + 2
    rightPadding: padding + 2

    implicitWidth: Math.max(background ? background.implicitWidth : 0, contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0, contentItem.implicitHeight + topPadding + bottomPadding)
    baselineOffset: contentItem.y + contentItem.baselineOffset

    background: Rectangle {
        visible: !control.flat || control.down || control.checked || control.highlighted
        implicitWidth: 100
        implicitHeight: 30


        color: !control.flat? (control.checked || control.highlighted ?
                                (control.visualFocus ? (control.down ? Theme.checkedFocus(control.color): Theme.focus(control.color)) : (control.down ? Theme.checkedPressed(control.color) : Theme.checked(control.color))) :
                                (control.visualFocus ? (control.down ? Theme.focusPressed(control.color) : Theme.focusLight(control.color)) : (control.down ? Theme.pressed(control.color) : control.color))) : "transparent"
        radius: height * 0.2
    }

    contentItem: Text {
        id: textStyle
        text: control.text
        font.bold: flat

        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
}
