import QtQuick 2.9
import "./"

Rectangle {
    id: control
    property color borderColor: Theme.borderBottom

    width: parent.width
    height: 1
    color: control.borderColor

    anchors.bottom: parent.bottom
}
