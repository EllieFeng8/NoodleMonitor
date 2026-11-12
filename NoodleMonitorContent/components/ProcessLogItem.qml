import QtQuick
import QtQuick.Layouts
import NoodleMonitor
RowLayout {
    id: root
    property string timeText: ""
    property string message: ""
    spacing: 15
    Text { text: root.timeText; font.family: Constants.font.family; color: "#8ba0bd"; font.pixelSize: 12; font.bold: true; Layout.preferredWidth: 34 }
    Text { text: root.message; color: Constants.ink; font.family: Constants.font.family; font.pixelSize: 12; font.bold: true; Layout.fillWidth: true; elide: Text.ElideRight }
}
