#include "calculator/Dummy.h"

#include <iostream>

namespace orbit_calculator{

std::string Dummy::helloWorld() const{
    return "Hello World!";
}

std::string Dummy::helloWho(int index) const {
  if(index < 0){
    return "Hello You.";
  }
  if((0 == index % 2 && index < 20) || 3 == index){
    if(index < 10){
      return "Hello alpha.";
    }
    if(index > 50){
      return "No way you get here.";
    }
    return "Hello beta.";
  }
  return "Hello gamma.";
}

} // namespace orbit_calculator
