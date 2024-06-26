file(GLOB_RECURSE VERILOG_FILES ${CMAKE_SOURCE_DIR}/verilog/*.v)

set(VERILOG_DIR ${CMAKE_SOURCE_DIR}/verilog)

# find Qt6
find_package(Qt6 COMPONENTS Core Gui Widgets REQUIRED)

# find verilator
find_package(verilator HINTS $ENV{VERILATOR_ROOT})

# config file
configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/src/config.h.in
    ${CMAKE_CURRENT_SOURCE_DIR}/src/config.h
)

# Qt
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(SIM_SRCS
    src/main.cc
    src/MainWindow.h
    src/MainWindow.cc
    src/Canvas.h
    src/Canvas.cc
    src/Keypad.h
    src/Keypad.cc
    src/HWDut.h
    src/HWDut.cc
    src/CoeReader.h
    src/CoeReader.cc
    src/Memory.h
    src/Memory.cc
)

qt_add_executable(sim
    MANUAL_FINALIZATION
    ${SIM_SRCS}
)

# Verilator
verilate(sim SOURCES ${VERILOG_DIR}/top.v TRACE INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/verilog VERILATOR_ARGS -Wno-fatal)

set_target_properties(sim PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER taruhi.whackmole.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_include_directories(sim PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)
target_link_libraries(sim PRIVATE Qt6::Widgets)

qt_finalize_executable(sim)
