pragma Singleton
import QtQuick

QtObject {
    readonly property int width: 1370
    readonly property int height: 718
    readonly property font font: Qt.font({ family: "Microsoft JhengHei", pixelSize: 14 })
    readonly property font largeFont: Qt.font({ family: "Microsoft JhengHei", pixelSize: 22 })
    readonly property color backgroundColor: "#ffffff"
    readonly property color ink: "#1e293b"
    readonly property color blue: "#2860f2"
    readonly property color green: "#059b70"
    readonly property color orange: "#f5a000"
    readonly property int spacing: 12
    readonly property int cornerRadius: 12
}
