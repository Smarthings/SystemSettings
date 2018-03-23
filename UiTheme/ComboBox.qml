import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2
import QtQuick.Templates 2.2 as T
import QtGraphicalEffects 1.0

import "./"

T.ComboBox {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth * 1.1 : 0,
                                         contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight * 1.1 : Theme.implicitHeightComponents,
                                          Math.max(contentItem.implicitHeight,
                                                   indicator ? indicator.implicitHeight : Theme.implicitHeightComponents) + topPadding + bottomPadding)

    baselineOffset: contentItem.y + contentItem.baselineOffset

    delegate: ItemDelegate {
        width: parent.width
        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
        font.weight: control.currentIndex === index ? Font.DemiBold : Font.Normal
        highlighted: control.highlightedIndex === index
        hoverEnabled: control.hoverEnabled
    }

    indicator: Item {
        x: control.mirrored ? control.padding - 5 : control.width - width - control.padding - 5
        y: control.topPadding + (control.availableHeight - height) / 2
        width: height
        height: Theme.implicitHeightComponents * 0.5

        rotation: popup.visible? 180 : 0

        Rectangle {
            x: width * 0.20
            y: parent.height /2
            width: parent.width * 0.5
            height: 2
            color: control.editable || control.visualFocus?
                       (control.pressed? Theme.focusPressed(Theme.accent) : Theme.focusLight(Theme.accent))
                     : (control.down || popup.visible? Theme.pressed(Theme.accent) : Theme.text)

            radius: 5
            rotation: 45
        }

        Rectangle {
            x: width * 0.85
            y: parent.height /2
            width: parent.width * 0.5
            height: 2
            color: control.editable || control.visualFocus?
                       (control.pressed? Theme.focusPressed(Theme.accent) : Theme.focusLight(Theme.accent))
                     : (control.down || popup.visible? Theme.pressed(Theme.accent) : Theme.text)

            radius: 5
            rotation: -45
        }

        Behavior on rotation {
            NumberAnimation {
                duration: 150
            }
        }
    }



    contentItem: T.TextField {
        leftPadding: !control.mirrored ? 12 : control.editable && activeFocus ? 3 : 1
        rightPadding: control.mirrored ? 12 : control.editable && activeFocus ? 3 : 1
        topPadding: 6 - control.padding
        bottomPadding: 6 - control.padding

        text: control.editable ? control.editText : control.displayText

        enabled: control.editable
        autoScroll: control.editable
        readOnly: control.popup.visible
        inputMethodHints: control.inputMethodHints
        validator: control.validator

        font: control.font
        color: !control.editable && control.visualFocus ? Theme.textComponentsFocus : Theme.text
        selectionColor: Theme.focus(Theme.accent)
        selectedTextColor: Theme.focusLight(Theme.accent)
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        opacity: control.enabled ? 1 : 0.3

        background: Rectangle {
            visible: control.editable && !control.flat
            border.width: 1
            border.color: parent && parent.activeFocus ? Theme.focus(Theme.accent) : Theme.text
            radius: height * 0.2
        }
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 25

        color: Theme.components
        border.color: control.editable || control.visualFocus?
                          (control.pressed? Theme.focusPressed(Theme.accent) : Theme.focusLight(Theme.accent))
                        : (control.down || popup.visible? Theme.pressed(Theme.accent) : Theme.componentsBorder)
        border.width: 1
        radius: height * 0.2
        visible: !control.flat || control.down
    }

    popup: T.Popup {
        y: control.height + 5
        width: control.width
        height: Math.min(contentItem.implicitHeight, control.Window.height - topMargin - bottomMargin)

        margins: 2
        padding: 0
        topPadding: 5
        bottomPadding: 5

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            highlightRangeMode: ListView.ApplyRange
            highlightMoveDuration: 0

            Rectangle {
                width: parent.width
                height: parent.height
                color: "transparent"
            }

            T.ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            anchors.fill: parent
            color: Theme.components
            border.color: Theme.componentsBorder
            radius: 5
        }

        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0.0
                to: 1.0
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
            }
        }
    }
}
