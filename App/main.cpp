// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml/qqml.h>

#include "Core/NoodleMonitorProxy.h"

#include "autogen/environment.h"

int main(int argc, char *argv[])
{
    set_qt_environment();
    QApplication app(argc, argv);

    // 在載入 QML 前註冊共用 proxy：import Core 1.0 後以 Nm 存取。
    // 由 app 管理生命週期，確保 Nm 比 QML engine 活得久。
    auto *nm = new NoodleMonitorProxy(&app);
    qmlRegisterSingletonInstance<NoodleMonitorProxy>("Core", 1, 0, "Nm", nm);

    QQmlApplicationEngine engine;
    const QUrl url(mainQmlFile);
    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated, &app,
                [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");
    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
