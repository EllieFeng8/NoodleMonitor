import QtQuick
import QtQuick.Layouts
import NoodleMonitor
RowLayout {
    id: root
    property string label: ""
    property alias text: input.text
    property alias unit: input.unit
    property alias readOnly: input.readOnly
    signal edited(string value)
    spacing: 8
    Text { text: root.label; font.family: Constants.font.family; font.pixelSize: 14; font.bold: true; color: "#475569"; Layout.preferredWidth: 64 }
    ValueInput { id: input; objectName: root.objectName + "Input"; Layout.fillWidth: true; onTextEdited: root.edited(text) }
}
