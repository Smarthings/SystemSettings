import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2
import QtQuick.Templates 2.2 as T

import "./"

T.GroupBox {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0, contentWidth + leftPadding + rightPadding)
    implicitHeight: autoAlign? (heightChildren + topPadding + bottomPadding) : (Math.max(background ? background.implicitHeight : 0, contentHeight + topPadding + bottomPadding))

    contentWidth: contentItem.implicitWidth || (contentChildren.length === 1 ? contentChildren[0].implicitWidth : 0)
    contentHeight: contentItem.implicitHeight || (contentChildren.length === 1 ? contentChildren[0].implicitHeight : 0)

    padding: 1
    topPadding: padding + (label && label.implicitWidth > 0 ? label.implicitHeight + spacing + 2 : 0)

    property int radius: 0
    property color backgroundColor: Theme.view
    property color borderColor: Theme.border
    property bool border: false
    property bool borderTop: false
    property bool borderBottom: false
    property bool autoAlign: false
    property bool autoAlignBorder: false

    label: Text {
        x: control.leftPadding
        width: control.availableWidth

        text: control.title
        font.pixelSize: Theme.pixelSize * 0.8
        font.capitalization: Font.AllUppercase
        color: control.enabled ? Theme.color50(Theme.text) : Theme.color50(Theme.textDisabled)
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        y: control.topPadding - control.padding
        width: parent.width
        height: parent.height - control.topPadding + control.padding

        color: control.backgroundColor
        radius: control.radius
        border.color: control.borderColor
        border.width: control.border? 1 : 0

        Rectangle {
            visible: control.padding === 1 && control.border || control.borderTop
            width: parent.width
            height: 1
            color: control.borderColor

            anchors.top: background.top
        }

        Rectangle {
            visible: control.padding === 1 && control.border || control.borderBottom
            width: parent.width
            height: 1
            color: control.borderColor

            anchors.bottom: background.bottom
        }
    }

    property int heightChildren: 0

    Component.onCompleted: if (autoAlign) alignChildren();
    function alignChildren()
    {
        var childrens = control.contentChildren.length;
        var children = control.contentChildren;

        for (var i = 0; i < childrens; ++i) {
            children[i].y = heightChildren;
            heightChildren += children[i].implicitHeight;

            if (i + 1 !== childrens && autoAlignBorder)
            {
                var borderBottom = Qt.createComponent("BorderBottom.qml");
                borderBottom.createObject(children[i]);
            }
        }
    }
}
