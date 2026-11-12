import QtQuick
import Core 1.0
import QtQuick.Layouts
import NoodleMonitor
import "../components"
PanelCard {
    id: root
    signal confirmed()
    ColumnLayout {
        anchors.fill: parent; anchors.margins: 11; spacing: 10
        SectionHeader { title: qsTr("麵條攪拌"); Layout.fillWidth: true }
        ColumnLayout {
            Layout.fillWidth: true; spacing: 7
            FormFieldRow { label: "日　期"; objectName: "date"; text: Nm.date; onEdited: value => Nm.date = value; Layout.fillWidth: true }
            FormFieldRow { label: "品　名"; objectName: "name"; text: Nm.name; onEdited: value => Nm.name = value; Layout.fillWidth: true }
            FormFieldRow { label: "配　方"; objectName: "recipe"; text: Nm.recipe; onEdited: value => Nm.recipe = value; Layout.fillWidth: true }
            FormFieldRow { label: "批　次"; objectName: "batch"; text: Nm.batch; onEdited: value => Nm.batch = value; Layout.fillWidth: true }
            FormFieldRow { label: "室　溫"; objectName: "roomTemp"; text: Nm.roomTemp; onEdited: value => Nm.roomTemp = value; unit: "°C"; Layout.fillWidth: true }
            FormFieldRow { label: "粉　溫"; objectName: "flourTemp"; text: Nm.flourTemp; onEdited: value => Nm.flourTemp = value; unit: "°C"; Layout.fillWidth: true }
            FormFieldRow { label: "水　溫"; objectName: "waterTemp"; text: Nm.waterTemp; onEdited: value => Nm.waterTemp = value; unit: "°C"; Layout.fillWidth: true }
            FormFieldRow { label: "冰塊重"; objectName: "ice"; text: Nm.ice; onEdited: value => Nm.ice = value; unit: "kg"; Layout.fillWidth: true }
        }
        ColumnLayout {
            Layout.fillWidth: true; Layout.topMargin: 23; Layout.leftMargin: 10; Layout.rightMargin: 10; spacing: 3
            Text { text: qsTr("麵糰混合後溫度"); font.family: Constants.font.family; font.pixelSize: 12; font.bold: true; color: Constants.ink }
            ValueInput { objectName: "mixTempInput"; text: Nm.mixTemp; onTextEdited: Nm.mixTemp = text; unit: "°C"; emphasized: true; Layout.fillWidth: true }
        }
        Item { Layout.fillHeight: true }
        ActionButton { text: qsTr("確定"); prominentFeedback: true; Layout.fillWidth: true; Layout.topMargin: 12; onClicked: root.confirmed() }
    }
}
