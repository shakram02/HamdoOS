int a = 5;
int i;

void test() {}

int main(int argc, char *argv[])
{
    // return 0;
    // Exit retuning 0 (normal exit)
    // AT&T/UNIX assembly syntax
    asm(
        "mov $0x1, %eax \n"
        "mov $0x0, %ebx\n"
        "int $0x80");
}
