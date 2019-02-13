%include 'function.asm'

section .data
msg1:db	'Enter array size: ',0h
msg2:db	'Enter array element: ',0h
msg3:db 'Prime Numbers',0h
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

	mov eax,msg3
	call sprintfLF

	xor edi,edi
	prime_print:
		cmp edi,[size]
		je exit_prime_print
		push esi
		mov eax,dword[esi + 4 * edi]
		call isPrime	;esi = isPrime(eax)
		cmp esi,1
		jne continue
		call iprintf
		call space
		continue:
		pop esi
		inc edi
		jmp prime_print
	exit_prime_print:
		call breakline
		call quit
