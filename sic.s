section .data
format_in: db "%d, ",0
format_out: db "%d",10,0
M: TIMES 1024 dq 0

    
extern scanf
extern printf

section .text
global main
main:
    enter 0,0
    mov r13,0; ip
    mov r14,M
    mov r15,0
    mov rax,0
    jmp absorb_numbers
    
absorb_numbers:   
    mov rdi,format_in
    mov rsi,r14
    call scanf

    mov r15,rax
    add r14,8
    
    cmp r15, 100
    jg eval_part1
    jmp absorb_numbers
    
eval_part1:
    cmp qword[M+r13*8], 0
    jne eval_part2
    cmp qword[M+r13*8+8], 0
    jne eval_part2
    cmp qword[M+r13*8+16], 0
    jne eval_part2
    jmp print

eval_part2:
    mov r8, qword[M+r13*8]; r8 = A
    mov r9, qword[M+ r8*8]; r9 = M[A]   
    mov r10, qword[M+r13*8+8]; r8 = B
    mov r11, qword[M+ r10*8]; r9 = M[B]  
    sub r9,r11
    mov qword[M+r8*8], r9
    cmp r9,0
    jl jmp_to_c
    jmp add_3
    
jmp_to_c:
    mov r13,qword[M+r13*8+16]
    jmp eval_part1
add_3:
    add r13,3
    jmp eval_part1
    
print:
    mov r15,0
    mov r14,M
    .loop:
        cmp r15,1024
        je end_code
        mov rdi,format_out
        mov rsi,qword[r14]
        call printf
        add r14,8
        inc r15
        jmp .loop
        
end_code:
    leave
    ret    