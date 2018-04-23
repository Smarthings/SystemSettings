import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Wireless 1.0
import Network 1.0

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
            clip: true

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
            height: page.height
            currentIndex: tabBar.currentIndex

            // Redes disponíveis
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

                            onClicked: {
                                connectWifi.title = modelData.ESSID
                                connectWifi.open()
                            }

                            BorderBottom {}
                        }
                    }

                    Dialog {
                        id: connectWifi
                        width: 300
                        modal: true
                        radius: 5

                        Column {
                            width: parent.width
                            spacing: 10

                            TextField {
                                id: password_field
                                width: parent.width
                                echoMode: TextInput.Password
                                placeholderText: qsTr("Senha")

                                ToolTip {
                                    id: message

                                    timeout: 5000
                                    onTextChanged: {
                                        if (text !== "")
                                            message.visible = true
                                    }

                                    onVisibleChanged: {
                                        if (visible === false)
                                            text = ""
                                    }
                                }
                            }

                            Item {
                                width: parent.width
                                height: Theme.implicitHeightComponents * 1.2

                                Button {
                                    text: qsTr("Conectar")
                                    color: Theme.success
                                    anchors.right: parent.right

                                    onClicked: {
                                        if (password_field.text === "")
                                        {
                                            password_field.focus = true
                                            ToolTip.show(qsTr("Informe a senha"), 5000);
                                        }
                                        else
                                            wireless.setNetworkWireless({'ESSID': connectWifi.title, 'password': password_field.text});
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Informações da Rede
            Column {
                anchors.fill: parent
                spacing: 10

                GroupBox {
                    width: parent.width
                    title: qsTr("Tipo de configuração")
                    padding: 10
                    radius: 5

                    ComboBox {
                        id: configType
                        width: parent.width
                        model: ["Dinâmico", "Manual"]
                    }
                }

                Text {
                    width: parent.width
                    height: Theme.pixelSize * 2
                    text: "IPV4"
                    verticalAlignment: Qt.AlignVCenter
                    font.bold: true

                    BorderBottom {}
                }

                RowLayout {
                    width: parent.width

                    GroupBox {
                        Layout.fillWidth: true
                        title: qsTr("Endereço IPV4")
                        padding: 10
                        radius: 5

                        TextField {
                            width: parent.width
                            text: wireless.info["wlp2s0"].ipv4.address
                            enabled: configType.currentIndex
                            flat: !configType.currentIndex
                        }
                    }

                    GroupBox {
                        Layout.fillWidth: true
                        title: qsTr("Gateway")
                        padding: 10
                        radius: 5

                        TextField {
                            width: parent.width
                            text: wireless.info["wlp2s0"].ipv4.gateway
                            enabled: configType.currentIndex
                            flat: !configType.currentIndex
                        }
                    }
                }

                RowLayout {
                    width: parent.width

                    GroupBox {
                        Layout.fillWidth: true
                        title: qsTr("Broadcast")
                        padding: 10
                        radius: 5

                        TextField {
                            width: parent.width
                            text: wireless.info["wlp2s0"].ipv4.broadcast
                            enabled: configType.currentIndex
                            flat: !configType.currentIndex
                        }
                    }

                    GroupBox {
                        Layout.fillWidth: true
                        title: qsTr("Mascara de Rede")
                        padding: 10
                        radius: 5

                        TextField {
                            width: parent.width
                            text: wireless.info["wlp2s0"].ipv4.netmask
                            enabled: configType.currentIndex
                            flat: !configType.currentIndex
                        }
                    }
                }
                /*
                Text {
                    width: parent.width
                    height: Theme.pixelSize * 2
                    text: "IPV6"
                    verticalAlignment: Qt.AlignVCenter
                    font.bold: true

                    BorderBottom {}
                }

                RowLayout {
                    width: parent.width

                    GroupBox {
                        Layout.fillWidth: true
                        title: qsTr("Endereço IPV4")
                        padding: 10
                        radius: 5

                        TextField {
                            width: parent.width
                            text: wireless.info["wlp2s0"].ipv6.address
                            enabled: configType.currentIndex
                            flat: !configType.currentIndex
                        }
                    }

                    GroupBox {
                        Layout.fillWidth: true
                        title: qsTr("Gateway")
                        padding: 10
                        radius: 5

                        TextField {
                            width: parent.width
                            text: ""
                            enabled: configType.currentIndex
                            flat: !configType.currentIndex
                        }
                    }
                }

                RowLayout {
                    width: parent.width

                    GroupBox {
                        Layout.fillWidth: true
                        title: qsTr("Broadcast")
                        padding: 10
                        radius: 5

                        TextField {
                            width: parent.width
                            text: wireless.info["wlp2s0"].ipv6.broadcast
                            enabled: configType.currentIndex
                            flat: !configType.currentIndex
                        }
                    }

                    GroupBox {
                        Layout.fillWidth: true
                        title: qsTr("Mascara de Rede")
                        padding: 10
                        radius: 5

                        TextField {
                            width: parent.width
                            text: wireless.info["wlp2s0"].ipv6.netmask
                            enabled: configType.currentIndex
                            flat: !configType.currentIndex
                        }
                    }
                }
                */
            }
        }

        Wireless {
            id: wireless
            onErrorChanged: message.text = wireless.error.split(":").slice(1).join(" ").trim();
            onNetworkWirelessChanged: {
                if (networkWireless.status)
                    connectWifi.close();
            }
        }

        Component.onCompleted: {
            wireless.setInterface("wlp2s0");
            wireless.scanWireless();
            wireless.abstractInfo();
        }
    }
}
