import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../UiTheme/"

ScrollablePage {
    width: parent.width
    color: Theme.background
    paddingPane: 15

    Column {
        width: parent.width
        spacing: 20

        Text {
            width: parent.width
            text: qsTr("Desenvolvido em")
            horizontalAlignment: Qt.AlignRight
        }

        GroupBox {
            width: parent.width
            padding: 10
            radius: 5

            Image {
                source: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Qt_logo_2016.svg/1280px-Qt_logo_2016.svg.png"
                width: parent.width
                fillMode: Image.PreserveAspectFit
            }
        }
    }
}
