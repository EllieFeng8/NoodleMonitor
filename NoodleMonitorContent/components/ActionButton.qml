import QtQuick
import QtQuick.Controls.Basic
import NoodleMonitor
Button {
    id: control
    property color accent: Constants.blue
    property string symbol: ""
    property url imageSource: ""
    property bool prominentFeedback: false
    readonly property bool clickFeedback: feedbackTimer.running
    hoverEnabled: true
    scale: prominentFeedback && enabled && down ? 0.96 : prominentFeedback && enabled && hovered ? 1.025 : 1
    Behavior on scale { NumberAnimation { duration: 100; easing.type: Easing.OutCubic } }
    onClicked: { if (prominentFeedback) feedbackTimer.restart() }
    Timer { id: feedbackTimer; interval: 420 }
    implicitHeight: 36
    implicitWidth: 110
    font.family: Constants.font.family
    font.pixelSize: 14
    font.bold: true
    contentItem: Item {
        implicitWidth: label.implicitWidth + (control.symbol || control.imageSource.toString() ? 28 : 0)
        implicitHeight: label.implicitHeight
        Row {
            anchors.centerIn: parent
            spacing: 8
            Icon { visible: control.symbol !== "" && control.imageSource.toString() === ""; name: control.symbol; anchors.verticalCenter: parent.verticalCenter }
            Image {
                visible: control.imageSource.toString() !== ""
                source: control.imageSource
                width: 20; height: 20
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
            }
            Text { id: label; text: control.text; font: control.font; color: "white"; anchors.verticalCenter: parent.verticalCenter }
        }
    }
    background: Rectangle {
        radius: 9
        color: control.prominentFeedback && control.clickFeedback ? Qt.darker(control.accent, 1.5)
             : !control.enabled ? "#94a3b8"
             : control.down ? Qt.darker(control.accent, control.prominentFeedback ? 1.65 : 1.15)
             : control.hovered ? (control.prominentFeedback ? Qt.darker(control.accent, 1.25) : Qt.lighter(control.accent, 1.08)) : control.accent
        border.color: control.prominentFeedback && (control.clickFeedback || (control.enabled && (control.hovered || control.down))) ? Qt.darker(control.accent, 1.9) : control.activeFocus ? "#17386f" : "transparent"
        border.width: control.prominentFeedback && (control.down || control.clickFeedback) ? 3 : 2
        Behavior on color { ColorAnimation { duration: 90 } }
        Rectangle {
            anchors.fill: parent
            anchors.margins: 4
            radius: 6
            color: "transparent"
            border.color: "#bfffffff"
            border.width: 1
            visible: control.prominentFeedback && (control.clickFeedback || (control.enabled && control.down))
        }
    }
}
