import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Templates 2.2 as T

import "./"

T.Slider {
    id: control

    readonly property bool isHorizontal: control.orientation === Qt.Horizontal

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                           (handle ? handle.implicitWidth : 0) + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                            (handle ? handle.implicitHeight : 0) + topPadding + bottomPadding)

    enabled: true
    opacity: enabled? 1.0 : 0.75
    padding: 0

    handle: Rectangle {
        x: control.leftPadding + (isHorizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (isHorizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
        implicitWidth: 25
        implicitHeight: 25
        radius: width / 2
        color: Theme.lighter
        border.color: control.visualFocus? Theme.accent: (control.pressed ? Theme.accent : Theme.border)
    }

    background: Rectangle {
        x: control.leftPadding + (isHorizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (isHorizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: isHorizontal ? 200 : 2
        implicitHeight: isHorizontal ? 2 : 200
        width: isHorizontal ? control.availableWidth : implicitWidth
        height: isHorizontal ? implicitHeight : control.availableHeight
        radius: 3
        color: Theme.border
        scale: isHorizontal && control.mirrored ? -1 : 1

        Rectangle {
            x: control.isHorizontal ? control.visualPosition : 0
            y: control.isHorizontal ? 0 : control.visualPosition * parent.height
            width: control.isHorizontal ? control.position * parent.width : 2
            height: control.isHorizontal ? 2 : control.position * parent.height - 1

            radius: 3
            color: Theme.accent
        }
    }
}
