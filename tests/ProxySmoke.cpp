#include "../Core/NoodleMonitorProxy.h"

#include <QApplication>
#include <QMetaProperty>
#include <QQmlApplicationEngine>
#include <QQmlExpression>
#include <QQuickItem>
#include <QQuickWindow>
#include <QSignalSpy>
#include <QTest>
#include <QtQml/qqml.h>
#include <cstdio>
#include <limits>

// 與 App/main.cpp 相同的 Nm singleton 註冊，再載入正式 UI 做整合測試。
int main(int argc, char **argv)
{
    qInstallMessageHandler([](QtMsgType, const QMessageLogContext &, const QString &text) {
        std::fprintf(stderr, "%s\n", text.toUtf8().constData());
        std::fflush(stderr);
    });
    QApplication app(argc, argv);
    NoodleMonitorProxy proxy;
    qmlRegisterSingletonInstance<NoodleMonitorProxy>("Core", 1, 0, "Nm", &proxy);
    QQmlApplicationEngine engine;
    engine.addImportPath(QStringLiteral(NOODLE_SOURCE_DIR));
    bool warning = false;
    QObject::connect(&engine, &QQmlEngine::warnings, &app, [&](const auto &errors) {
        warning = true;
        for (const auto &error : errors) qWarning() << error;
    });
    engine.load(QUrl::fromLocalFile(QStringLiteral(NOODLE_SOURCE_DIR "/NoodleMonitorContent/App.qml")));
    if (engine.rootObjects().isEmpty()) return 1;
    auto *window = qobject_cast<QQuickWindow *>(engine.rootObjects().first());
    if (!window) return 1;
    QTest::qWait(100);
    auto check = [](bool ok, const char *message) {
        if (!ok) qCritical() << "FAIL:" << message;
        return ok;
    };
    auto typeValue = [&](QQuickItem *input) {
        input->forceActiveFocus();
        QTest::keyClick(window, Qt::Key_A, Qt::ControlModifier);
        for (auto key : {Qt::Key_4, Qt::Key_2, Qt::Key_Period, Qt::Key_5})
            QTest::keyClick(window, key);
    };
    const QStringList fields = {
        "date", "name", "recipe", "batch", "roomTemp", "flourTemp", "waterTemp",
        "ice", "mixTemp", "inTemp", "barrelTemp", "outTemp", "note", "entry"
    };
    for (const auto &field : fields) {
        const auto key = field.toUtf8();
        auto *input = window->findChild<QQuickItem *>(field + "Input");
        if (!check(input != nullptr, key.constData())) return 1;
        const auto property = proxy.metaObject()->property(proxy.metaObject()->indexOfProperty(key));
        QSignalSpy changed(&proxy, property.notifySignal());
        proxy.setProperty(key, "11.0");
        proxy.setProperty(key, "11.0");
        if (!check(changed.count() == 1, "notify once when value changes")) return 1;
        if (!check(input->property("text").toString() == "11.0", "Nm to input")) return 1;
        typeValue(input);
        if (!check(proxy.property(key).toString() == "42.5", key.constData())) return 1;
        proxy.setProperty(key, "77.0");
        if (!check(input->property("text").toString() == "77.0", "binding survives editing")) return 1;
    }
    for (const auto &field : {"rough", "unstable", "uneven"}) {
        auto *input = window->findChild<QQuickItem *>(QString(field) + "Input");
        if (!check(input != nullptr, field)) return 1;
        input->forceActiveFocus();
        QTest::keyClick(window, Qt::Key_Space);
        if (!check(proxy.property(field).toBool(), "checkbox writes Nm")) return 1;
        proxy.setProperty(field, false);
        if (!check(!input->property("checked").toBool(), "Nm updates checkbox")) return 1;
    }
    QSignalSpy currentChanged(&proxy, &NoodleMonitorProxy::currentChanged);
    QSignalSpy torqueChanged(&proxy, &NoodleMonitorProxy::torqueChanged);
    proxy.setCurrent(12.3);
    proxy.setTorque(345);
    proxy.setCurrent(12.3);
    proxy.setTorque(345);
    proxy.setCurrent(std::numeric_limits<double>::quiet_NaN());
    proxy.setTorque(std::numeric_limits<double>::infinity());
    if (!check(currentChanged.count() == 1 && torqueChanged.count() == 1,
               "numeric notifications and invalid values")) return 1;
    auto *current = window->findChild<QObject *>("currentInput");
    auto *torque = window->findChild<QObject *>("torqueInput");
    if (!check(current && torque && current->property("text").toString() == "12.3"
               && torque->property("text").toString() == "345", "live metrics update")) return 1;
    proxy.setCurrentSamples({1.0, 2.0, 3.0});
    proxy.setTorqueSamples({10.0, 20.0, 30.0});
    proxy.setTimeLabels({"01:00", "01:01", "01:02", "01:03", "01:04", "01:05"});
    auto *amps = window->findChild<QObject *>("currentPlot");
    auto *load = window->findChild<QObject *>("torquePlot");
    if (!check(amps && load, "trend plots exist")) return 1;
    QQmlExpression ampsCheck(qmlContext(amps), amps, "samples.length === 3 && samples[2] === 3");
    QQmlExpression loadCheck(qmlContext(load), load, "samples[2] === 30 && timeLabels[5] === '01:05'");
    if (!check(ampsCheck.evaluate().toBool() && loadCheck.evaluate().toBool(),
               "Nm updates both charts and time labels")) return 1;

    // 使用正式畫面的按鈕及鍵盤操作，不直接呼叫被測的操作函式。
    auto click = [&](const QString &text) {
        for (auto *item : window->findChildren<QQuickItem *>()) {
            if (item->property("text").toString() == text
                && item->metaObject()->indexOfSignal("clicked()") >= 0) {
                const auto pos = item->mapToScene(QPointF(item->width()/2, item->height()/2));
                QTest::mouseClick(window, Qt::LeftButton, Qt::NoModifier, pos.toPoint());
                return true;
            }
        }
        return false;
    };
    if (!check(click(QStringLiteral("開始生產")) && proxy.getRunning(), "start button")) return 1;
    if (!check(click(QStringLiteral("停止")) && !proxy.getRunning(), "stop button")) return 1;
    if (!check(click(QStringLiteral("重置")) && !proxy.getRunning()
               && proxy.getCurrent() == 0 && proxy.getTorque() == 0
               && proxy.getCurrentSamples().isEmpty() && proxy.getTorqueSamples().isEmpty()
               && proxy.getBatch() == "77.0", "reset clears monitoring and preserves input")) return 1;
    auto *entry = window->findChild<QQuickItem *>("entryInput");
    if (!check(entry != nullptr, "event entry")) return 1;
    typeValue(entry);
    QTest::keyClick(window, Qt::Key_Return);
    if (!check(proxy.getEntry().isEmpty() && entry->property("text").toString().isEmpty()
               && proxy.getLogs().first().toMap()["messageText"] == "42.5",
               "event submission and input clear")) return 1;
    for (int i = 0; i < 105; ++i) proxy.addLog(QString::number(i));
    const auto count = proxy.getLogs().size();
    proxy.addLog("   ");
    if (!check(count == 100 && proxy.getLogs().size() == count
               && proxy.getLogs().first().toMap()["messageText"] == "104",
               "bounded newest-first logs and empty input")) return 1;
    QTest::qWait(100); // 完成畫面重繪，檢查 Canvas / delegate 的執行期錯誤。
    if (!check(!warning, "no QML runtime warnings")) return 1;
    qInfo() << "PASS: Nm registration; 14 inputs; 3 checkboxes; metrics; charts; production controls; logs";
    return 0;
}
