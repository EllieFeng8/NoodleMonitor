import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import NoodleMonitor
Rectangle {
    id: root
    property string title: ""
    property alias checked: check.checked
    signal toggled(bool value)
    implicitHeight: 46
    color: "white"
    radius: 6
    border.color: "#dce5f0"
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 0
        Text { text: root.title; color: Constants.ink; font.family: Constants.font.family; font.pixelSize: 12; font.bold: true; Layout.alignment: Qt.AlignHCenter }
        CheckBox {
            id: check
            objectName: root.objectName + "Input"
            onToggled: root.toggled(checked)
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("有")
            padding: 0
            spacing: 4
            font.family: Constants.font.family
            font.pixelSize: 12
            indicator: Rectangle { implicitWidth: 14; implicitHeight: 14; x: 0; y: (check.height-height)/2; radius: 3; color: check.checked ? Constants.blue : "white"; border.color: "#c9d6e8"; Text { anchors.centerIn: parent; text: check.checked ? "✓" : ""; color: "white"; font.pixelSize: 11 } }
            contentItem: Text { text: check.text; leftPadding: 18; color: "#475569"; font: check.font; verticalAlignment: Text.AlignVCenter }
        }
    }
}
