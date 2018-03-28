import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import "./UiTheme/"
import "./pages/"

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 480

    title: qsTr("Configurações do Sistema")
    font: ubuntu.name
    color: Theme.background

    Settings {
        id: settings

        property bool dark: true
        onDarkChanged: Theme.dark = dark

        property color accent: Theme.green
        onAccentChanged: Theme.accent = accent

        property bool toolbarAccentColor: false

        property bool darkNightMode: false
    }

    property string titlePage
    Component.onCompleted: Theme.dark = settings.dark
    property var menus: [
        {
            title: qsTr("Rede s/ fio"),
            icon: "\uE1BA",
            page: "qrc:/pages/WirelessPage.qml",
            color: Theme.indigo
        },
        {
            title: qsTr("Rede c/ fio"),
            icon: "\uE8BE",
            page: "qrc:/pages/WiredPage.qml",
            color: Theme.blue
        },
        {
            title: qsTr("Tela"),
            icon: "\uE333",
            page: "qrc:/pages/DisplayPage.qml",
            color: Theme.orange
        },
        {
            title: qsTr("Usuários"),
            icon: "\uE8D3",
            page: "qrc:/pages/UsersPage.qml",
            color: Theme.deeporange
        },
        {
            title: qsTr("Data e Hora"),
            icon: "\uE916",
            page: "qrc:/pages/DateTimePage.qml",
            color: Theme.red
        },
        {
            title: qsTr("Idioma e Região"),
            icon: "\uE8E2",
            page: "qrc:/pages/LanguagePage.qml",
            color: Theme.green
        },
        {
            title: qsTr("Aparência"),
            icon: "\uE243",
            page: "qrc:/pages/ThemePage.qml",
            color: Theme.lightgreen
        },
        {
            title: qsTr("Sistema"),
            icon: "\uE88E",
            page: "qrc:/pages/SystemPage.qml",
            color: Theme.teal
        },
        {
            title: qsTr("Atualização"),
            icon: "\uE863",
            page: "qrc:/pages/UpdatePage.qml",
            color: Theme.bluegrey
        },
    ]

    Component {
        id: sideBar

        GroupBox {
            width: parent.parent.width
            height: parent.parent.height
            radius: 5

            ListView {
                width: parent.width
                height: parent.height
                clip: true
                currentIndex: -1
                model: menus

                delegate: ItemDelegate {
                    width: parent.width
                    implicitHeight: Theme.implicitHeightComponents * 1.5

                    leftIcon: Text {
                        anchors.fill: parent
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        text: modelData.icon
                        font.family: material_icons.name
                        font.pixelSize: Theme.pixelSize * 1.5
                        color: modelData.color
                    }

                    text: modelData.title
                    isItemMenu: true

                    BorderBottom {}

                    onClicked: {
                        stackview.push(modelData.page)
                    }
                }
            }
        }
    }

//    RowLayout {
//        anchors.fill: parent
//        spacing: 5

//        Pane {
//            padding: 0
//            Layout.fillHeight: true
//            Layout.preferredWidth: 200
//            visible: stackview.depth > 1
//            enabled: stackview.depth > 1
//            //backgroundColor: Theme.view

//            Loader {
//                sourceComponent: sidebar
//            }
//        }
//    }

    StackView {
        id: stackview
        width: parent.width
        height: parent.height
        Layout.fillHeight: true
        Layout.fillWidth: true
        initialItem: HomePage {}

        onCurrentItemChanged: {
            titlePage = stackview.currentItem.titleHeader ? stackview.currentItem.titleHeader : qsTr("Configurações do Sistema")
            window.header = stackview.currentItem.headerPage ? stackview.currentItem.headerPage : ""
        }
    }



    FontLoader {
        id: ubuntu
        name: "Ubuntu"
        source: "qrc:/UiTheme/fonts/Ubuntu.ttf"
    }

    FontLoader {
        id: material_icons
        source: "qrc:/UiTheme/fonts/MaterialIcons.ttf"
    }
}
