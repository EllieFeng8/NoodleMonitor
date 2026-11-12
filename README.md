# NoodleMonitor

以 Qt 6 與 QML 建立的麵條製程監控介面。

## 專案內容

- `NoodleMonitorContent/`：監控面板、介面元件與狀態模型。
- `Core/`：C++ 監控資料與介面串接。
- `App/`：應用程式進入點。
- `Dependencies/`：Qt Design Studio 元件。
- `tests/`：測試程式。

## 開啟與建置

使用 Qt Design Studio 開啟 `NoodleMonitor.qmlproject`，或使用 CMake 3.21.1 以上版本與 Qt 6.12.0 建置。

`CMakePresets.json` 提供 Windows MinGW 建置設定；請依本機 Qt 與編譯器安裝位置調整路徑。

```sh
cmake --preset qt-6.12.0-debug
cmake --build --preset qt-6.12.0-debug
```
