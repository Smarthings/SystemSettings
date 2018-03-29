import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Wireless 1.0

import "../UiTheme/"

ScrollablePage {
    id: page
    width: stackview.width
    height: stackview.height
    color: Theme.background

    paddingPane: 10
    sidebar: sideBar

    property var headerPage: HeaderDefault {}
    property string titlePage: qsTr("Rede s/ fio")

    Column {
        anchors.fill: parent
        spacing: 0

        TabBar {
            id: tabBar
            width: parent.width
            height: 40

            TabButton {
                width: implicitWidth + 15
                height: parent.height
                text: qsTr("Redes disponíveis")
                font.capitalization: Font.AllUppercase
                icon: "\uE8A9"
                iconSource: material_icons.name
                colorAccent: Theme.accent
            }

            TabButton {
                width: implicitWidth + 15
                height: parent.height
                text: qsTr("Informações da rede")
                font.capitalization: Font.AllUppercase
                icon: "\uE88F"
                iconSource: material_icons.name
                colorAccent: Theme.accent
            }
        }

        StackLayout {
            width: parent.width
            height: page.height - tabBar.height - 15
            currentIndex: tabBar.currentIndex

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                GroupBox {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    radius: 5

                    ListView {
                        width: parent.width
                        height: parent.height
                        clip: true

                        model: wireless.network_list
                        delegate: ItemDelegate {
                            width: parent.width
                            height: Theme.implicitHeightComponents * 1.2
                            text: modelData.ESSID

                            leftIcon: Text {
                                text: modelData.Encryption === "on" ? "\uE1E1" : "\uE1BA"
                                font.family: material_icons.name
                                anchors.fill: parent
                                color: Theme.rgba(Theme.text, (modelData.Quality.split("/")[0] / modelData.Quality.split("/")[1]).toFixed(2))
                                font.pixelSize: 18
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                            }

                            value: qsTr("Canal: ") + modelData.Channel

                            BorderBottom {}
                        }
                    }
                }
            }

            Item {
                width: parent.width
            }
        }

        Wireless {
            id: wireless

            //onNetwork_listChanged: console.log(Object.keys(network_list), Object.keys(network_list[0]))
        }

        Component.onCompleted: {
            wireless.setInterface("wlp2s0");
            wireless.scanWireless();
        }
    }
}
