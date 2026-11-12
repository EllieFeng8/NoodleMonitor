import QtQuick
import QtQuick.Layouts
import NoodleMonitor
import "../components"
RowLayout {
    id: root
    property bool running: true
    signal startRequested()
    signal stopRequested()
    signal resetRequested()
    spacing: 12
    ActionButton { prominentFeedback: true; text: qsTr("開始生產"); symbol: "play"; accent: Constants.green; font.pixelSize: 19; implicitHeight: 49; Layout.fillWidth: true; onClicked: root.startRequested() }
    ActionButton { prominentFeedback: true; text: qsTr("停止"); symbol: "stop"; accent: "#94a3b8"; enabled: root.running; font.pixelSize: 19; implicitHeight: 49; Layout.fillWidth: true; onClicked: root.stopRequested() }
    ActionButton { prominentFeedback: true; text: qsTr("重置"); imageSource: "../assets/icons/reset.png"; accent: "#3b7ff5"; font.pixelSize: 19; implicitHeight: 49; Layout.fillWidth: true; onClicked: root.resetRequested() }
}
