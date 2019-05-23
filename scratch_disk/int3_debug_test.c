#include <stdio.h>

int main(int argc, char* argv[])
{
    asm("int 3");
    printf("Hello world!\n");

    return 0;
}
