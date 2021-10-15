cmake_minimum_required(VERSION 3.20)
project(slingshot_engine)

option(BUILD_TESTS "Build tests with project" ON)
option(BUILD_CODE_COVERAGE "Calculate code coverage for project" OFF)
if(BUILD_TESTS)
    enable_testing()
endif()

add_subdirectory(calculator)

if(BUILD_TESTS)
    add_subdirectory(third_party/googletest)
endif()