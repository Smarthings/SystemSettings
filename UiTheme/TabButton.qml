import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2
import QtQuick.Templates 2.2 as T
import QtQuick.Layouts 1.3

import "./"

T.TabButton {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem.implicitHeight + topPadding + bottomPadding)
    baselineOffset: contentItem.y + contentItem.baselineOffset

    padding: 6
    leftPadding: padding + 2
    rightPadding: padding + 2

    property bool horizontal: true
    property string icon
    property var iconSource: control.font
    property int iconPixelSize: Theme.pixelSize * 1.5

    font.pixelSize: Theme.pixelSize

    Component {
        id: buttonHorizontal

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Text {
                visible: control.icon
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignRight
                text: control.icon
                font.family: control.iconSource
                font.pixelSize: control.iconPixelSize
                color: control.checked? Theme.color70(Theme.text) : Theme.text
            }

            Text {
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: control.horizontal? Qt.AlignHCenter : Qt.AlignLeft
                text: control.text
                font: control.font
                color: control.checked? Theme.color70(Theme.text) : Theme.text
            }
        }
    }

    Component {
        id: buttonVertical

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Text {
                visible: control.icon
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Qt.AlignBottom
                horizontalAlignment: Qt.AlignHCenter
                text: control.icon
                font.family: control.iconSource
                font.pixelSize: control.iconPixelSize
                color: control.checked? Theme.color70(Theme.text) : Theme.text
            }

            Text {
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: control.icon? Qt.AlignTop : Qt.AlignHCenter
                horizontalAlignment: Qt.AlignHCenter
                text: control.text
                font: control.font
                color: control.checked? Theme.color70(Theme.text) : Theme.text
            }
        }
    }

    contentItem: Loader {
        sourceComponent: control.horizontal? buttonHorizontal : buttonVertical
    }

    background: Rectangle {
        color: "transparent"
    }
}
