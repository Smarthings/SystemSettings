import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Templates 2.2 as T
import QtGraphicalEffects 1.0

import "."

T.Dialog {
    id: dialog

    property color color: Theme.background
    property bool border: false
    property int header_height: ApplicationWindow.header.height
    property bool blur: false
    property int radius: 2

    parent: ApplicationWindow.overlay

    x: (parent.width - width) /2
    y: (parent.height - height) /2

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            header && header.visible ? header.implicitWidth : 0,
                            footer && footer.visible ? footer.implicitWidth : 0,
                            contentWidth > 0 ? contentWidth + leftPadding + rightPadding : 0) + padding * 2
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             (header && header.visible ? header.implicitHeight + spacing : 0)
                             + (footer && footer.visible ? footer.implicitHeight + spacing : 0)
                             + (contentHeight > 0 ? contentHeight + topPadding + bottomPadding : 0)) + padding * 2

    contentWidth: contentItem.implicitWidth || (contentChildren.length === 1 ? contentChildren[0].implicitWidth : 0)
    contentHeight: contentItem.implicitHeight || (contentChildren.length === 1 ? contentChildren[0].implicitHeight : 0)

    padding: 10
    clip: true

    background: Rectangle {
        id: background
        anchors.fill: parent
        color: Qt.rgba(dialog.color.r, dialog.color.g, dialog.color.b, 1)
        border.color: dialog.modal || !dialog.border? "transparent" : Theme.componentsBorder
        radius: dialog.radius

        FastBlur {
            id: fastBlur
            visible: dialog.blur
            anchors.fill: parent
            radius: 80
            opacity: 0.3

            source: ShaderEffectSource {
                anchors.fill: parent
                sourceItem: ApplicationWindow.contentItem // window.contentItem
                sourceRect: Qt.rect(dialog.x, dialog.y - header_height, background.width, background.height)
            }
        }
    }

    header: Item {
        visible: title
        width: parent.width
        height: Theme.implicitHeightComponents

        Text {
            anchors.fill: parent

            text: dialog.title
            font.pixelSize: parent.height * 0.5
            font.bold: true

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
    }

    footer: DialogButtonBox {
        visible: count > 0
        height: Theme.implicitHeightComponents
    }
}
