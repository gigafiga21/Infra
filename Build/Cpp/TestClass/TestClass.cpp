#include "TestClass.hpp"

void TestClass::setNumber(int number)
{
    this->number = number;
    this->used = true;
}

int TestClass::getNumber()
{
    return this->number;
}

bool TestClass::isUsed()
{
    return this->used;
}

TestClass::TestClass()
{
    this->used = false;
    this->number = 0;
}
