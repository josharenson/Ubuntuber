file(GLOB_RECURSE QML_JS_FILES *.qml *.js)
file(GLOB ASSET_FILES assets/*)

install(FILES ${QML_JS_FILES}
    DESTINATION ${APP_DIR}
)

install(FILES ${ASSET_FILES}
        DESTINATION ${APP_DIR}/assets
)

