import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../UiTheme/"

ToolBar {
    height: 50
    color: settings.toolbarAccentColor? Theme.accent : Theme.background

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: 5

        ToolButton {
            text: stackview.depth > 1 ? "\uE314" : "\uE5D2"
            font.family: material_icons.name
            radius: width /2
            font.pixelSize: 24

            visible: stackview.depth > 1
            onClicked: stackview.pop()
        }

        Text {
            Layout.fillWidth: true
            padding: 10
            verticalAlignment: Qt.AlignVCenter
            text: titlePage
            font.pixelSize: 20
        }
    }
}
