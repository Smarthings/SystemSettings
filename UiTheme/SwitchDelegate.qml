import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.impl 2.2
import QtQuick.Templates 2.2 as T

import "./"

T.SwitchDelegate {
    id: control

    font.pixelSize: Theme.pixelSize

    implicitHeight: Theme.implicitHeightComponents
    padding: 10
    spacing: 10

    enabled: true
    opacity: enabled? 1.0 : 0.75

    indicator: SwitchIndicator {
        x: text ? (control.mirrored ? control.leftPadding : control.width - width - control.rightPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        control: control
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? 0 : control.indicator.width + control.spacing
        rightPadding: control.indicator && control.mirrored ? 0 : control.indicator.width + control.spacing

        text: control.text
        font: control.font
        color: !control.enabled? Theme.textDisabled : (control.down ? Theme.color50(Theme.text) : Theme.text)
        //elide: Text.ElideRight
        width: parent.width
        wrapMode: Text.WordWrap
        visible: control.text
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 35
        visible: control.down || control.highlighted
        color: control.down ? Theme.delegatePressed : Theme.delegate
    }
}
