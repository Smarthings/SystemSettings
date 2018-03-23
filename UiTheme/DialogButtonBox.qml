import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Templates 2.2 as T

import "."

T.DialogButtonBox {
    id: root

    signal accepted()
    signal rejected()
    signal reseted()

    padding: 5
    spacing: 1
    alignment: count === 1 ? Qt.AlignRight : undefined

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem.implicitHeight + topPadding + bottomPadding)

    delegate: Button {
        width: root.count === 1 ? root.availableWidth / 2 : undefined
        flat: true

        textStyle.color:
        switch (text) {
             case "OK": Theme.info; break;
             case "Cancel": Theme.error; break;
             default: Theme.text
        }
        textStyle.font.capitalization: Font.AllUppercase
    }

    contentItem: ListView {
        implicitWidth: contentWidth
        implicitHeight: Theme.implicitHeightComponents

        model: root.contentModel
        spacing: root.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapToItem
    }

    background: Rectangle {
        anchors.fill: parent
        color: "transparent"
    }
}
