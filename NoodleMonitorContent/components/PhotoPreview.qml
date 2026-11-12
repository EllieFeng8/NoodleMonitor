import QtQuick
import NoodleMonitor
Rectangle {
    property alias source: photo.source
    color: "#fff6d9"
    border.color: "#ffdb68"
    radius: 8
    clip: true
    Image { id: photo; anchors.fill: parent; anchors.margins: 3; fillMode: Image.PreserveAspectFit }
    Text { anchors.centerIn: parent; visible: photo.status !== Image.Ready; text: qsTr("麵條\n照片"); lineHeight: 1.4; horizontalAlignment: Text.AlignHCenter; font.family: Constants.font.family; font.pixelSize: 15; font.bold: true; color: "#475569" }
}
