import QtQuick
import QtQuick.Controls.Basic
import NoodleMonitor
TextField {
    id: control
    property bool emphasized: false
    property string unit: ""
    implicitHeight: emphasized ? 31 : 27
    implicitWidth: 110
    color: Constants.ink
    font.family: Constants.font.family
    font.pixelSize: emphasized ? 15 : 13
    font.bold: emphasized
    horizontalAlignment: TextInput.AlignHCenter
    verticalAlignment: TextInput.AlignVCenter
    selectByMouse: true
    leftPadding: 7
    rightPadding: unitLabel.visible ? unitLabel.implicitWidth + 15 : 7
    Text {
        id: unitLabel
        anchors.right: parent.right
        anchors.rightMargin: 7
        anchors.verticalCenter: parent.verticalCenter
        text: control.unit
        visible: text.length > 0
        font: control.font
        color: control.color
    }
    background: Rectangle { color: control.readOnly ? "#f8fafc" : "white"; border.color: control.activeFocus ? Constants.blue : "#c9d6e8"; radius: 4 }
}
