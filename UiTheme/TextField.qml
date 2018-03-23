import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2
import QtQuick.Templates 2.2 as T

import "./"

T.TextField {
    id: control

    property bool flat: false
    property bool darker: false

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                                         placeholderText ? placeholder.implicitWidth + leftPadding + rightPadding : 0)
                   || contentWidth + leftPadding + rightPadding
    implicitHeight: Theme.implicitHeightComponents - padding * 2

    padding: 3.5
    leftPadding: padding + 4
    rightPadding: 25

    color: enabled ? Theme.text : Theme.textDisabled
    selectionColor: Theme.accent
    selectedTextColor: color
    verticalAlignment: TextInput.AlignVCenter
    selectByMouse: true

    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)

        text: control.placeholderText
        font: control.font
        color: enabled ? Default.textPlaceholderColor : Default.textDisabledColor
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
    }

    background: Item {

        Rectangle {
            anchors.fill: parent
            visible: !flat
            radius: height * 0.2

            border.width: control.activeFocus ? 2 : 1
            color: darker? Theme.componentsDarker : Theme.components
            border.color: darker? Theme.componentsDarker : (control.activeFocus? Theme.accent : Theme.componentsBorder)
        }

        Rectangle {
            anchors.fill: parent
            visible: flat
            radius: height * 0.1

            color: "transparent"
            border.width: 0

            Rectangle {
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                color: control.activeFocus? Theme.accent : Theme.componentsBorder
            }
        }

        Rectangle {
            visible: control.text !== "" && control.activeFocus
            width: 18
            height: width
            radius: width / 2

            x: parent.width - width - 5
            y: (parent.height /2) - (height /2)

            color: Theme.warning

            Rectangle {
                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                width: parent.width * 0.6
                height: 2
                color: Theme.lighter

                rotation: 45
            }
            Rectangle {
                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                width: 2
                height: parent.width * 0.6
                color: Theme.lighter

                rotation: 45
            }

            MouseArea {
                anchors.fill: parent
                onClicked: control.text = ""
            }
        }
    }
}
