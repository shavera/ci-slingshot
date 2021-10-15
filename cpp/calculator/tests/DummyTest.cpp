#include "calculator/Dummy.h"

#include "gtest/gtest.h"

namespace orbit_calculator{
namespace{

TEST(DummyTest, Dummy){
    Dummy dummy{};
    EXPECT_EQ("Hello World!", dummy.helloWorld());
}

} // namespace
} // namespace orbit_calculator
