%include 'function.asm'

section .data
msg1:db	'Enter size of array: ',0h
msg2:db	'Enter elements of array',0h
msg3:db	'Enter k: ',0h
msg4:db	'Numbers greater than k: ',0h
msg5:db	'Numbers less than k: ',0h
msg6:db	'Numbers equal to k: ',0h
arr:	TIMES 100 dd	0
section .bss
n:	resb	100
l_n:	resb	100
size:	resb	10
n2:	resb	10
l2:	resb	10
k:	resb	10
section .text
global _start
_start:
	mov eax,msg1
	call sprintf
	
	mov eax, 3
	mov ebx, 0
	mov ecx, n
	mov edx, l_n
	call sys
	
	mov esi,n
	call atosigned
	mov [size],eax
	
	mov eax,msg2
	call sprintfLF
	
	mov esi,arr
	mov ecx,[size]
	call readArray

	mov eax,msg3
	call sprintf
	
	mov eax, 3
	mov ebx, 0
	mov ecx, n2
	mov edx, l2
	call sys

	mov esi,n2
	call atosigned
	mov [k],eax

	mov esi,arr
	mov ecx,[size]
	call printArray
	call breakline
	xor ebx,ebx	;i = 0
	xor ecx,ecx	;A = 0
	xor edx,edx	;B = 0
	xor edi,edi	;C = 0
	SOLVE:
		cmp ebx,[size]
		je END_SOLVE
		cmp dword[esi + 4 * ebx],eax
		je incr_C
		jl incr_B
		jg incr_A
		incr_C:
			inc edi
			jmp continue
		incr_B:
			inc edx
			jmp continue
		incr_A:
			inc ecx
			jmp continue
		continue:
			inc ebx
			jmp SOLVE
	END_SOLVE:
		mov eax,msg4
		call sprintf
		mov eax,ecx
		call iprintf
		call breakline
		
		mov eax,msg5
		call sprintf
		mov eax,edx
		call iprintf
		call breakline

		mov eax,msg6
		call sprintf
		mov eax,edi
		call iprintf
		call breakline
		
		call quit
