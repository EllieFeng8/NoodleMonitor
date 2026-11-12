#pragma once

#include <QObject>
#include <QStringList>
#include <QVariantList>

// UI 共用資料入口。READ 使用 get、WRITE 使用 set、NOTIFY 使用 Changed。
// 輸入欄位保留文字，允許編輯中的空值、小數及日期格式。
// setter 僅在值變更後發出對應 Changed 訊號，讓 Nm 綁定的 UI 自動更新。
class NoodleMonitorProxy : public QObject
{
    Q_OBJECT
    // 攪拌日期（yyyy/MM/dd）
    Q_PROPERTY(QString date READ getDate WRITE setDate NOTIFY dateChanged)
    // 品名
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    // 配方
    Q_PROPERTY(QString recipe READ getRecipe WRITE setRecipe NOTIFY recipeChanged)
    // 批次
    Q_PROPERTY(QString batch READ getBatch WRITE setBatch NOTIFY batchChanged)
    // 室溫（°C）
    Q_PROPERTY(QString roomTemp READ getRoomTemp WRITE setRoomTemp NOTIFY roomTempChanged)
    // 粉溫（°C）
    Q_PROPERTY(QString flourTemp READ getFlourTemp WRITE setFlourTemp NOTIFY flourTempChanged)
    // 水溫（°C）
    Q_PROPERTY(QString waterTemp READ getWaterTemp WRITE setWaterTemp NOTIFY waterTempChanged)
    // 冰塊重量（kg）
    Q_PROPERTY(QString ice READ getIce WRITE setIce NOTIFY iceChanged)
    // 混合後麵糰溫度（°C）
    Q_PROPERTY(QString mixTemp READ getMixTemp WRITE setMixTemp NOTIFY mixTempChanged)
    // 入料麵糰溫度（°C）
    Q_PROPERTY(QString inTemp READ getInTemp WRITE setInTemp NOTIFY inTempChanged)
    // 套筒溫度（°C）
    Q_PROPERTY(QString barrelTemp READ getBarrelTemp WRITE setBarrelTemp NOTIFY barrelTempChanged)
    // 出料麵條溫度（°C）
    Q_PROPERTY(QString outTemp READ getOutTemp WRITE setOutTemp NOTIFY outTempChanged)
    // 性狀：毛邊
    Q_PROPERTY(bool rough READ getRough WRITE setRough NOTIFY roughChanged)
    // 性狀：出料不穩定
    Q_PROPERTY(bool unstable READ getUnstable WRITE setUnstable NOTIFY unstableChanged)
    // 性狀：長度偏短
    Q_PROPERTY(bool uneven READ getUneven WRITE setUneven NOTIFY unevenChanged)
    // 性狀備註
    Q_PROPERTY(QString note READ getNote WRITE setNote NOTIFY noteChanged)
    // 待新增的製程紀錄
    Q_PROPERTY(QString entry READ getEntry WRITE setEntry NOTIFY entryChanged)
    // 設備運轉狀態
    Q_PROPERTY(bool running READ getRunning WRITE setRunning NOTIFY runningChanged)
    // 即時電流（A）
    Q_PROPERTY(double current READ getCurrent WRITE setCurrent NOTIFY currentChanged)
    // 即時扭矩（N·m）
    Q_PROPERTY(double torque READ getTorque WRITE setTorque NOTIFY torqueChanged)
    // 電流趨勢資料（A）
    Q_PROPERTY(QVariantList currentSamples READ getCurrentSamples WRITE setCurrentSamples NOTIFY currentSamplesChanged)
    // 扭矩趨勢資料（額定扭矩百分比）
    Q_PROPERTY(QVariantList torqueSamples READ getTorqueSamples WRITE setTorqueSamples NOTIFY torqueSamplesChanged)
    // 趨勢圖的六個時間刻度（HH:mm）
    Q_PROPERTY(QStringList timeLabels READ getTimeLabels WRITE setTimeLabels NOTIFY timeLabelsChanged)
    // 系統時間及製程紀錄由 proxy 維護，UI 唯讀。
    Q_PROPERTY(QString dateTime READ getDateTime NOTIFY dateTimeChanged)
    Q_PROPERTY(QVariantList logs READ getLogs NOTIFY logsChanged)

public:
    explicit NoodleMonitorProxy(QObject *parent = nullptr);

