import QtQuick
import QtQuick.Layouts
import NoodleMonitor
Rectangle {
    id: root
    property string title: ""
    property string symbol: "panel"
    property color accent: Constants.blue
    property string badge: ""
    implicitHeight: 42
    radius: 9
    color: accent
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        spacing: 10
        Icon { name: root.symbol }
        Text { text: root.title; color: "white"; font.family: Constants.font.family; font.pixelSize: 20; font.bold: true; Layout.fillWidth: true }
        StatusBadge { visible: root.badge !== ""; text: root.badge; fill: Qt.darker(root.accent, 1.18); small: true }
    }
}
