import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2
import QtQuick.Templates 2.2 as T

import "./"

T.SpinBox {
    id: control

    padding: 5
    implicitHeight: Theme.implicitHeightComponents

    leftPadding: padding
    rightPadding: up.indicator && down.indicator? (up.indicator.width + down.indicator.width): padding

    validator: IntValidator {
        locale: control.locale.name
        bottom: Math.min(control.from, control.to)
        top: Math.max(control.from, control.to)
    }

    contentItem: TextInput {
        z: 2
        text: control.textFromValue(control.value, control.locale)
        width: parent.width
        height: parent.height - padding * 2

        opacity: control.enabled ? 1 : 0.3

        font: control.font
        color: Theme.text
        selectionColor: Theme.checkedFocus(Theme.accent)
        selectedTextColor: Theme.checked(Theme.accent)
        verticalAlignment: Qt.AlignVCenter

        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: control.inputMethodHints
    }

    Rectangle {
        visible: control.focus && control.editable
        width: up.indicator && down.indicator? parent.width - padding - (up.indicator.width + down.indicator.width) : parent.width - padding
        height: 1
        color: Theme.accent
        anchors.bottom: parent.bottom
    }

    up.indicator: Item {
        x: parent.width - width
        y: padding
        height: parent.height - padding * 2

        implicitWidth: 40

        Rectangle {
            width: parent.width
            height: parent.height

            radius: 5
            color: up.clicked || up.pressed || up.focus ? Theme.accent : "transparent"

            Rectangle {
                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                width: parent.width / 3
                height: 2
                color: up.clicked || up.pressed || up.focus ? Theme.text : Theme.accent
            }
            Rectangle {
                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                width: 2
                height: parent.width / 3
                color: up.clicked || up.pressed || up.focus ? Theme.text : Theme.accent
            }

            Rectangle {
                width: 2
                height: parent.height
                anchors.left: parent.left
                color: up.clicked || up.pressed || up.focus ? Theme.accent : "transparent"
            }
        }
    }

    down.indicator: Item {
        x: parent.width - (width + up.indicator.width)
        y: padding
        height: parent.height - padding * 2

        implicitWidth: 40

        Rectangle {
            width: parent.width
            height: parent.height

            radius: 5
            color: down.clicked || down.pressed || down.focus ? Theme.accent : "transparent"

            Rectangle {
                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                width: parent.width / 3
                height: 2
                color: down.clicked || down.pressed || down.focus ? Theme.text : Theme.accent
            }

            Rectangle {
                width: 2
                height: parent.height
                anchors.right: parent.right

                color: down.clicked || down.pressed || down.focus ? Theme.accent : "transparent"
            }
        }
    }

    Rectangle {
        width: up.indicator && down.indicator? (up.indicator.width + down.indicator.width): 0
        height: up.indicator && down.indicator? (up.indicator.height): 0
        x: up.indicator && down.indicator? parent.width - width: 0
        y: padding

        radius: 5
        color: "transparent"
        border.color: Theme.accent

        Rectangle {
            width: 1
            height: parent.height

            x: parent.width /2
            color: Theme.accent
        }
    }

    background: Rectangle {
        implicitWidth: 140
        color: "transparent"
    }
}
