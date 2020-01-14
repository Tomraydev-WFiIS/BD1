#!/usr/bin/env bash
ecpg -t test.sqc
gcc -g -I/usr/include/postgresql test.c -o test -lecpg -lpq
chmod +x ./test