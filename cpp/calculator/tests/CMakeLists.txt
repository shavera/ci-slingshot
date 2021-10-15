add_executable(orbit_calculator_test)

target_sources(orbit_calculator_test
    PRIVATE
        DummyTest.cpp
)

target_link_libraries(orbit_calculator_test PRIVATE orbit_calculator gtest_main)

add_test(orbit_calculator_test orbit_calculator_test)
