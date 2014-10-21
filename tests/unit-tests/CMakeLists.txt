include_directories(
    ${LIBCONFIGPP_INCLUDE_DIR}
)

set(
    UNIT_TEST_SOURCES

    test_config_file.cpp
    test_oauth.cpp
)

link_directories(${LIBRARY_OUTPUT_PATH})

add_executable(qtber_unit_tests
    ${UNIT_TEST_SOURCES}
)

add_dependencies(qtber_unit_tests GMock)

find_package(Threads)
target_link_libraries(
    qtber_unit_tests

    ${GTEST_BOTH_LIBRARIES}
    ${GMOCK_LIBRARY}
    ${GMOCK_MAIN_LIBRARY}
    ${CMAKE_THREAD_LIBS_INIT} #Link in pthread.
    ${LIBCONFIGPP_LIBRARIES}
)
