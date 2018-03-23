import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../UiTheme/"

Pane {
    width: parent.width
    height: parent.height

    GridView {
        id: grid
        width: Math.floor(parent.width / cellWidth) * cellWidth
        height: parent.height
        cellWidth: 150
        cellHeight: 150
        anchors.horizontalCenter: parent.horizontalCenter

        header: Text {
            width: parent.width
            height: implicitHeight * 1.5
            text: qsTr("Bem-vindo às Configurações do Sistema")
            font.pixelSize: 24
            wrapMode: Text.WordWrap
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }

        model: [
            {
                title: qsTr("Rede s/ fio"),
                icon: "\uE1BA",
                page: "qrc://",
                color: Theme.red
            },
            {
                title: qsTr("Rede c/ fio"),
                icon: "\uE8BE",
                page: "qrc://",
                color: Theme.green
            },
            {
                title: qsTr("Tela"),
                icon: "\uE333",
                page: "qrc://",
                color: Theme.orange
            },
            {
                title: qsTr("Sistema"),
                icon: "\uE88E",
                page: "qrc://",
                color: Theme.tealblue
            },
            {
                title: qsTr("Atualização"),
                icon: "\uE863",
                page: "qrc://",
                color: Theme.grey
            },
        ]
        delegate: Rectangle {
            width: grid.cellWidth - 15
            height: grid.cellHeight - 15
            color: component.pressed? Theme.color70(modelData.color) : modelData.color
            radius: 5
            clip: true

            ColumnLayout {
                anchors.fill: parent
                Text {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: modelData.icon
                    font.pixelSize: parent.height * 0.7
                    font.family: material_icons.name
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    color: Theme.darkText
                }

                Text {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 25
                    text: modelData.title
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    color: Theme.darkText
                    font.capitalization: Font.AllUppercase
                }
            }

            MouseArea {
                id: component
                anchors.fill: parent
                onPressed: {
                    ToolTip.show(modelData.title, 5000)
                }
            }
        }
        focus: true
    }
}
