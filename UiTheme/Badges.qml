import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2
import QtQuick.Templates 2.2 as T

import "./"

T.Control {
    id: control

    property int label
    property color color: Theme.warning
    property alias text: text

    height: Theme.implicitHeightComponents * 0.6
    width: height

    font.pixelSize: Theme.pixelSize * 0.75
    anchors.centerIn: parent

    Rectangle {
        anchors.fill: parent
        radius: width /2
        color: control.color

        Text {
            id: text
            text: control.label
            font: control.font
            color: Theme.darkText

            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter

            anchors.fill: parent
            elide: Text.ElideRight
        }
    }
}
