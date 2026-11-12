import QtQuick
import QtQuick.Layouts
import NoodleMonitor
import "../components"
Item {
    id: root
    property bool running: true
    property string dateTime: ""
    implicitHeight: 64
    RowLayout {
        anchors.fill: parent
        anchors.bottomMargin: 13
        spacing: 14
        Rectangle {
            implicitWidth: 48; implicitHeight: 48; radius: 8; color: "#fff8eb"; border.color: "#f6d183"
            Image { anchors.fill: parent; anchors.margins: 4; source: "../assets/icons/noodles.svg"; fillMode: Image.PreserveAspectFit }
        }
        Text { text: qsTr("麵條機擠出監控系統"); color: Constants.ink; font.family: Constants.font.family; font.pixelSize: 30; font.bold: true; Layout.fillWidth: true }
        Text { text: root.dateTime; color: "#334155"; font.family: Constants.font.family; font.pixelSize: 25; font.bold: true; font.letterSpacing: 1 }
        StatusBadge { text: root.running ? qsTr("設備運轉中") : qsTr("設備已停止"); fill: root.running ? Constants.green : "#94a3b8" }
    }
    Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#dce5f0" }
}
