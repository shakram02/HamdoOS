#include <stdio.h>
int x = 0x32;

int main()
{
	int ptr[3] = {0xA, 0xB, 0xC, 0xD};
	int *p = ptr;
	printf("ADDR:%X\tCONTENT:0x%x\n", p, *p);
	printf("ADDR:%X\tADDR2:%X\tADDR2:%X\n", p, p + 3, &(p[3]));
}