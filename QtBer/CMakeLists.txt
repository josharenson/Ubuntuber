include_directories(
    include/
    ${Qt5Qml_INCLUDE_DIRS}
    ${Qt5Core_INCLUDE_DIRS}
    ${Qt5Quick_INCLUDE_DIRS}
    ${Qt5Gui_INCLUDE_DIRS}
)

add_subdirectory(src/)

file(GLOB BACKEND_FILES include/*.h src/*.cpp)
add_library(qtber-qml SHARED ${BACKEND_FILES})

target_link_libraries(
    qtber-qml

    ${Qt5Core_LIBRARIES}
    ${Qt5Qml_LIBRARIES}
    ${Qt5Quick_LIBRARIES}
    ${Qt5Gui_LIBRARIES}
    ${LIBCONFIGPP_LIBRARY}
)

install(TARGETS qtber-qml DESTINATION ${CMAKE_BINARY_DIR})
