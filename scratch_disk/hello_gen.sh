echo "bits 32\
	jmp eax" > hello.asm
nasm -f bin hello.asm -o hello
hexedit -l16 hello 
