#include <stdint.h>

int32_t i = 0x12345678;

int math_test(int i, int j)
{
	int add = i + j;
	add = i + 1;
	int sub = i - j;
	int mul = i * j;
	int div = i / j;
	int mod = i % j;
	int neg = -i;
	int and = i & j;
	int or = i | j;
	int xor = i ^ j;
	int not = ~i;
	int shl = i << 8;
	int shr = i >> 8;
	char equal1 = (i == j);
	int equal2 = (i == j);
	char greater = (i > j);
	char less = (i < j);
	char greater_equal = (i >= j);
	char less_equal = (i <= j);
	int logical_and = i && j;
	int logical_or = i || j;
	++i;
	--i;
	int i1 = i++;
	int i2 = ++i;
	int i3 = i--;
	int i4 = --i;
	return 0;
}

int main()
{
	int j = i;
	int k = 0xabcdef;
}
