%include 'function.asm'

section .data
msg1:db	'Enter array size: ',0h
msg2:db	'Enter A array element',0h
msg3:db	'Enter B array element',0h
msg4:db	'C array is',0h
A:	TIMES 100 dd 0
B:	TIMES 100 dd 0
C:	TIMES 100 dd 0

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

	mov eax,msg2
	call sprintfLF

	mov esi,A
	mov ecx,[size]
	call readArray

	mov eax,msg3
	call sprintfLF
	
	mov esi,B
	mov ecx,[size]
	call readArray

	mov esi,A
	mov edx,B
	mov ecx,C
	xor edi,edi	;i = 0
	SOLVE:
		cmp edi,[size]
		je END_SOLVE
		mov eax,dword[esi + 4 * edi]	;tmp0 = A[i]
		mov ebx,dword[edx + 4 * edi]	;tmp1 = B[i]
		cmp eax,ebx
		ja first			;if A[i] > B[i]
		jna second
		first:
			mov dword[ecx + 4 * edi],eax
			jmp continue
		second:
			mov dword[ecx + 4 * edi],ebx
		continue:
		inc edi
		jmp SOLVE
	END_SOLVE:
		mov eax,msg4
		call sprintfLF
		mov esi,C
		mov ecx,[size]
		call printArray
		call breakline
		call quit
