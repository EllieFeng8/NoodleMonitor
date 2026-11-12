import QtQuick
import QtQuick.Layouts
import NoodleMonitor
Rectangle {
    id: root
    property string text: "設備運轉中"
    property color fill: Constants.green
    property bool small: false
    implicitWidth: contents.implicitWidth + (small ? 22 : 30)
    implicitHeight: small ? 25 : 36
    radius: height / 2
    color: fill
    RowLayout {
        id: contents
        anchors.centerIn: parent
        spacing: root.small ? 4 : 8
        Rectangle { implicitWidth: root.small ? 6 : 10; implicitHeight: implicitWidth; radius: width / 2; color: "white" }
        Text { text: root.text; color: "white"; font.family: Constants.font.family; font.pixelSize: root.small ? 12 : 15; font.bold: true }
    }
}
