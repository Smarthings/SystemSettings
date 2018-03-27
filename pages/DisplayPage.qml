import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Screen 1.0

import "../UiTheme/"

ScrollablePage {
    width: stackview.width
    height: stackview.height
    color: Theme.background
    padding: 10

    property var headerPage: HeaderDefault {}
    property string titlePage: qsTr("Tela")

    Column {
        anchors.fill: parent
        spacing: 20

        GroupBox {
            width: parent.width
            radius: 5
            padding: 10
            title: qsTr("Brilho da Tela")

            Slider {
                id: sliderBrightness
                width: parent.width
                height: 40
                to: 255
                from: 10
                value: screen.brightness
                onValueChanged: screen.setBrightness(Math.round(value))
            }
        }

        GroupBox {
            width: parent.width
            radius: 5
            padding: 10
            title: qsTr("Rotação da Tela")

            Column {
                width: parent.width

                SwitchDelegate {
                    width: parent.width
                    text: qsTr("Inverter Tela")
                }
                Text {
                    width: parent.width
                    horizontalAlignment: Qt.AlignRight
                    text: qsTr("*exige reiniciar o sistema")
                    font.pixelSize: Theme.pixelSize * 0.8
                    color: Theme.color70(Theme.text)
                }
            }
        }

        Screen {
            id: screen
            onBrightnessChanged: console.log(brightness);
        }
    }
}
