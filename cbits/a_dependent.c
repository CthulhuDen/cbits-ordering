#include <stdio.h>
#include <a_dependent.h>

extern const char *msg;

const char *greeting()
{
  return msg;
}

void greet(const strStruct str)
{
  printf("Greetings: %s\n", str.str);
}
