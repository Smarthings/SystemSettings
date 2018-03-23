import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2
import QtQuick.Templates 2.2 as T

import "./"

T.TextArea {
    id: control

    property bool flat: false
    property bool noBorder: false

    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                            background ? background.implicitWidth : 0,
                                         placeholder.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             background ? background.implicitHeight : 0,
                                          placeholder.implicitHeight + topPadding + bottomPadding)

    padding: 6
    leftPadding: padding + 4

    color: enabled ? Theme.text : Theme.textDisabled
    selectionColor: Theme.focusLight(Theme.accent)
    selectedTextColor: color

    background: Item {
        anchors.fill: parent

        Rectangle {
            id: _normal
            visible: !flat && !noBorder
            anchors.fill: parent
            radius: 5
            color: Theme.components
            border.color: control.activeFocus? Theme.accent : Theme.componentsBorder
        }

        Rectangle {
            id: _flat
            visible: flat && !noBorder
            anchors.fill: parent
            radius: 5
            color: "transparent"

            Rectangle {
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom

                color: control.activeFocus? Theme.accent : Theme.componentsBorder
            }
        }
    }

    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)

        text: control.placeholderText
        font: control.font
        color: enabled ? Theme.color50(Theme.text) : Theme.color50(Theme.textDisabled)
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
    }
}
