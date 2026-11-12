#include "NoodleMonitorProxy.h"

#include <QDateTime>
#include <QTimer>
#include <QVariantMap>
#include <cmath>

namespace {
constexpr qsizetype maxLogs = 100;
}

NoodleMonitorProxy::NoodleMonitorProxy(QObject *parent)
    : QObject(parent),
      m_date(QDate::currentDate().toString("yyyy/MM/dd")),
      m_dateTime(QDateTime::currentDateTime().toString("yyyy/MM/dd HH:mm"))
{
    // 六個時間刻度先留空；監控數值及趨勢由設備端透過 setter 更新。
    m_timeLabels = {"", "", "", "", "", ""};
    // 系統時鐘由 proxy 維護，值未改變時不重複通知 UI。
    auto *clock = new QTimer(this);
    connect(clock, &QTimer::timeout, this, [this] {
        const auto now = QDateTime::currentDateTime().toString("yyyy/MM/dd HH:mm");
        if (m_dateTime == now) return;
        m_dateTime = now;
        emit dateTimeChanged();
    });
    clock->start(1000);
}

void NoodleMonitorProxy::setDate(const QString &value)
{
    if (m_date == value) return;
    m_date = value;
    emit dateChanged();
}

void NoodleMonitorProxy::setName(const QString &value)
{
    if (m_name == value) return;
    m_name = value;
    emit nameChanged();
}

void NoodleMonitorProxy::setRecipe(const QString &value)
{
    if (m_recipe == value) return;
    m_recipe = value;
    emit recipeChanged();
}

void NoodleMonitorProxy::setBatch(const QString &value)
{
    if (m_batch == value) return;
    m_batch = value;
    emit batchChanged();
}

void NoodleMonitorProxy::setRoomTemp(const QString &value)
{
    if (m_roomTemp == value) return;
    m_roomTemp = value;
    emit roomTempChanged();
}

void NoodleMonitorProxy::setFlourTemp(const QString &value)
{
    if (m_flourTemp == value) return;
    m_flourTemp = value;
    emit flourTempChanged();
}

void NoodleMonitorProxy::setWaterTemp(const QString &value)
{
    if (m_waterTemp == value) return;
    m_waterTemp = value;
    emit waterTempChanged();
}

void NoodleMonitorProxy::setIce(const QString &value)
{
    if (m_ice == value) return;
    m_ice = value;
    emit iceChanged();
}

void NoodleMonitorProxy::setMixTemp(const QString &value)
{
    if (m_mixTemp == value) return;
    m_mixTemp = value;
    emit mixTempChanged();
}

void NoodleMonitorProxy::setInTemp(const QString &value)
{
    if (m_inTemp == value) return;
    m_inTemp = value;
    emit inTempChanged();
}

void NoodleMonitorProxy::setBarrelTemp(const QString &value)
{
    if (m_barrelTemp == value) return;
    m_barrelTemp = value;
    emit barrelTempChanged();
}

void NoodleMonitorProxy::setOutTemp(const QString &value)
{
    if (m_outTemp == value) return;
    m_outTemp = value;
    emit outTempChanged();
}

void NoodleMonitorProxy::setRough(bool value)
{
    if (m_rough == value) return;
    m_rough = value;
    emit roughChanged();
}

void NoodleMonitorProxy::setUnstable(bool value)
{
    if (m_unstable == value) return;
    m_unstable = value;
    emit unstableChanged();
}

void NoodleMonitorProxy::setUneven(bool value)
{
    if (m_uneven == value) return;
    m_uneven = value;
    emit unevenChanged();
}

void NoodleMonitorProxy::setNote(const QString &value)
{
    if (m_note == value) return;
    m_note = value;
    emit noteChanged();
}

void NoodleMonitorProxy::setEntry(const QString &value)
{
    if (m_entry == value) return;
    m_entry = value;
    emit entryChanged();
}

void NoodleMonitorProxy::setRunning(bool value)
{
    if (m_running == value) return;
    m_running = value;
    emit runningChanged();
}

void NoodleMonitorProxy::setCurrent(double value)
{
    // 排除 NaN / infinity，避免數字顯示與趨勢繪圖失效。
    if (!std::isfinite(value)) return;
    if (m_current == value) return;
    m_current = value;
    emit currentChanged();
}

void NoodleMonitorProxy::setTorque(double value)
{
    // 排除 NaN / infinity，避免數字顯示與趨勢繪圖失效。
    if (!std::isfinite(value)) return;
    if (m_torque == value) return;
    m_torque = value;
    emit torqueChanged();
}

void NoodleMonitorProxy::setCurrentSamples(const QVariantList &value)
{
    if (m_currentSamples == value) return;
    m_currentSamples = value;
    emit currentSamplesChanged();
}

void NoodleMonitorProxy::setTorqueSamples(const QVariantList &value)
{
    if (m_torqueSamples == value) return;
    m_torqueSamples = value;
    emit torqueSamplesChanged();
}

void NoodleMonitorProxy::setTimeLabels(const QStringList &value)
{
    if (m_timeLabels == value) return;
    m_timeLabels = value;
    emit timeLabelsChanged();
}

void NoodleMonitorProxy::start()
{
    if (getRunning()) return;
    setRunning(true);
    addLog(QStringLiteral("開始生產"));
}

void NoodleMonitorProxy::stop()
{
    if (!getRunning()) return;
    setRunning(false);
    addLog(QStringLiteral("停止生產"));
}

void NoodleMonitorProxy::reset()
{
    // 重置監控資料，保留操作員輸入的配方、批次及性狀。
    setRunning(false);
    setCurrent(0);
    setTorque(0);
    setCurrentSamples({});
    setTorqueSamples({});
    setTimeLabels({"", "", "", "", "", ""});
    addLog(QStringLiteral("監控資料已重置"));
}

void NoodleMonitorProxy::addLog(const QString &message)
{
    const auto text = message.trimmed();
    if (text.isEmpty()) return;
    // 最新紀錄放最前面；限制筆數，避免長時間運作持續累積記憶體。
    m_logs.prepend(QVariantMap{{"time", QTime::currentTime().toString("HH:mm")},
                              {"messageText", text}});
    while (m_logs.size() > maxLogs) m_logs.removeLast();
    emit logsChanged();
}
