include_directories(include/)
add_subdirectory(src/)

file(GLOB BACKEND_FILES include/*.h src/*.cpp)
add_library(qtber-qml ${BACKEND_FILES})

target_link_libraries(
    qtber-qml

    ${OAuth_LIBRARIES}
)

install(TARGETS qtber-qml DESTINATION ${CMAKE_BINARY_DIR})
