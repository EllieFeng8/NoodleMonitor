import QtQuick
import Core 1.0
import QtQuick.Layouts
import NoodleMonitor
import "../components"
PanelCard {
    id: root
    color: "white"
    ColumnLayout {
        anchors.fill: parent; anchors.margins: 13; spacing: 10
        RowLayout {
            Text { text: qsTr("監控趨勢圖"); color: "#475569"; font.family: Constants.font.family; font.pixelSize: 12; font.bold: true; Layout.fillWidth: true }
            Repeater {
                model: [{name: "電流值 (A)", tint: "#f59e0b"}, {name: "扭矩值 (%)", tint: "#2860ff"}]
                RowLayout {
                    id: legend
                    required property var modelData
                    spacing: 5
                    Rectangle { implicitWidth: 10; implicitHeight: 10; radius: 5; color: legend.modelData.tint }
                    Text { text: legend.modelData.name; color: "#64748b"; font.family: Constants.font.family; font.pixelSize: 11 }
                }
            }
        }
        Rectangle { Layout.fillWidth: true; implicitHeight: 1; color: "#edf2f8" }
        ColumnLayout {
            Layout.fillWidth: true; Layout.fillHeight: true; spacing: 0
            TrendPlot { objectName: "currentPlot"; samples: Nm.currentSamples; maximum: 30; tickStep: 10; axisTitle: "電流值\n(A)"; lineColor: "#ff9800"; Layout.fillWidth: true; Layout.fillHeight: true }
            TrendPlot { objectName: "torquePlot"; samples: Nm.torqueSamples; maximum: 100; tickStep: 25; axisTitle: "扭矩值\n(%)"; showTimeLabels: true; Layout.fillWidth: true; Layout.fillHeight: true; timeLabels: Nm.timeLabels }
        }
    }
}
