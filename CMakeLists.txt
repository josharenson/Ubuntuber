cmake_minimum_required(VERSION 2.8.9)


######################################
##### Cmake stuff
# Default install location. Must be set here, before setting the project.
if (NOT DEFINED CMAKE_INSTALL_PREFIX)
    set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install CACHE PATH "" FORCE)
endif()

project(QtBer C CXX)

if(${PROJECT_BINARY_DIR} STREQUAL ${PROJECT_SOURCE_DIR})
   message(FATAL_ERROR "In-tree build attempt detected, aborting. Set your build dir outside your source dir, delete CMakeCache.txt from source root and try again.")
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(EnableCoverageReport)
#####################################################################
# Enable code coverage calculation with gcov/gcovr/lcov
# Usage:
#  * Switch build type to coverage (use ccmake or cmake-gui)
#  * Invoke make, make test, make coverage (or ninja if you use that backend)
#  * Find html report in subdir coveragereport
#  * Find xml report feasible for jenkins in coverage.xml
#####################################################################
if(cmake_build_type_lower MATCHES coverage)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --coverage" )
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --coverage" )
  set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} --coverage" )
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} --coverage" )
  ENABLE_COVERAGE_REPORT(TARGETS ${SHELL_APP} FILTER /usr/include ${CMAKE_SOURCE_DIR}/tests/* ${CMAKE_BINARY_DIR}/*)
endif()

# Make sure we have all the needed symbols
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-z,defs")
set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -Wl,-z,defs")

# Static C++ checks
add_custom_target(cppcheck COMMAND cppcheck --enable=all -q --error-exitcode=2
                                       ${CMAKE_SOURCE_DIR}/src ${CMAKE_SOURCE_DIR}/tests)

add_subdirectory(cmake/)

set(APP_DIR ${CMAKE_INSTALL_DATADIR}/qtber)

######################################
######### QML Stuff
set(CMAKE_AUTOMOC ON)

# enable QML debugging
string(TOLOWER "${CMAKE_BUILD_TYPE}" cmake_build_type_lower) # Build types should always be lowercase but sometimes they are not.
if(cmake_build_type_lower MATCHES "debug")
    add_definitions(-DQT_QML_DEBUG)
endif()

find_package(Qt5Core 5.2 REQUIRED)
find_package(Qt5Qml 5.2 REQUIRED)
find_package(Qt5Quick 5.2 REQUIRED)
find_package(Qt5Gui 5.2 REQUIRED)

add_subdirectory(qml)

######################################
######### Backend stuff
find_package(Oauth REQUIRED)
find_package(LibConfig REQUIRED)

add_subdirectory(backend/)

# Make config file path global so backend/testing can use it
set(CONFIG_FILE_NAME qtber.cfg)
install(
    FILES ${PROJECT_SOURCE_DIR}/${CONFIG_FILE_NAME}
    DESTINATION ${CMAKE_BINARY_DIR}/install/cfg/
)
add_definitions(
    -DCONFIG_FILE_PATH="${CMAKE_BINARY_DIR}/install/cfg/${CONFIG_FILE_NAME}"
)
######################################
######### Testing stuff
find_package(Gtest REQUIRED)
include_directories(${GMOCK_INCLUDE_DIR} ${GTEST_INCLUDE_DIR})
add_subdirectory(tests/)

######################################
######### Packaging Stuff
option(CLICK_MODE "Installs to a contained location" off)
if(CLICK_MODE)
    if(NOT DEFINED BZR_SOURCE)
        set(BZR_SOURCE "lp:qtber")
    endif(NOT DEFINED BZR_SOURCE)
    set(CMAKE_INSTALL_PREFIX /)
    set(QTBER_DIR /)
    set(CMAKE_INSTALL_BINDIR /)
    set(PLUGIN_BASE lib/${CMAKE_LIBRARY_ARCHITECTURE})
    set(DESKTOP_EXEC "./${QTBER}")
    set(QTBER_ICON "${CMAKE_INSTALL_DATADIR}/icons/qtber.svg")

    install(FILES qtber.svg DESTINATION ${CMAKE_INSTALL_DATADIR}/icons)
    configure_file(manifest.json ${CMAKE_CURRENT_BINARY_DIR}/manifest.json)
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/manifest.json
        DESTINATION ${CMAKE_INSTALL_PREFIX}
    )
    add_definitions("-DCLICK_MODE=1")

    if(NOT BZR_REVNO)
        set(BZR_REVNO "latest")
    endif(NOT  BZR_REVNO)
else(CLICK_MODE)
    set(QTBER_ICON "qtber")
    set(QTBER_DIR ${CMAKE_INSTALL_DATADIR}/${QTBER})
    set(DESKTOP_EXEC ${QTBER})
endif(CLICK_MODE)

