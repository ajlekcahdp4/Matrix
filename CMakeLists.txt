cmake_minimum_required(VERSION 3.18)

project(Matrix)

if (${PROJECT_SOURCE_DIR} STREQUAL ${PROJECT_BINARY_DIR})
    message(FATAL_ERROR "In-source build is forbidden")
endif()

find_package(Threads REQUIRED)

find_package(GTest REQUIRED)
enable_testing()

set(CMAKE_CXX_STANDARD          20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS        OFF)

add_library(${PROJECT_NAME} INTERFACE)
#target_link_libraries(${PROJECT_NAME} INTERFACE Vector)
target_include_directories(${PROJECT_NAME} INTERFACE lib/include)

add_subdirectory(unit_tests)
add_subdirectory(task)
