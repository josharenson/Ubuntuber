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

######################################
######### Packaging Stuff
option(CLICK_MODE "Installs to a contained location" off)
set(QTBER qtber)

set(APP_ARMOR_FILE "qtber-apparmor.json")
set(CONFIG_FILE qtber.cfg)
set(DESKTOP_FILE "qtber.desktop")
set(ICON_FILE "qtber.svg")
set(MANIFEST_FILE "manifest.json")

if(CLICK_MODE)
    message("Configured to create a click package")
    set(INSTALL_ROOT "package")
    set(PACKAGE_ROOT "${CMAKE_BINARY_DIR}/${INSTALL_ROOT}")
    file(MAKE_DIRECTORY ${PACKAGE_ROOT})

    set(APP_DIR "${PACKAGE_ROOT}")
    set(APP_ARMOR_DEST "${PACKAGE_ROOT}")
    set(DESKTOP_FILE_DEST "${PACKAGE_ROOT}")
    set(ICON_DEST "${PACKAGE_ROOT}/icons")
    set(CONFIG_FILE_DEST "${PACKAGE_ROOT}")
    set(MANIFEST_DEST "${PACKAGE_ROOT}")
    set(DESKTOP_EXEC "./${QTBER}")

    add_definitions("-DCLICK_MODE=1")

else(CLICK_MODE)
    set(INSTALL_ROOT "/")
    set(APP_DIR "${CMAKE_BINARY_DIR}")
    set(APP_ARMOR_DEST "${CMAKE_BINARY_DIR}")
    set(ICON_DEST "${CMAKE_BINARY_DIR}/icons")
    set(CONFIG_FILE_DEST "${CMAKE_BINARY_DIR}")
    set(DESKTOP_FILE_DEST "${CMAKE_BINARY_DIR}")
    set(DESKTOP_EXEC "./${QTBER}")
endif(CLICK_MODE)

if(NOT DEFINED BZR_SOURCE)
    set(BZR_SOURCE "lp:qtber")
endif(NOT DEFINED BZR_SOURCE)

if(NOT BZR_REVNO)
    set(BZR_REVNO "latest")
endif(NOT  BZR_REVNO)

# Install the config file
install(FILES ${CONFIG_FILE} DESTINATION ${CONFIG_FILE_DEST})
add_definitions("-DCONFIG_FILE_PATH=\"${CONFIG_FILE_DEST}/${CONFIG_FILE}\"")

# Configure and install the apparmor
configure_file("${APP_ARMOR_FILE}" "${APP_ARMOR_DEST}")

# Install the stupid icon
set(RELATIVE_ICON_PATH "icons/${ICON_FILE}")
install(FILES ${ICON_FILE} DESTINATION ${ICON_DEST})

# Configure and install the dekstop file
configure_file("${DESKTOP_FILE}" "${DESKTOP_FILE_DEST}")

# Configure and install the manifest
configure_file("${MANIFEST_FILE}" "${MANIFEST_DEST}")

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

add_subdirectory(QtBer/)


include_directories(
    ${CMAKE_CURRENT_BINARY_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${Qt5Core_INCLUDE_DIRS}
    ${Qt5Quick_INCLUDE_DIRS}
    ${Qt5Multimedia_INCLUDE_DIRS}
    ${Qt5Gui_INCLUDE_DIRS}
)

file(GLOB_RECURSE QMLDIR_FILES qmldir)
add_custom_target(QMLDIR_TARGET ALL SOURCES ${QMLDIR_FILES})

######################################
######### Testing stuff
find_package(Gtest REQUIRED)
include_directories(${GMOCK_INCLUDE_DIR} ${GTEST_INCLUDE_DIR})
add_subdirectory(tests/)
