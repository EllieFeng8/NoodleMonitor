import QtQuick
import Core 1.0

// 保留相容轉接介面；正式 UI 已直接綁定 Nm，不提供模擬資料。
Item {
    visible: false
    readonly property string date: Nm.date
    readonly property string name: Nm.name
    readonly property string recipe: Nm.recipe
    readonly property string batch: Nm.batch
    readonly property string roomTemp: Nm.roomTemp
    readonly property string flourTemp: Nm.flourTemp
    readonly property string waterTemp: Nm.waterTemp
    readonly property string ice: Nm.ice
    readonly property string mixTemp: Nm.mixTemp
    readonly property string inTemp: Nm.inTemp
    readonly property string barrelTemp: Nm.barrelTemp
    readonly property string outTemp: Nm.outTemp
    readonly property bool rough: Nm.rough
    readonly property bool unstable: Nm.unstable
    readonly property bool uneven: Nm.uneven
    readonly property string note: Nm.note
    readonly property string entry: Nm.entry
    readonly property bool running: Nm.running
    readonly property real current: Nm.current
    readonly property real torque: Nm.torque
    readonly property var currentSamples: Nm.currentSamples
    readonly property var torqueSamples: Nm.torqueSamples
    readonly property var timeLabels: Nm.timeLabels
    readonly property string dateTime: Nm.dateTime
    readonly property var logs: Nm.logs
    function start() { Nm.start() }
    function stop() { Nm.stop() }
    function reset() { Nm.reset() }
    function addLog(message) { Nm.addLog(message) }
}
