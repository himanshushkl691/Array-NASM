%include 'function.asm'

section .data
msg1:db	'Enter array A size: ',0h
msg2:db	'Enter array A element',0h
msg3:db	'Common elements',0h
msg4:db	'Enter array B element',0h
msg5:db	'Enter array B size: ',0h
A:	TIMES 100 dd 0
B:	TIMES 100 dd 0
cnt:	TIMES 100 dd 0

section .bss
n2:	resb	10
l2:	resb	10
sizeA:	resb	10
n3:	resb	10
l3:	resb	10
sizeB:	resb	10

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
	mov [sizeA],eax

	mov eax, msg2
	call sprintfLF
	
	mov esi,A
	mov ecx,[sizeA]
	call readArray
	
	mov eax,msg5
	call sprintf
	
	mov eax, 3
	mov ebx, 0
	mov ecx,n3
	mov edx, l2
	call sys

	mov esi,n3
	call atoi
	mov [sizeB],eax
	
	mov eax,msg4
	call sprintfLF

	mov esi,B
	mov ecx,[sizeB]
	call readArray
	
	mov edx,cnt
	mov esi,A
	xor edi,edi
	FOR_A:
		cmp edi,[sizeA]
		je EXIT_FORA
		mov eax,dword[esi + 4 * edi]
		cmp dword[edx + 4 * eax],0
		jne continue
		inc dword[edx + 4 * eax]
		continue:
		inc edi
		jmp FOR_A
	EXIT_FORA:
		mov edx,cnt
		mov esi,B
		xor edi,edi
		FOR_B:
			cmp edi,[sizeB]
			je EXIT_FORB
			mov eax,dword[esi + 4 * edi]
			cmp dword[edx + 4 * eax],1
			jne con
			inc dword[edx + 4 * eax]
			con:
			inc edi
			jmp FOR_B
		EXIT_FORB:
			mov esi,cnt
			xor edi,edi
			print_common:
				cmp edi,100
				je exit_main
				cmp dword[esi + 4 * edi],2
				jne cont
				mov eax,edi
				call iprintf
				call space
				cont:
				inc edi
				jmp print_common
			exit_main:
				call breakline
				call quit
