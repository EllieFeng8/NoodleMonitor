import QtQuick
import Core 1.0
import QtQuick.Layouts
import "../modules"
Item {
    id: root
    // Core 模組的 Nm singleton 對應 NoodleMonitorProxy。
    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 22; anchors.rightMargin: 22
        anchors.topMargin: 16; anchors.bottomMargin: 74
        spacing: 12
        DashboardHeader { running: Nm.running; dateTime: Nm.dateTime; Layout.fillWidth: true }
        RowLayout {
            Layout.fillWidth: true; Layout.fillHeight: true; spacing: 14
            MixingPanel { Layout.preferredWidth: 210; Layout.fillHeight: true; onConfirmed: Nm.addLog("攪拌資料已確認") }
            ColumnLayout {
                Layout.fillWidth: true; Layout.fillHeight: true; spacing: 16
                MonitorPanel {
                    Layout.fillWidth: true; Layout.fillHeight: true
                    onTemperatureConfirmed: (label, value) => Nm.addLog(label + "已確認：" + value + " °C")
                }
                ProductionControls {
                    running: Nm.running
                    Layout.fillWidth: true
                    onStartRequested: Nm.start()
                    onStopRequested: Nm.stop()
                    onResetRequested: Nm.reset()
                }
            }
            ColumnLayout {
                Layout.preferredWidth: 322; Layout.minimumWidth: 322; Layout.maximumWidth: 322; Layout.fillHeight: true; spacing: 12
                NoodleStatusPanel {
                    Layout.fillWidth: true; Layout.preferredHeight: 310
                    onConfirmed: (rough, unstable, uneven, note) => {
                        let defects = []
                        if (rough) defects.push("毛邊")
                        if (unstable) defects.push("出料不穩定")
                        if (uneven) defects.push("長度偏短")
                        Nm.addLog("性狀確認：" + (defects.length ? defects.join("、") : "正常") + (note.trim() ? "；" + note.trim() : ""))
                    }
                }
                ProcessLogPanel { Layout.fillWidth: true; Layout.fillHeight: true; onAddRequested: message => Nm.addLog(message) }
            }
        }
    }
}
