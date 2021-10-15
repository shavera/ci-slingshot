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
endif()
