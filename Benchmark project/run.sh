#!/bin/bash

#Program: Manager
#Author: Hiep Do

#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble getradicand.asm"
nasm -f elf64 -l getradicand.lis -o getradicand.o getradicand.asm

echo "compile main.cpp using g++ compiler standard 2020"
g++ -c -Wall -m64 -no-pie -o main.o main.cpp -std=c++20

echo "Link object files using the g++ Linker standard 2020"
g++ -m64 -no-pie -o manager.out manager.o getradicand.o main.o -std=c++20

echo "Run the Manager Program:"
./manager.out

echo "Script file terminated."


