import QtQuick
import Core 1.0
import QtQuick.Controls
import QtQuick.Layouts
import NoodleMonitor
import "../components"
PanelCard {
    id: root
    signal addRequested(string message)
    color: "white"
    ColumnLayout {
        anchors.fill: parent; anchors.margins: 13; spacing: 12
        Text { text: qsTr("□  製程紀錄"); color: Constants.ink; font.family: Constants.font.family; font.pixelSize: 16; font.bold: true; Layout.preferredHeight: 20 }
        Rectangle { Layout.fillWidth: true; implicitHeight: 1; color: "#edf2f8" }
        RowLayout {
            spacing: 6; Layout.fillWidth: true
            ValueInput { id: entry; objectName: "entryInput"; text: Nm.entry; onTextEdited: Nm.entry = text; placeholderText: qsTr("輸入新事件紀錄..."); horizontalAlignment: TextInput.AlignLeft; implicitHeight: 32; Layout.fillWidth: true; onAccepted: add.click() }
            ActionButton { id: add; text: qsTr("新增"); implicitWidth: 44; implicitHeight: 29; font.pixelSize: 12; onClicked: { if (entry.text.trim().length > 0) { root.addRequested(entry.text.trim()); Nm.entry = "" } } }
        }
        Rectangle { Layout.fillWidth: true; implicitHeight: 1; color: "#edf2f8" }
        ListView {
            Layout.fillWidth: true; Layout.fillHeight: true
            clip: true; spacing: 5; model: Nm.logs
            ScrollBar.vertical: ScrollBar { }
            delegate: ProcessLogItem {
                required property var modelData
                width: ListView.view.width
                timeText: modelData.time; message: modelData.messageText
            }
        }
    }
}
