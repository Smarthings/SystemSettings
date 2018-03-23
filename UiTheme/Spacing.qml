import QtQuick 2.9

Column {
    property int contentWidth: parent.width
    width: contentWidth - leftPadding - rightPadding

    leftPadding: 10
    rightPadding: 10
}
