.code
callAsm proc
    ; NOTE: compiler expects rbx to the same as it was before you return from your function
    ; so you must push and pop before you edit it.
    push rbx

    mov rbx, 0
    ; -1 in 2s comp is all 1s (i.e. write the pos version, flip all bits and add 1)
    mov bx, -1
    ; clear the high byte of the 16 bit register bx
    mov bh, 0

    pop rbx

    ; rax is the result that is returned
    mov rax, 123
    ret
callAsm endp
end
