add_library(orbit_calculator)

target_sources(orbit_calculator
    PRIVATE
        Dummy.cpp
)

target_include_directories(orbit_calculator
    PUBLIC
        include
)

if(BUILD_TESTS)
    add_subdirectory(tests)
    if((${CMAKE_BUILD_TYPE} STREQUAL Debug) AND BUILD_CODE_COVERAGE)
        target_link_libraries(orbit_calculator PRIVATE gcov)
        target_compile_options(orbit_calculator PRIVATE --coverage)
    endif()
endif()
