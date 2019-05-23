gcc -m32 "$1".c -o "$1".o && readelf -s "$1".o
