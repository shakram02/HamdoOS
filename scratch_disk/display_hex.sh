nasm -f bin "$1".asm -o "$1"
hexedit -l16 $1
