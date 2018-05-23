;
; brainfuck compiler by Pawel Krogulec
; no wrapping, short tape, no comments supported
; 92 bytes of executable
;

org 0x100

	mov cl, 0x80
	mov di, cx
	rep stosb
	dec di

	mov si, code

main_loop:

	lodsb

	and al, 0x1f
	mov bx, map
	xlatb
	mov bl, al

	mov dl, [di]
	call bx
	jmp main_loop

map:

db fin

	proc_plus:
		inc byte [di]
		ret

	proc_dot:
		mov ah, 2
		int 0x21
		ret

	proc_right:
		dec di
		ret
 
db proc_plus
db proc_comma
db proc_minus
db proc_dot

	proc_comma:
		mov ah, 6
		mov dl, 0xff
		int 0x21
		mov [di], al
		ret

	proc_minus:
		dec byte [di]
		ret

db proc_lbrace
db proc_left
db proc_rbrace
db proc_right

	proc_left:
		inc di
		ret

	fin:
		int 0x20

	proc_lbrace:
		pop bx
			push si
			test dl, dl
			jnz main_loop

			pop si
			dec si
			find_bracket:
				lodsb
				cmp al, 0x50
				jng find_bracket
					adc cl, al
					sub cl, 0x5c
				jnz find_bracket
		jmp bx

	proc_rbrace:
		pop bx
			pop si
			dec si
		jmp bx

db 0

code:
	db "+[<.]+[,.]", 0

