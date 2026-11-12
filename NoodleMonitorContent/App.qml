import QtQuick
import NoodleMonitor
import "screens"

Window {
    id: window
    width: Constants.width
    height: Constants.height
    minimumWidth: 1280
    minimumHeight: 650
    visibility: Window.FullScreen
    title: qsTr("麵條機擠出監控系統")
    color: "white"
    Shortcut {
        sequence: "F11"
        onActivated: {
            if (window.visibility === Window.FullScreen)
                window.showNormal()
            else
                window.showFullScreen()
        }
    }
    DashboardContainer { anchors.fill: parent }
}
