%include 'function.asm'

section .data
msg1:db	'Enter size of array: ',0h
msg2:db	'Enter array elements',0h
msg3:db	'Second largest element is: ',0h
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
	mov ecx,n2
	mov edx,l2
	call sys

	mov esi,n2
	call atosigned
	mov [size],eax
	
	mov eax,msg2
	call sprintfLF

	mov esi,arr
	mov ecx,[size]
	call readArray

	;call printArray
	;call breakline

	xor ecx,ecx	;stores max element
	xor edi,edi	;i = 0
	mov eax,dword[esi]
	findMax:
		cmp edi,[size]
		je FOUND_MAX
		push ebx
		mov ebx,dword[esi + 4 * edi]
		call max
		mov eax,ecx
		pop ebx
		inc edi
		jmp findMax
	FOUND_MAX:
		;ecx contain maximum element
		xor edi,edi
		mov ecx,eax
		mov eax,-10000
		findSecondMax:
			cmp edi,[size]
			je exitSOLVE
			cmp dword[esi + 4 * edi],ecx
			jnl ge
			lt:
				push ebx
				push ecx
				mov ebx,dword[esi + 4 * edi]
				call max
				mov eax,ecx
				pop ecx
				pop ebx
			ge:
			inc edi
			jmp findSecondMax
		exitSOLVE:
			push eax
			mov eax,msg3
			call sprintf
			pop eax
			call iprintf
			call breakline
			call quit
