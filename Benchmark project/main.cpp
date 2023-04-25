// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	//Program name: "manager". This is the main program that will be calling getradicand function to perform computer benchmark on the square root function. The program attemps to loop the square root function n number of time and take the benchmark. * 
	//Copyright (C) 2023 Hiep Do.
	 
	//This file is part of the software program "manager". * 
	//Manager is free software: you can redistribute it and / or modify it under the terms of the GNU General Public License * 
	//version 3 as published by the Free Software Foundation. * 
	//Manager is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied * 
	//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. * 
	//A copy of the GNU General Public License v3 is available here: <https:;www.gnu.org / licenses / >. * 
	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	
	
	
	
	//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3 * * 
	//
	//Author information
	// Author name: Hiep Do
	// Author email: hgdo2803@csu.fullerton.edu
	//
	//Program information
	// Program name: manager
	// Programming languages: 1 modules in C++ and 2 modules in x64 assembly
	// Date program began: 2023 April 3
	// Date of last update: 2023 April 15
	//
	// Files in this program: manager.asm, getradicand.asm, main.cpp
	// Status: Finished.
	//
	//This file
	// File name: executive.asm
	// Language: X64 with Intel syntax.
	// Max page width: 132 columns
	// Assemble: nasm - f elf64 - l manager.lis - o manager.o manager.asm
	
	//===== Begin code area ================================================================================================

#include<iostream>
#include<string>
#include<iomanip>
using namespace std;

extern "C" double manager();

int main(){
    double nanoseconds = 0.0;
    nanoseconds = manager();
    cout << "\n\nThe main file received this number " << nanoseconds << " and will keep it for future reference.\n";
    cout << "The main function will return a zero to the operating system.\n";
    return 0;
}