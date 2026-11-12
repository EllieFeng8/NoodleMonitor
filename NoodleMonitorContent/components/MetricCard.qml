import QtQuick
import QtQuick.Layouts
import NoodleMonitor
Rectangle {
    id: root
    property string label: ""
    property string unit: ""
    property string value: ""
    property color accent: Constants.blue
    property color tint: "#f5f9ff"
    property bool editable: false
    signal confirmed(string value)
    signal edited(string value)
    implicitHeight: 70
    radius: 12
    color: tint
    border.color: Qt.lighter(accent, 1.7)
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 9
        spacing: 5
        RowLayout {
            Text { text: root.label; color: Constants.ink; font.family: Constants.font.family; font.pixelSize: 12; font.bold: true; Layout.fillWidth: true }
            Text { text: root.unit; color: "#64748b"; font.pixelSize: 13; font.bold: true }
        }
        RowLayout {
            spacing: 5
            ValueInput { id: input; objectName: root.objectName + "Input"; text: root.value; readOnly: !root.editable; onTextEdited: root.edited(text); validator: DoubleValidator { bottom: -50; top: 200; decimals: 1; notation: DoubleValidator.StandardNotation } emphasized: true; Layout.fillWidth: true; Layout.minimumWidth: 30 }
            ActionButton { visible: root.editable; enabled: input.acceptableInput; text: qsTr("確定"); accent: root.accent; implicitWidth: 40; implicitHeight: 29; font.pixelSize: 11; onClicked: root.confirmed(input.text) }
        }
    }
}

