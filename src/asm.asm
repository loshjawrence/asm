.data
; I believe this section requires data alignment
; i.e. add padding dummy data
; note for ints you can stick an s in front for signed i think
; real4 is 4 bytes, a float32
; numbers are decimal by default, you can specify
; binary with a b suffix
; hex with a h suffix

; used in whileLoop
someArray dd 1, 2, 3, 4

; used in testSIMD
ints0 dd 0, 1, 2, 3
ints1 dd 5, 5, 5, 5

floats0 real4 0.0, 1.0, 2.0, 3.0
floats1 real4 5.0, 5.0, 5.0, 5.0
myfloat real4 67.2
; real8 is 64 bits or 8 bytes
mydouble real8 7.2

; for signed stick an s in front
; db means definebyte, can also use byte
mybyte db 1
mybyte2 byte 2

; word 16 bits or 2 bytes
myword word 3
myword2 dw 4

; double word 32 bits or 4 bytes
mydword dd 5
mydword2 dword 6

; quad word 64 bits or 8 bytes
myqword dq 7
myqword2 qword 8


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


moveToRAMAddr proc
    ; move the RAM addr that mybyte points to into rax
    lea rax, mybyte
    ; manipulate the memory pointer stored in rax so that the data stored at its location is now 0
    mov byte ptr [rax], 0
    ; same as above but now we move 1 into it
    mov mybyte, 1

    ret
moveToRAMAddr endp

triggerFlagCarry proc
    ; set to all 1s
    mov rax, -1
    ; this will overflow the reg and set the carry flag
    add rax, 1

    mov rax, -1
    ; inc will not set the carry flag
    inc rax

    ret
triggerFlagCarry endp

triggerFlagParity proc
    ; parity 1 since even num of 1
    mov eax, 3
    and eax, eax

    ; parity 0 since odd num of 1
    mov eax, 7
    and eax, eax

    ret
triggerFlagParity endp

triggerFlagSign proc
    mov eax, 7
    mov ecx, 12
    ; result neg
    sub eax, ecx
    ; result pos
    add eax, ecx

    ret
triggerFlagSign endp

; returns gcd of two unsigned 64bit ints
gcdEuclidsAlgo proc
    mov rax, 0 ; Early ret value
    cmp rcx, 0 ; numerator comes in on C
    je Finished
    cmp rdx, 0 ; denom comes in on D
    je Finished

    ; rbx is not scratch, if using must save/restore
    push rbx

    mov rbx, rdx ; need A and D for div

    LoopHead:
      xor rdx, rdx ; clear D for div
      mov rax, rcx ; move lower 64 bits of dividend to A
      div rbx ; result on A remainder on D
      mov rcx, rbx ; copy x to y
      mov rbx, rdx ; copy remainder to B

      cmp rdx, 0
      jne LoopHead

    mov rax, rcx

    pop rbx

Finished:
    ret ; rax is return value
gcdEuclidsAlgo endp

; example while loop
; do while would just remove the initial check that can step over the loop
whileLoop proc
   lea rax, someArray ; get the addr of someArray into rax
   xor rdx, rdx ; clear rdx
   mov ecx, 4
   cmp ecx, 0
   jle Finished

LoopHead:
    ; this is called sib addressing (scale index base)
    add dword ptr [rax + rdx*4], 3
    inc rdx
    dec ecx
    jnz LoopHead

Finished:
    ret
whileLoop endp

testSIMD proc
    ; move unaligned double quad word
    ; reads 128 bits into xmm0
    movdqu xmm0, xmmword ptr [ ints0 ]
    movdqu xmm1, xmmword ptr [ ints1 ]

    ; packed add dwords
    ; views contents as qwords or 32 bit ints
    paddd xmm0, xmm1
    ; could also do sub,mul,div

    ; mov aligned packed singles
    ; moves 128 bits of floating point data into the reg
    movaps xmm0, xmmword ptr [ floats0 ]
    movaps xmm1, xmmword ptr [ floats1 ]

    ; add packed singles
    ; views the contents as singles or 32bit floats
    addps xmm0, xmm1
    ; could also do sub,mul,div

    ; NOTE: double would be real8 data and stuff like
    ; movapd, addpd, subpd, etc.

    ret
testSIMD endp

end ; ends the code section?
