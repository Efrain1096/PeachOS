

; Look up "Ralph's Interrupt List".


ORG 0x7c00
BITS 16

start:
    mov si, message ; Move the address of the message label to the SI register.
    call print ; Call the print subroutine (function,method)
    jmp $

print:
    mov bx, 0
.loop:
    lodsb ; Loads characters into the AL register that si is pointing to.
    cmp al, 0 ; This is for the zero(null?) teminator character to end printing
    je .done
    call print_char
    jmp .loop
.done:
    ret


print_char:
    mov ah, 0eh ; Sets the AH register to 0EH, because it's needed for the BIOS function to outputting to the screen. 
    ;mov al, 'A' 
    ;mov bx, 0
    int 0x10 ; Calling the BIOS.
    ret

message: db "Hello World!", 0

times 510-($ - $$) db 0 ; We need to fill 510 bytes of data. If the above code doesn't do that, then the remaining unfilled bytes will be padded with zeroes.
dw 0xAA55 ; This is needed for the boot signature 55AA on the last two bytes. The reason it's not "55AA" is because Intel machines are little endian, the bytes get flipped. It'll still be written as "55AA".