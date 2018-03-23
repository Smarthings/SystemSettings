import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2
import QtQuick.Templates 2.2 as T

import "./"

T.RangeSlider {
    id: control

    readonly property bool isHorizontal: control.orientation === Qt.Horizontal

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
        Math.max(first.handle ? first.handle.implicitWidth : 0,
                 second.handle ? second.handle.implicitWidth : 0) + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
        Math.max(first.handle ? first.handle.implicitHeight : 0,
                 second.handle ? second.handle.implicitHeight : 0) + topPadding + bottomPadding)

    enabled: true
    opacity: enabled? 1.0 : 0.75
    padding: 0

    first.handle: Rectangle {
        x: control.leftPadding + (control.isHorizontal ? control.first.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.isHorizontal ? (control.availableHeight - height) / 2 : control.first.visualPosition * (control.availableHeight - height))
        implicitWidth: 25
        implicitHeight: 25
        radius: width / 2

        color: Theme.lighter
        border.color: control.visualFocus? Theme.accent: (control.first.pressed ? Theme.accent : Theme.border)
    }

    second.handle: Rectangle {
        x: control.leftPadding + (control.isHorizontal ? control.second.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.isHorizontal ? (control.availableHeight - height) / 2 : control.second.visualPosition * (control.availableHeight - height))
        implicitWidth: 25
        implicitHeight: 25
        radius: width / 2

        color: Theme.lighter
        border.color: control.visualFocus? Theme.accent: (control.second.pressed ? Theme.accent : Theme.border)
    }

    background: Rectangle {
        x: control.leftPadding + (control.isHorizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.isHorizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: control.isHorizontal ? 200 : 2
        implicitHeight: control.isHorizontal ? 2 : 200
        width: control.isHorizontal ? control.availableWidth : implicitWidth
        height: control.isHorizontal ? implicitHeight : control.availableHeight
        radius: 3
        color: Theme.border
        scale: control.isHorizontal && control.mirrored ? -1 : 1

        Rectangle {
            x: control.isHorizontal ? control.first.position * parent.width + 3 : 0
            y: control.isHorizontal ? 0 : control.second.visualPosition * parent.height + 3
            width: control.isHorizontal ? control.second.position * parent.width - control.first.position * parent.width - 3 : 2
            height: control.isHorizontal ? 2 : control.second.position * parent.height - control.first.position * parent.height - 3

            color: Theme.accent
        }
    }
}
