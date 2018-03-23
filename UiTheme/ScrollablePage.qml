import QtQuick 2.9
import QtQuick.Controls 2.0

import "./"

Page {
    id: page

    default property alias content: pane.contentItem
    color: Theme.background

    Flickable {
        anchors.fill: parent
        contentHeight: pane.implicitHeight
        flickableDirection: Flickable.AutoFlickIfNeeded

        Pane {
            id: pane
            width: parent.width

            padding: 0
            topPadding: 10
            bottomPadding: 8
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }
}
