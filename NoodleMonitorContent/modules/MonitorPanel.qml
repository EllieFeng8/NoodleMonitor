import QtQuick
import QtQuick.Layouts
import NoodleMonitor
import "../components"
ColumnLayout {
    id: root
    signal temperatureConfirmed(string label, string value)
    spacing: 12
    SectionHeader { title: qsTr("麵條擠出即時監控"); symbol: "trend"; accent: Constants.green; badge: "即時資料"; Layout.fillWidth: true; implicitHeight: 44 }
    MonitoringMetrics { Layout.fillWidth: true; onTemperatureConfirmed: (label, value) => root.temperatureConfirmed(label, value) }
    TrendChartPanel { Layout.fillWidth: true; Layout.fillHeight: true }
}
