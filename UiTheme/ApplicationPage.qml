import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Templates 2.2 as T

T.Page {
    id: page
    //default property alias content: pane.contentItem
    property int margin: 0
    property int marginTop: 10
    property color color: "transparent"

    background: Rectangle {
        anchors.fill: parent
        color: page.color
    }

    /*Flickable {
        width: parent.width
        height: pane.implicitHeight - page.marginTop * 4

        flickableDirection: Flickable.AutoFlickIfNeeded
        contentHeight: pane.implicitHeight

        Pane {
            id: pane
            width: parent.width
            padding: page.margin

            anchors.top: parent.top
            anchors.topMargin: page.marginTop

            background: Rectangle {
                anchors.fill: parent
                color: "transparent"
            }
        }

        ScrollIndicator.vertical: ScrollIndicator {}
    }*/
}
