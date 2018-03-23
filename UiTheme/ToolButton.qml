import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2
import QtQuick.Templates 2.2 as T

import "./"

T.ToolButton {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0, contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0, contentItem.implicitHeight + topPadding + bottomPadding)
    baselineOffset: contentItem.y + contentItem.baselineOffset

    padding: 2
    property int radius: 0

    contentItem: Text {
        text: control.text
        font: control.font
        color: control.enabled ? (control.visualFocus ? Theme.focus(Theme.accent) : Theme.text) : Theme.textDisabled
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        implicitWidth: Theme.implicitHeightComponents
        implicitHeight: Theme.implicitHeightComponents

        color: Qt.darker(Default.toolButtonColor, control.enabled && (control.checked || control.highlighted) ? 1.5 : 1.0)
        opacity: control.down ? 1.0 : control.enabled && (control.checked || control.highlighted) ? 0.5 : 0
        visible: control.down || (control.enabled && (control.checked || control.highlighted))
        radius: control.radius
    }
}
