import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../UiTheme/"

Pane {
    width: parent.width
    height: parent.height
    property var headerPage: HeaderDefault {}
    clip: true
    backgroundColor: Theme.background

    GridView {
        id: grid
        width: Math.floor(parent.width / cellWidth) * cellWidth
        height: parent.height
        cellWidth: 150
        cellHeight: 150
        anchors.horizontalCenter: parent.horizontalCenter

        model: menus

        delegate: Rectangle {
            width: grid.cellWidth - 15
            height: grid.cellHeight - 15
            color: Theme.components //component.pressed? Theme.color70(modelData.color) : modelData.color
            radius: 10
            clip: true

            ColumnLayout {
                anchors.fill: parent

                Text {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: modelData.icon
                    font.pixelSize: (parent.height - parent.children[1].height) * 0.7
                    font.family: material_icons.name
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    color: modelData.color //Theme.darkText
                }

                Text {
                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight + 5
                    text: modelData.title
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    //color: Theme.darkText
                    font.capitalization: Font.AllUppercase
                    wrapMode: Text.WordWrap
                }
            }

            MouseArea {
                id: component
                anchors.fill: parent
                onClicked: stackview.push(modelData.page)
            }
        }
        focus: true
    }
}
