cmake_minimum_required(VERSION 3.21)
project(slingshot_engine)

option(BUILD_TESTS "Build tests with project" ON)
option(BUILD_CODE_COVERAGE "Calculate code coverage for project" OFF)

add_subdirectory(calculator)

if(BUILD_TESTS)
    add_subdirectory(third_party/googletest)
endif()