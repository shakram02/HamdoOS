./compile_for_objdump.sh $1 && objdump --no-show-raw-insn -M intel -S -D "$1".o | less
