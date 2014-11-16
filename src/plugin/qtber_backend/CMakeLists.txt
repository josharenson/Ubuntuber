find_package(LibConfig)

include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(PLUGIN_DIR com/gmail/josharenson/qtber)

set(qtber_backend_SRCS
	configfile.cpp
	configfile.h
	plugin.h
	plugin.cpp
)

add_library(QtBerBackend MODULE
    ${qtber_backend_SRCS}
)

target_link_libraries(QtBerBackend libconfig++)

qt5_use_modules(QtBerBackend Gui Qml Quick Widgets)

# Copy the plugin, the qmldir file and other assets to the build dir for running in QtCreator
if(NOT "${CMAKE_CURRENT_SOURCE_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")
    add_custom_command(TARGET QtBerBackend POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_BINARY_DIR}/../${PLUGIN_DIR}
        COMMENT "Creating plugin directory layout in the build directory"
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/qmldir ${CMAKE_CURRENT_BINARY_DIR}/../${PLUGIN_DIR}
        COMMENT "Copying the qmldir file to the build directory"
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:QtBerBackend> ${CMAKE_CURRENT_BINARY_DIR}/../${PLUGIN_DIR}
        COMMENT "Copying the plugin binary to the build directory"
    )
endif(NOT "${CMAKE_CURRENT_SOURCE_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")

# Install plugin file
install(TARGETS QtBerBackend DESTINATION ${QT_IMPORTS_DIR}/${PLUGIN_DIR})
install(FILES qmldir DESTINATION ${QT_IMPORTS_DIR}/${PLUGIN_DIR})

