import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2

import "./"

Item {
    implicitWidth: 40
    implicitHeight: 28

    property Item control

    Rectangle {
        y: parent.height / 2 - height / 2
        width: 40
        height: 25
        radius: width /2
        border.color: control.visualFocus? Theme.focus(Theme.accent) :
                       (control.down? Theme.focusPressed(Theme.accent) :
                        (control.checked? Theme.accent : Theme.componentsBorder))
        color: control.checked? Theme.accent : Theme.components
    }

    Rectangle {
        x: Math.max(0, Math.min(parent.width - width, control.visualPosition * parent.width - (width / 2)))
        y: (parent.height - height) / 2
        width: 25
        height: width
        radius: width / 2
        color: Theme.lighter
        border.color: control.visualFocus? Theme.focus(Theme.accent) :
                       (control.down? Theme.focusPressed(Theme.accent) :
                        (control.checked? Theme.accent : Theme.componentsBorder))

        Behavior on x {
            enabled: !control.down
            SmoothedAnimation { velocity: 200 }
        }
    }
}
