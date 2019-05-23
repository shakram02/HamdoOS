#include <stdint.h>

uint8_t byte = 0x12C;
uint16_t word = 0x1234;
uint32_t dword = 0x12345678;
uint64_t qdword = 0x123456789ABCDEF;

unsigned __int128 dqword1 = (__int128) 0x123456789abcdef;
unsigned __int128 dqword2 = (__int128) 0x123456789abcdef << 64;

int main (int argc, char *argv[]) {
	return 0;
}
