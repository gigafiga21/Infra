#include <iostream>
#include "./TestClass/TestClass.hpp"

int main()
{
    TestClass container;

    container.setNumber(2);
    std::cout << container.getNumber() << std::endl;
    std::cout << container.isUsed() << std::endl;

    return 0;
}
