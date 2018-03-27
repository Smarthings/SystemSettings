import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../UiTheme/"

ScrollablePage {
    width: stackview.width
    height: stackview.height
    color: Theme.background

    property var headerPage: HeaderDefault {}
    property string titlePage: qsTr("Usuários")
}
