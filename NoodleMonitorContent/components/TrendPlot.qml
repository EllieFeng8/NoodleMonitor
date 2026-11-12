import QtQuick
import NoodleMonitor
Item {
    id: root
    property var samples: []
    property color lineColor: Constants.blue
    property real maximum: 100
    property real tickStep: 25
    property string axisTitle: ""
    property bool showTimeLabels: false
    property var timeLabels: ["14:00", "14:05", "14:10", "14:15", "14:20", "14:25"]
    onSamplesChanged: plot.requestPaint()
    onTimeLabelsChanged: plot.requestPaint()
    onMaximumChanged: plot.requestPaint()
    Canvas {
        id: plot
        anchors.fill: parent
        onPaint: {
            const ctx = getContext("2d")
            ctx.reset()
            const left = 47, right = width - 88, top = 10, bottom = height - 25
            const w = right-left, h = bottom-top
            if (w <= 0 || h <= 0) return
            ctx.fillStyle = "#fbfcfe"
            ctx.fillRect(left, top, w, h)
            ctx.font = "9px 'Microsoft JhengHei'"
            for (let v = 0; v <= root.maximum; v += root.tickStep) {
                const y = bottom - v/root.maximum*h
                ctx.strokeStyle = "#dbe4f0"; ctx.lineWidth = 1
                ctx.setLineDash([2, 2]); ctx.beginPath(); ctx.moveTo(left, y); ctx.lineTo(right, y); ctx.stroke()
                ctx.fillStyle = root.lineColor; ctx.textAlign = "right"
                ctx.fillText(v.toString(), left-3, y+3)
            }
            for (let i = 0; i < 6; i++) {
                const x = left+i*w/5.5
                ctx.strokeStyle = "#e0e7f1"; ctx.setLineDash([])
                ctx.beginPath(); ctx.moveTo(x, top); ctx.lineTo(x, bottom); ctx.stroke()
                if (root.showTimeLabels) {
                    ctx.fillStyle = "#64748b"; ctx.textAlign = "center"
                    ctx.fillText(root.timeLabels[i] || "", x, bottom+19)
                }
            }
            ctx.strokeStyle = "#bfcddd"; ctx.setLineDash([])
            ctx.beginPath(); ctx.moveTo(left, top); ctx.lineTo(left, bottom); ctx.lineTo(right, bottom); ctx.stroke()
            ctx.fillStyle = root.lineColor; ctx.textAlign = "left"; ctx.font = "bold 10px 'Microsoft JhengHei'"
            const lines = root.axisTitle.split("\n")
            for (let j = 0; j < lines.length; j++) ctx.fillText(lines[j], 0, top+3+j*12)
            if (root.showTimeLabels) { ctx.fillStyle = "#475569"; ctx.fillText("時間", right+12, bottom+19) }
            if (root.samples.length < 2) return
            ctx.strokeStyle = root.lineColor; ctx.lineWidth = 1.8
            ctx.beginPath()
            for (let k = 0; k < root.samples.length; k++) {
                const px = left+k*w/(root.samples.length-1)
                const py = bottom-Math.max(0, Math.min(root.maximum, root.samples[k]))/root.maximum*h
                if (k === 0) ctx.moveTo(px, py); else ctx.lineTo(px, py)
            }
            ctx.stroke()
            ctx.fillStyle = root.lineColor
            for (let k = 0; k < root.samples.length; k += 2) {
                ctx.beginPath(); ctx.arc(left+k*w/(root.samples.length-1), bottom-root.samples[k]/root.maximum*h, 1.6, 0, Math.PI*2); ctx.fill()
            }
        }
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
    }
}
