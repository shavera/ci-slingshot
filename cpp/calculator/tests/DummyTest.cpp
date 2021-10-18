#include "calculator/Dummy.h"

#include "gtest/gtest.h"

namespace orbit_calculator{
namespace{

TEST(DummyTest, Dummy){
    Dummy dummy{};
    EXPECT_EQ("Hello World!", dummy.helloWorld());
}

TEST(DummyTest, helloWhoNegative){
  Dummy d{};
  EXPECT_EQ("Hello You.", d.helloWho(-1));
}

TEST(DummyTest, helloWhoAlpha){
  Dummy d{};
  // even number less than 10
  // also 3 would work, but leaving that aside for MCDC coverage
  EXPECT_EQ("Hello alpha.", d.helloWho(4));
}

TEST(DummyTest, helloWhoBeta){
  Dummy d{};
  // even number greater than 10 less than 20
  EXPECT_EQ("Hello beta.", d.helloWho(14));
}

// skipping test for hello gamma

} // namespace
} // namespace orbit_calculator
