import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2
import QtQuick.Templates 2.2 as T

import "./"

T.ToolSeparator {
    id: control

    property color border: Theme.text

    implicitWidth: Math.max(background ? background.implicitWidth : 0, contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0, contentItem.implicitHeight + topPadding + bottomPadding)

    padding: vertical ? 5 : 2
    topPadding: vertical ? 2 : 5
    bottomPadding: vertical ? 2 : 5

    contentItem: Rectangle {
        implicitWidth: vertical ? 1 : 30
        implicitHeight: vertical ? 30 : 1
        color: control.border
    }
}
