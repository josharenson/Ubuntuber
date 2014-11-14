include(FindPkgConfig)
find_package(Qt5Core)
find_package(Qt5Qml)
find_package(Qt5Quick)
find_package(Qt5Widgets)

add_subdirectory(app)
add_subdirectory(plugin)
