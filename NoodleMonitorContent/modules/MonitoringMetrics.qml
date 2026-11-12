import QtQuick
import Core 1.0
import QtQuick.Layouts
import "../components"
RowLayout {
    id: root
    // QML 直接存取 Q_PROPERTY；current 對應 getCurrent() / currentChanged()。
    // 可編輯欄位賦值時，Qt 會呼叫對應的 setXxx()。
    signal temperatureConfirmed(string label, string value)
    spacing: 8
    MetricCard { label: "電流值"; unit: "A"; objectName: "current"; value: Nm.current.toFixed(1); accent: "#f59e0b"; tint: "#fffcf4"; Layout.fillWidth: true; Layout.preferredWidth: 1 }
    MetricCard { label: "扭矩值"; unit: "N·m"; objectName: "torque"; value: Nm.torque.toFixed(0); accent: "#38bdf8"; tint: "#f4fbff"; Layout.fillWidth: true; Layout.preferredWidth: 1 }
    MetricCard { label: "入料麵糰溫度"; unit: "°C"; objectName: "inTemp"; value: Nm.inTemp; editable: true; onEdited: value => Nm.inTemp = value; accent: "#0eace2"; Layout.fillWidth: true; Layout.preferredWidth: 1; onConfirmed: value => { root.temperatureConfirmed(label, value) } }
    MetricCard { label: "套筒溫度"; unit: "°C"; objectName: "barrelTemp"; value: Nm.barrelTemp; editable: true; onEdited: value => Nm.barrelTemp = value; accent: "#ff7412"; tint: "#fffaf5"; Layout.fillWidth: true; Layout.preferredWidth: 1; onConfirmed: value => { root.temperatureConfirmed(label, value) } }
    MetricCard { label: "出料麵條溫度"; unit: "°C"; objectName: "outTemp"; value: Nm.outTemp; editable: true; onEdited: value => Nm.outTemp = value; accent: "#fa3b68"; tint: "#fff7f9"; Layout.fillWidth: true; Layout.preferredWidth: 1; onConfirmed: value => { root.temperatureConfirmed(label, value) } }
}