    QString getDate() const { return m_date; }
    void setDate(const QString &value);
    QString getName() const { return m_name; }
    void setName(const QString &value);
    QString getRecipe() const { return m_recipe; }
    void setRecipe(const QString &value);
    QString getBatch() const { return m_batch; }
    void setBatch(const QString &value);
    QString getRoomTemp() const { return m_roomTemp; }
    void setRoomTemp(const QString &value);
    QString getFlourTemp() const { return m_flourTemp; }
    void setFlourTemp(const QString &value);
    QString getWaterTemp() const { return m_waterTemp; }
    void setWaterTemp(const QString &value);
    QString getIce() const { return m_ice; }
    void setIce(const QString &value);
    QString getMixTemp() const { return m_mixTemp; }
    void setMixTemp(const QString &value);
    QString getInTemp() const { return m_inTemp; }
    void setInTemp(const QString &value);
    QString getBarrelTemp() const { return m_barrelTemp; }
    void setBarrelTemp(const QString &value);
    QString getOutTemp() const { return m_outTemp; }
    void setOutTemp(const QString &value);
    bool getRough() const { return m_rough; }
    void setRough(bool value);
    bool getUnstable() const { return m_unstable; }
    void setUnstable(bool value);
    bool getUneven() const { return m_uneven; }
    void setUneven(bool value);
    QString getNote() const { return m_note; }
    void setNote(const QString &value);
    QString getEntry() const { return m_entry; }
    void setEntry(const QString &value);
    bool getRunning() const { return m_running; }
    void setRunning(bool value);
    double getCurrent() const { return m_current; }
    void setCurrent(double value);
    double getTorque() const { return m_torque; }
    void setTorque(double value);
    QVariantList getCurrentSamples() const { return m_currentSamples; }
    void setCurrentSamples(const QVariantList &value);
    QVariantList getTorqueSamples() const { return m_torqueSamples; }
    void setTorqueSamples(const QVariantList &value);
    QStringList getTimeLabels() const { return m_timeLabels; }
    void setTimeLabels(const QStringList &value);
    QString getDateTime() const { return m_dateTime; }
    QVariantList getLogs() const { return m_logs; }

    // 生產操作更新監控狀態及紀錄；設備通訊可由後續控制層接入。
    Q_INVOKABLE void start();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void reset();
    Q_INVOKABLE void addLog(const QString &message);

signals:
    void dateChanged();
    void nameChanged();
    void recipeChanged();
    void batchChanged();
    void roomTempChanged();
    void flourTempChanged();
    void waterTempChanged();
    void iceChanged();
    void mixTempChanged();
    void inTempChanged();
    void barrelTempChanged();
    void outTempChanged();
    void roughChanged();
    void unstableChanged();
    void unevenChanged();
    void noteChanged();
    void entryChanged();
    void runningChanged();
    void currentChanged();
    void torqueChanged();
    void currentSamplesChanged();
    void torqueSamplesChanged();
    void timeLabelsChanged();
    void dateTimeChanged();
    void logsChanged();

private:
    QString m_date;
    QString m_name="1";
    QString m_recipe="2";
    QString m_batch="3";
    QString m_roomTemp="4";
    QString m_flourTemp="5";
    QString m_waterTemp="6";
    QString m_ice="7";
    QString m_mixTemp="8";
    QString m_inTemp="9";
    QString m_barrelTemp="10";
    QString m_outTemp="12";
    bool m_rough = false;
    bool m_unstable = false;
    bool m_uneven = false;
    QString m_note="13";
    QString m_entry="14";
    bool m_running = false;
    double m_current = 15;
    double m_torque = 16;
    QVariantList m_currentSamples;
    QVariantList m_torqueSamples;
    QStringList m_timeLabels;
    QString m_dateTime="17";
    QVariantList m_logs;
};
