import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2

import "./"

Rectangle {
    id: indicator

    property Item control

    implicitWidth: 25
    implicitHeight: 25

    border.color: control.visualFocus? Theme.focus(Theme.accent) :
                   (control.down? Theme.focusPressed(Theme.accent) :
                    (control.checked? Theme.accent : Theme.componentsBorder))
    color: control.checked? Theme.accent : Theme.components

    opacity: enabled ? 1 : 0.75

    Item {
        y: 2.5
        x: 1
        width: height
        height: Theme.implicitHeightComponents * 0.5

        Rectangle {
            x: width * 0.20
            y: (parent.height /2) * 1.25
            width: parent.width * 0.5
            height: 2
            color: control.checkState === Qt.Checked? Theme.components : "transparent"

            radius: 5
            rotation: 45
        }

        Rectangle {
            x: width * 0.34
            y: parent.height /2
            width: parent.width
            height: 2
            color: control.checkState === Qt.Checked? Theme.components : "transparent"

            radius: 5
            rotation: -50
        }
    }

    Rectangle {
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 16
        height: 3
        color: control.visualFocus ? Theme.focus(Theme.accent) : Theme.components
        visible: control.checkState === Qt.PartiallyChecked
    }
}
