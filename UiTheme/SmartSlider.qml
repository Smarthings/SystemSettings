import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "./"

Item {
    id: item

    property int position: 0
    property alias _slider: slider
    property int borderRadius: 10
    property int sliderOrientation: Qt.Horizontal
    property int itemWidth: 0
    property int sliderWidth: (sliderOrientation == Qt.Horizontal)? 90 : 60
    property int itemHeight: 0
    property int sliderHeight: (sliderOrientation == Qt.Horizontal)? 60 : 90
    property color color: Theme.accent

    width: (itemWidth > 0)? itemWidth : sliderWidth
    height: (itemHeight > 0)? itemHeight : sliderHeight

    Slider {
        id: slider
        width: sliderWidth
        height: sliderHeight
        anchors.centerIn: parent

        snapMode: Slider.NoSnap
        orientation: item.sliderOrientation

        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.color: item.color
            radius: item.borderRadius

            Rectangle {
                id: rectangle_background
                height: (sliderOrientation == Qt.Horizontal)? parent.height : parent.height * parent.parent.position
                width: (sliderOrientation == Qt.Horizontal)? parent.width * parent.parent.position : parent.width
                color: Qt.rgba(item.color.r, item.color.g, item.color.b, slider.position)
                radius: item.borderRadius

                Component.onCompleted: if (item.sliderOrientation != Qt.Horizontal) anchors.bottom = parent.bottom
            }
        }
    }
}
