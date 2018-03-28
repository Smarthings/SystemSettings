import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import "./"

Page {
    id: page

    default property alias content: pane.contentItem
    property int paddingPane: 0
    color: Theme.background

    property var sidebar: null

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Pane {
            padding: 0
            Layout.fillHeight: true
            Layout.preferredWidth: 200
            visible: page.sidebar !== null
            enabled: page.sidebar !== null

            Loader {
                sourceComponent: page.sidebar

            }
        }

        Flickable {
            Layout.fillHeight: true
            Layout.fillWidth: true
            contentHeight: pane.implicitHeight
            flickableDirection: Flickable.AutoFlickIfNeeded

            Pane {
                id: pane
                width: parent.width
                anchors.fill: parent
                anchors.margins: page.paddingPane

            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }
}
