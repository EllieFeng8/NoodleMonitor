import QtQuick
import Core 1.0
import QtQuick.Layouts
import NoodleMonitor
import "../components"
PanelCard {
    id: root
    signal confirmed(bool rough, bool unstable, bool uneven, string note)
    ColumnLayout {
        anchors.fill: parent; anchors.margins: 11; spacing: 12
        SectionHeader { title: qsTr("麵條性狀"); accent: Constants.orange; Layout.fillWidth: true }
        RowLayout {
            Layout.fillWidth: true; Layout.fillHeight: true; spacing: 8
            PhotoPreview { Layout.preferredWidth: 120; Layout.fillHeight: true }
            ColumnLayout {
                spacing: 6; Layout.fillWidth: true
                QualityCheckItem { id: rough; objectName: "rough"; checked: Nm.rough; onToggled: value => Nm.rough = value; title: "毛邊"; Layout.fillWidth: true; Layout.fillHeight: true }
                QualityCheckItem { id: unstable; objectName: "unstable"; checked: Nm.unstable; onToggled: value => Nm.unstable = value; title: "出料不穩定"; Layout.fillWidth: true; Layout.fillHeight: true }
                QualityCheckItem { id: uneven; objectName: "uneven"; checked: Nm.uneven; onToggled: value => Nm.uneven = value; title: "長度偏短"; Layout.fillWidth: true; Layout.fillHeight: true }
            }
        }
        RowLayout {
            spacing: 8; Layout.fillWidth: true
            Text { text: qsTr("其他備註"); font.family: Constants.font.family; font.pixelSize: 12; font.bold: true; color: Constants.ink }
            ValueInput { id: note; objectName: "noteInput"; text: Nm.note; onTextEdited: Nm.note = text; placeholderText: qsTr("請輸入描述..."); horizontalAlignment: TextInput.AlignLeft; implicitHeight: 32; Layout.fillWidth: true }
        }
        ActionButton { text: qsTr("確定"); accent: Constants.orange; implicitHeight: 29; Layout.fillWidth: true; Layout.leftMargin: 11; Layout.rightMargin: 11; onClicked: root.confirmed(rough.checked, unstable.checked, uneven.checked, note.text) }
    }
}
