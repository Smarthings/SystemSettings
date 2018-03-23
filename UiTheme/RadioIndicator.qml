import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2

import "./"

Rectangle {
    implicitWidth: 25
    implicitHeight: 25

    radius: width / 2
    color: Theme.components
    border.color: control.visualFocus? Theme.focus(Theme.accent) :
                   (control.down? Theme.focusPressed(Theme.accent) :
                    (control.checked? Theme.accent : Theme.componentsBorder))
    opacity: enabled ? 1 : 0.75

    property Item control

    Rectangle {
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 20 * 0.85
        height: 20 * 0.85
        radius: width / 2
        color: control.down? Theme.checkedPressed(Theme.accent) : Theme.accent
        visible: control.checked
    }
}
