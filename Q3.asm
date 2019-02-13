%include 'function.asm'

section .data
msg1:db	'Enter array elements',0h
arr:	TIMES 100 db	0
section .bss
n2:	resb	10
l2:	resb	10

section .text
global _start
_start:
	mov eax,msg1
	call sprintfLF
	
	mov esi,arr
	mov ecx,10
	call readArray
	
	mov eax,dword[esi];
	mov edx,dword[esi];
	xor ecx,ecx
	SOLVE:
		cmp ecx,10
		je EXIT_SOLVE
		mov ebx,dword[esi + 4 * ecx]
		
		push ecx
		call max
		mov eax,ecx
		pop ecx
		
		push ecx
		push eax
		mov eax,edx
		call min
		mov edx,ecx
		pop eax
		pop ecx
		
		inc ecx
		jmp SOLVE
	EXIT_SOLVE:
		sub eax,edx
		call iprintf
		call breakline
		call quit
