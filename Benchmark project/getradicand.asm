; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	;Program name: "getradicand". This is the support program that will be called by the manager function to take in a user's input of a radicand and returns it to the main function
	;Copyright (C) 2023 Hiep Do.
	 
	;This file is part of the software program "manager". * 
	;Manager is free software: you can redistribute it and / or modify it under the terms of the GNU General Public License * 
	;version 3 as published by the Free Software Foundation. * 
	;Manager is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied * 
	;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. * 
	;A copy of the GNU General Public License v3 is available here: <https:;www.gnu.org / licenses / >. * 
	; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	
	
	
	
	;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3 * * 
	;
	;Author information
	; Author name: Hiep Do
	; Author email: hgdo2803@csu.fullerton.edu
	;
	;Program information
	; Program name: manager
	; Programming languages: 1 modules in C++ and 2 modules in x64 assembly
	; Date program began: 2023 April 3
	; Date of last update: 2023 April 15
	;
	; Files in this program: manager.asm, getradicand.asm, main.cpp
	; Status: Finished.
	;
	;This file
	; File name: executive.asm
	; Language: X64 with Intel syntax.
	; Max page width: 132 columns
	; Assemble: nasm - f elf64 - l getradicand.lis - o getradicand.o getradicand.asm
	
	;===== Begin code area ================================================================================================

extern printf
extern scanf 

global getradicand

segment .data
radicand_prompt db 10, "Please enter a floating radicand for square root bench marking: ", 0, 10
radicand_input db "%lf", 0

segment .bss

segment .text

getradicand:

	;Prolog ===== Insurance for any caller of this assembly module ========================================================
	;Any future program calling this module that the data in the caller's GPRs will not be modified.
	
	push rbp
	mov rbp, rsp
	push rdi                     ;Backup rdi
	push rsi                     ;Backup rsi
	push rdx                     ;Backup rdx
	push rcx                     ;Backup rcx
	push r8                      ;Backup r8
	push r9                      ;Backup r9
	push r10                     ;Backup r10
	push r11                     ;Backup r11
	push r12                     ;Backup r12
	push r13                     ;Backup r13
	push r14                     ;Backup r14
	push r15                     ;Backup r15
	push rbx                     ;Backup rbx
	pushf                        ;Backup rflags

	;Block that display the prompt for user's input of a radicand
    mov rax, 0
    mov rdi, radicand_prompt
    call printf

	;Block that scan user's input for of the radicand number
    push qword 0
    push qword 0
    mov rax, 0
    mov rdi, radicand_input ;Display user's input of the radicand
    mov rsi, rsp
    call scanf ;Call scanf to take in the radicand value
    movsd xmm14, [rsp] ;Store user's input in xmm14
    pop rax
    pop rax

 ;===== Restore original values to integer registers ===================================================================
	popf                         ;Restore rflags
	pop rbx                      ;Restore rbx
	pop r15                      ;Restore r15
	pop r14                      ;Restore r14
	pop r13                      ;Restore r13
	pop r12                      ;Restore r12
	pop r11                      ;Restore r11
	pop r10                      ;Restore r10
	pop r9                       ;Restore r9
	pop r8                       ;Restore r8
	pop rcx                      ;Restore rcx
	pop rdx                      ;Restore rdx
	pop rsi                      ;Restore rsi
	pop rdi                      ;Restore rdi
	pop rbp                      ;Restore rbp
	
	ret
