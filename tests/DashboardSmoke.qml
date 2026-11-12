import QtQuick
import Core 1.0
import "../NoodleMonitorContent/screens"
import "../NoodleMonitorContent/models"

Window {
    id: window
    width: 1370
    height: 718
    visible: true
    color: "white"
    FontLoader { source: "file:///C:/Windows/Fonts/msjh.ttc" }
    FontLoader { source: "file:///C:/Windows/Fonts/msjhbd.ttc" }
    Rectangle { anchors.fill: parent; color: "white" }
    DashboardContainer { id: dashboard; anchors.fill: parent }
    DashboardState { id: state }
    property real stoppedCurrent: 0
    Timer {
        id: updates
        interval: 2400
        onTriggered: {
            if (state.currentSamples.length === 0 || state.torqueSamples.length === 0) { console.error("FAIL: proxy samples"); Qt.exit(1); return }
            state.stop()
            window.stoppedCurrent = state.current
            frozen.start()
        }
    }
    Timer {
        id: frozen
        interval: 2300
        onTriggered: {
            if (state.current !== window.stoppedCurrent) { console.error("FAIL: stop must freeze samples"); Qt.exit(1); return }
            console.log("PASS: proxy data remains available after stop")
            Qt.quit()
        }
    }
    Timer {
        interval: 500
        running: true
        onTriggered: {
            function check(condition, message) {
                if (!condition) { console.error("FAIL: " + message); Qt.exit(1) }
            }
            state.stop()
            check(!state.running, "stop")
            state.reset()
            check(state.current === 0 && state.torque === 0 && state.currentSamples.length === 0, "reset")
            // 測試資料由 Nm setter 提供，proxy 不自行產生模擬數值。
            Nm.current = 18.4
            Nm.torque = 300
            Nm.currentSamples = [17.0, 18.4]
            Nm.torqueSamples = [45.0, 50.0]
            state.start()
            check(state.running, "start")
            const count = state.logs.length
            state.addLog("測試紀錄")
            check(state.logs.length === count+1 && state.logs[0].messageText === "測試紀錄", "log insertion")
            window.contentItem.grabToImage(function(result) {
                check(result.saveToFile("dashboard-preview.png"), "save preview")
                console.log("PASS: dashboard loaded; start, stop, reset and event log checked")
                updates.start()
            })
        }
    }
}
