import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import "./UiTheme/"
import "./pages/"

ApplicationWindow {
    id: window
    visible: true
    width: 640
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
    }

    Component.onCompleted: Theme.dark = settings.dark

    StackView {
        id: stackview
        width: parent.width
        height: parent.height
        initialItem: HomePage {}
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
