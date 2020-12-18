.data
; real4 is 32 bits or 4 bytes
myfloat real4 67.2
; real8 is 64 bits or 8 bytes
mydouble real8 7.2

; db means definebyte, can also use byte
mybyte db 1
mybyte2 byte 2

; word 16 bits or 2 bytes
myword word 3
myword2 dw 4

; double word 32 bits or 4 bytes
mydword dd 5;
mydword2 dword 6;

; quad word 64 bits or 8 bytes
myqword dq 7;
myqword2 qword 8;

.code
; can step in the debugger here and add stuff to watch window or pull up the register window with
; Debug->Windows->Registers
callAsmRbx proc
    ; NOTE: compiler expects rbx to the same as it was before you return from your function
    ; so you must push and pop before you edit it.
    push rbx

    mov rbx, 0
    ; -1 in 2s comp is all 1s (i.e. write the pos version, flip all bits and add 1)
    mov bx, -1
    ; clear the high byte of the 16 bit remister bx
    mov bh, 0

    pop rbx

    ; rax is the result that is returned
    mov rax, 123
    ret
callAsmRbx endp

callAsmUpper32Clear proc
    ; All 1's in the 64 bit reg alias then watch how these others behave
    ; basically the point is that only the 32 bit call has the behavior
    ; of additionally clearing hte top msb's
    mov rax, -1
    mov al, 0
    mov ax, 0
    mov eax, 0
    ret
callAsmUpper32Clear endp
end

moveToRAMAddr proc
    ; move the RAM addr that mybyte points to into rax
    lea rax, mybyte
    ; manipulate the memory pointer stored in rax so that the data stored at its location is now 0
    mov byte ptr [rax], 0
    ; same as above but now we move 1 into it
    mov mybyte, 1
moveToRAMAddr endp
end
