import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../UiTheme/"

ScrollablePage {
    width: stackview.width
    height: stackview.height
    color: Theme.background

    property var headerPage: HeaderDefault {}
    property string titlePage: qsTr("Aparência")

    Column {
        anchors.fill: parent
        spacing: 20

        GroupBox {
            width: parent.width
            radius: 5
            padding: 10
            title: qsTr("Tema")

            SwitchDelegate {
                width: parent.width
                height: 40
                text: "Dark"

                checked: settings.dark
                onCheckedChanged: settings.dark = checked
            }
        }

        GroupBox {
            width: parent.width
            radius: 5
            padding: 10
            title: qsTr("Cor principal do Tema")

            ComboBox {
                width: parent.width
                implicitHeight: Theme.implicitHeightComponents
                currentIndex: -1

                model: [
                    "Lighter",
                    "Grey",
                    "LightGrey",
                    "Blue",
                    "Teal blue",
                    "Green",
                    "Yellow",
                    "Red",
                    "Orange",
                    "Purple",
                    "Pink"
                ]

                onCurrentIndexChanged: {
                    settings.accent = Theme.getColor(currentIndex);
                }
            }
        }

        GroupBox {
            width: parent.width
            radius: 5
            padding: 10
            title: qsTr("Ajuste do Tema automático")

            SwitchDelegate {
                enabled: !settings.dark
                width: parent.width
                height: 40
                text: qsTr("Habilitar tema Dark durante a noite")

                checked: settings.darkNightMode
                onCheckedChanged: settings.darkNightMode = checked
            }
        }

        GroupBox {
            width: parent.width
            radius: 5
            padding: 10
            title: qsTr("Barra de Menu")

            SwitchDelegate {
                width: parent.width
                height: 40
                text: qsTr("Usar 'Cor principal do Tema'")
                checked: settings.toolbarAccentColor
                onCheckedChanged: settings.toolbarAccentColor = checked
            }
        }
    }
}
