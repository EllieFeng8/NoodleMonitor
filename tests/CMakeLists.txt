cmake_minimum_required(VERSION 3.21)
project(NoodleMonitorProxyTests LANGUAGES CXX)
set(CMAKE_AUTOMOC ON)
find_package(Qt6 6.12.0 EXACT REQUIRED COMPONENTS Widgets Qml Quick Test)
add_executable(ProxySmoke ProxySmoke.cpp ../Core/NoodleMonitorProxy.cpp ../Core/NoodleMonitorProxy.h)
target_link_libraries(ProxySmoke PRIVATE Qt6::Widgets Qt6::Qml Qt6::Quick Qt6::Test)
target_compile_definitions(ProxySmoke PRIVATE NOODLE_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}/..")
enable_testing()
add_test(NAME ProxySmoke COMMAND ProxySmoke)
set_tests_properties(ProxySmoke PROPERTIES
    ENVIRONMENT "QT_QPA_PLATFORM=offscreen;QT_QUICK_BACKEND=software"
    TIMEOUT 20)
