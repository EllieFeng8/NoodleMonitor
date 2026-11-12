import QtQuick
Canvas {
    id: root
    property string name: "panel"
    property color tint: "white"
    implicitWidth: 20
    implicitHeight: 20
    onNameChanged: requestPaint()
    onTintChanged: requestPaint()
    onPaint: {
        const c = getContext("2d")
        c.reset(); c.strokeStyle = tint; c.fillStyle = tint; c.lineWidth = 2
        const s = Math.min(width,height)/20
        c.scale(s,s)
        c.beginPath()
        if (name === "play") { c.moveTo(5,3); c.lineTo(17,10); c.lineTo(5,17); c.closePath(); c.fill() }
        else if (name === "stop") { c.fillRect(5,5,10,10) }
        else if (name === "trend") { c.moveTo(1,14); c.lineTo(7,8); c.lineTo(12,11); c.lineTo(19,3); c.stroke() }
        else if (name === "reset") { c.arc(10,10,7,-0.7,4.6); c.stroke(); c.beginPath(); c.moveTo(3,2); c.lineTo(3,8); c.lineTo(9,8); c.stroke(); c.beginPath(); c.moveTo(17,18); c.lineTo(17,12); c.lineTo(11,12); c.stroke() }
        else { c.strokeRect(4,4,12,12) }
    }
}
