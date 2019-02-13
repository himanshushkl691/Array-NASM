%include 'function.asm'

section .data
msg1:db	'Enter size of array: ',0h
msg2:db	'Enter elements of array: ',0h
msg3:db	'Numbers divisible by 7 in array: ',0h
msg4:db	'No multiples',0h
arr:	TIMES 100 dd 0

section .bss
n2:	resb	10
l2:	resb	10
size:	resb	10

section .text
global _start
_start:
	mov eax,msg1
	call sprintf
	
	mov eax, 3
	mov ebx, 0
	mov ecx, n2
	mov edx, l2
	call sys
	
	mov esi,n2
	call atoi
	mov [size],eax

	mov esi,arr
	mov ecx,[size]
	call readArray

	mov ebx,7	;ebx = 7
	xor ecx,ecx
	xor edi,edi
	SOLVE:
		cmp ecx,[size]
		je END_SOLVE
		mov eax,dword[esi + 4 * ecx]
		call isDivisible
		cmp edx,1
		je print_int
		jne continue
		print_int:
			mov eax,dword[esi + 4 * ecx]
			call iprintf
			call space
			inc edi
			jmp continue
		continue:
		inc ecx
		jmp SOLVE
	END_SOLVE:
		cmp edi,0
		jne LF
		mov eax,msg4
		call sprintf
		LF:
		call breakline
		call quit	;return 0;
