include_directories(include/)
add_subdirectory(src/)

file(GLOB BACKEND_FILES include/*.h src/*.cpp)
add_library(qtber-qml ${BACKEND_FILES})

target_link_libraries(
    qtber-qml

    ${Qt5Qml_LIBRARIES}
    ${Qt5Quick_LIBRARIES}
    ${LIBCONFIGPP_LIBRARY}
)

install(TARGETS qtber-qml DESTINATION ${CMAKE_BINARY_DIR})
