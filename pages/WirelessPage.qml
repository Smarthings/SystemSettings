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

    function availableNetworks()
    {
        model_availableNetworks.clear();
        var available_networks = wireless.network_list.sort(function (a, b)
        {
            if (a.Quality < b.Quality)
                return 1;
            if (a.Quality > b.Quality)
                return -1;
            return 0;
        });
        for (var i = 0; i < available_networks.length; ++i)
        {
            model_availableNetworks.append(available_networks[i]);
        }
    }

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

                    ListModel {
                        id: model_availableNetworks
                    }

                    ListView {
                        id: listviewAvailableNetworks
                        width: parent.width
                        height: parent.height
                        clip: true

                        model: model_availableNetworks

                        delegate: ItemDelegate {
                            width: parent.width
                            height: Theme.implicitHeightComponents * 1.2
                            text: ESSID
                            highlighted: ESSID === wireless.connected

                            leftIcon: Text {
                                text: Encryption? "\uE1E1" : "\uE1BA"
                                font.family: material_icons.name
                                anchors.fill: parent
                                color: Theme.rgba(Theme.text, (Quality.split("/")[0] / Quality.split("/")[1]).toFixed(2))
                                font.pixelSize: 18
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                            }

                            valueControl: Text {
                                visible: saved
                                text: saved? "\uE161" : ""
                                font.family: material_icons.name
                                anchors.fill: parent
                                color: Theme.rgba(Theme.text, 0.7)
                                font.pixelSize: 18
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                            }

                            onClicked: {
                                if (ESSID === wireless.connected)
                                {
                                    connectedWifi.networkData = {
                                        'ESSID': ESSID,
                                        'Encryption': Encryption,
                                        'Saved': saved
                                    };
                                    connectedWifi.open()
                                }
                                else
                                {
                                    connectWifi.networkData = {
                                        'ESSID': ESSID,
                                        'Encryption': Encryption,
                                        'Saved': saved
                                    };
                                    connectWifi.open()
                                }
                            }

                            BorderBottom {}
                        }
                    }

                    Dialog {
                        id: connectWifi
                        width: (window.width <= 360)? 300 : 400
                        modal: true
                        radius: 5

                        property var networkData: {
                            'ESSID': '',
                                    'Encryption': '',
                                    'Saved': '',
                                    'Password': ''
                        }

                        title: qsTr("Conectar à ") + networkData.ESSID

                        Column {
                            width: parent.width - (leftPadding + rightPadding)
                            leftPadding: 10
                            rightPadding: 10
                            spacing: 10

                            TextField {
                                id: password_field
                                enabled: connectWifi.networkData.Encryption && !connectWifi.networkData.Saved
                                visible: connectWifi.networkData.Encryption && !connectWifi.networkData.Saved
                                width: parent.width
                                echoMode: TextInput.Password
                                placeholderText: qsTr("Senha")

                                Keys.onReturnPressed: buttonConnect.clicked()
                                Keys.onEnterPressed: buttonConnect.clicked()

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

                            RowLayout {
                                width: parent.width
                                height: Theme.implicitHeightComponents * 2
                                spacing: 5

                                Button {
                                    enabled: connectWifi.networkData.Saved
                                    visible: connectWifi.networkData.Saved
                                    Layout.fillWidth: true
                                    text: qsTr("Esquecer esta rede")

                                    onClicked: {
                                        if (!wireless.forgetWirelessNetwork(connectWifi.networkData))
                                            ToolTip.show("Ocorreu algum erro", 5000)
                                        connectWifi.close();
                                        connectWifi.networkData = {
                                            'ESSID': '',
                                            'Encryption': '',
                                            'Saved': '',
                                            'Password': ''
                                        }
                                    }
                                }

                                Button {
                                    id: buttonConnect
                                    Layout.fillWidth: true
                                    text: qsTr("Conectar")
                                    color: Theme.success

                                    onClicked: {
                                        if (password_field.text === "" && connectWifi.networkData.Encryption && !connectWifi.networkData.Saved)
                                        {
                                            password_field.focus = true
                                            ToolTip.show(qsTr("Informe a senha"), 5000);
                                        }
                                        else
                                        {
                                            connectWifi.networkData.Password = password_field.text
                                            if (wireless.setNetworkWireless(connectWifi.networkData))
                                            {
                                                connectWifi.networkData = {
                                                    'ESSID': '',
                                                    'Encryption': '',
                                                    'Saved': '',
                                                    'Password': ''
                                                }
                                            }
                                            password_field.text = ""
                                            connectWifi.close();
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Dialog {
                        id: connectedWifi
                        width: (window.width <= 360)? 300 : 400
                        modal: true
                        radius: 5

                        property var networkData: {
                            'ESSID': '',
                                    'Encryption': '',
                                    'Saved': '',
                                    'Password': ''
                        }

                        title: networkData.ESSID

                        Column {
                            width: parent.width

                            RowLayout {
                                width: parent.width
                                height: Theme.implicitHeightComponents * 2
                                spacing: 5

                                Button {
                                    Layout.fillWidth: true
                                    text: qsTr("Esquecer esta rede")

                                    onClicked: {
                                        if (!wireless.forgetWirelessNetwork(connectedWifi.networkData))
                                            ToolTip.show("Ocorreu algum erro", 5000)
                                        connectedWifi.close();
                                        connectedWifi.networkData = {
                                            'ESSID': '',
                                            'Encryption': '',
                                            'Saved': '',
                                            'Password': ''
                                        }
                                    }
                                }

                                Button {
                                    Layout.fillWidth: true
                                    text: qsTr("Desconectar")
                                    color: Theme.warning
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
            onNetwork_listChanged: availableNetworks()
        }

        Component.onCompleted: {
            wireless.setInterface("wlp2s0");
            wireless.scanWireless();
            wireless.abstractInfo();
        }
    }
}
