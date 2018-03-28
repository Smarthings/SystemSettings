import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Screen 1.0

import "../UiTheme/"

ScrollablePage {
    width: stackview.width
    height: stackview.height
    color: Theme.background

    paddingPane: 10
    sidebar: sideBar

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

            SwitchDelegate {
                width: parent.width
                text: qsTr("Inverter Tela")
                checked: screen.rotation
                onClicked: {
                    if (screen.setRotation(checked))
                        rotationSuccess.open()
                    else
                        ToolTip.show(qsTr("Não foi possível mudar a rotação da tela"), 5000)
                }
            }
        }

        Dialog {
            id: rotationSuccess
            width: 300
            modal: true
            blur: true

            Column {
                anchors.fill: parent
                spacing: 20

                Text {
                    width: parent.width
                    wrapMode: Text.WordWrap
                    text: qsTr("Para que essa configuração seja aplicada, é necessário reiniciar o sistema.")
                    font.pixelSize: Theme.pixelSize * 1.1
                    horizontalAlignment: Qt.AlignHCenter
                    color: Theme.alert
                }

                Text {
                    width: parent.width
                    wrapMode: Text.WordWrap
                    text: qsTr("Deseja reiniciar agora?")
                    horizontalAlignment: Qt.AlignHCenter
                }
            }

            standardButtons: Dialog.Yes | Dialog.No
            onAccepted: system.restartSystem()
        }

        Screen {
            id: screen
        }
    }
}
