file(GLOB ROOT_QML_FILES *.qml)
file(GLOB_RECURSE VIEW_FILES views/*.qml)
file(GLOB COMPONENT_FILES components/*.qml)
file(GLOB QML_TEST_FILES tests/*)
file(GLOB ASSET_FILES assets/*)

install(FILES ${ROOT_QML_FILES}
    DESTINATION ${APP_DIR}
)

install(FILES ${VIEW_FILES}
    DESTINATION ${APP_DIR}/views
)

install(FILES ${COMPONENT_FILES}
    DESTINATION ${APP_DIR}/components
)

install(FILES ${QML_TEST_FILES}
    DESTINATION ${APP_DIR}/tests
)

install(FILES ${ASSET_FILES}
        DESTINATION ${APP_DIR}/assets
)

