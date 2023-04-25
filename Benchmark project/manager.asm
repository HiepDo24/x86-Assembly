; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	;Program name: "manager". This is the main program that will be calling getradicand function to perform computer benchmark on the square root function. The program attemps to loop the square root function n number of time and take the benchmark. * 
	;Copyright (C) 2023 Hiep Do.
	 
	;This file is part of the software program "executive". * 
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
	; Assemble: nasm - f elf64 - l manager.lis - o manager.o manager.asm
	
	;===== Begin code area ================================================================================================

extern printf
extern scanf
extern getradicand
extern get_clock_freq

global manager

segment .data
welcome db 10, "Welcome to Square Root Benchmarks by Hiep Do", 10, "For customer service contact me at hgdo2803@csu.fullerton.edu", 10, 0 
cpu_msg db 10, "Your CPU is %s", 10, 0
clock_speed_enter db 10, "Please enter your max clock speed in MHz and press Enter: ", 0, 10
input db "%d", 0
clock_speed db 10, "Your max clock speed is %d MHz", 10, 0
format db 10, "The square root of %0.10lf is %0.11lf", 10, 0
iteration db 10, "Next, enter the number of times iteration should be performed: ", 0
time_clock db 10, "The time clock is %llu tics", 0, 10
time_clock_2 db 10, "The time on the clock is %llu tics and the benchmark is completed.", 0, 10
benchmark_msg db 10, 10, "The bench mark of the sqrtsd instruction is in progress.", 10, 0
time_elapsed db 10, 10, "The elapsed time was %llu tics", 0, 10
one_sqrt db 10, 10, "The time for one square root computation is %0.5lf tics", 0
nano db " which equals %0.5lf ns.", 0, 10

fp_value dq 0.001

segment .bss

cpu_name resb 100
ten_power3 dq 1000

segment .text

manager:

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

    ;Block that display the welcome and info message
    mov rax, 0
    mov rdi, welcome
    call printf

    ;Block that retrieve CPU name and model number
    mov r15, 0x80000002
    mov rax, r15
    cpuid

    mov [cpu_name], rax
    mov [cpu_name+4], rbx
    mov [cpu_name+8], rcx
    mov [cpu_name+12], rdx

    mov r15, 0x80000003
    mov rax, r15
    cpuid

    mov [cpu_name+16], rax
    mov [cpu_name+20], rbx
    mov [cpu_name+24], rcx
    mov [cpu_name+28], rdx

    mov r15, 0x80000004
    mov rax, r15
    cpuid

    mov [cpu_name+32], rax
    mov [cpu_name+36], rbx
    mov [cpu_name+40], rcx
    mov [cpu_name+44], rdx

    ;Block that print out user's processor model
    mov rax, 0
    mov rdi, cpu_msg
    mov rsi, cpu_name
    call printf

    ;Block that prompt user to enter their max clock speed
    mov rax, 0
    mov rdi, clock_speed_enter
    call printf

    ;Block that ask user to input their max clock speed given their processor is AMD
    push qword 0
    push qword 0
    mov rax, 0
    mov rdi, input
    mov rsi, rsp
    call scanf 
    mov r12, [rsp] ;Store user's input of max clock speed in r12
    pop rax
    pop rax

    ;Block that display user's input of max clock speed
    mov rax, 0 
    mov rdi, clock_speed
    mov rsi, r12
    call printf

    ;Call radicand function to get user's input of radicand
    call getradicand

    ;Take square root of user's input of radicand
    sqrtsd xmm12, xmm14

    ; Display user's input of radicand and the square root result
    mov rax, 2
    mov rdi, format
    movsd xmm0, xmm14 ;copy radicand from xmm14 to xmm0
    movsd xmm1, xmm12 ;copy square root result from xmm12 to xmm1
    call printf

    ;Block that prompt user to input number of iteration they want
    mov rax, 0
    mov rdi, iteration
    call printf

    ;Block that scan for user's input for number of iteration
    push qword 0
    push qword 0
    mov rax, 0
    mov rdi, input
    mov rsi, rsp
    call scanf
    mov r14, [rsp] ;Store user's input of the number iterations in r14 
    pop rax
    pop rax

    ;block that calculate number of tics
    cpuid
    rdtsc
    shl rdx, 32
    add rdx, rax
    mov r13, rdx ;number of tics is stored in r13

    ;Block that display the number of tics for one square root computation
    mov rax, 0
    mov rdi, time_clock
    mov rsi, r13
    call printf

    ;Block that display message to user that benchmark is commencing
    mov rax, 0
    mov rdi, benchmark_msg
    call printf
    
    ;Loop that perform benchmark of square root function for n number of times
    mov r10, 0 ;set counter to 0
startLoop:
    cmp r10, r14 ;compare counter to user's input of iterations
    je exitLoop ;if counter = iteration, exit loop
    sqrtsd xmm11, xmm14 ; perform square root
    inc r10 ; increase counter
    jmp startLoop ; jump back to start of loop
exitLoop:

    ;Block that compute tics after n number of iterations are finished
    cpuid
    rdtsc
    shl rdx, 32 ;slide rdx over to the left by 32-bits
    add rdx, rax
    mov r11, rdx

    ;Block that display new tics number
    mov rax, 0
    mov rdi, time_clock_2
    mov rsi, r11
    call printf

    sub r11, r13 ;Subtract new tics number with old one to achieve time elapsed

    ;Block that display time elapsed
    mov rax, 0
    mov rdi, time_elapsed
    mov rsi, r11
    call printf

    cvtsi2sd xmm15, r11 ;Convert number of tics from integer to float
    cvtsi2sd xmm14, r14 ;Conver the number of iterations from integer to float
    divsd xmm15, xmm14 ;Divide the number of tics by the number of iterations

    ;Block that display the time for one square root computation
    mov rax, 1
    mov rdi, one_sqrt
    movsd xmm0, xmm15
    call printf

    ;Block that compute nanosecond
    mov rax, r12 ;move clock frequency to rax
    cvtsi2sd xmm13, r12 ;convert clock frequency to float and store in xmm13
    movsd xmm10, [fp_value] ;store value of 0.001 in xmm10
    mulsd xmm13, xmm10 ;multiply clock frequency with 0.001

    divsd xmm15, xmm13 ;divide the tics elapsed by xmm13

    ;Block that display the nanoseconds
    mov rax, 1
    mov rdi, nano
    movsd xmm0, xmm15
    call printf

    movsd xmm0, xmm15 ;Copy value of xmm15 to xmm0

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
