%include 'function.asm'

section .data
msg1:db	'Enter array size: ',0h
msg2:db	'Enter array element',0h
msg3:db	'NOT FOUND',0h
msg4:db	'FOUND AT ',0h
msg5:db	'Enter to search for: ',0h
arr:	TIMES 100 dd 0

section .bss
n2:	resb	10
l2:	resb	10
n3:	resb	10
l3:	resb	10
size:	resb	10
key:	resb	10
l:	resb	10
r:	resb	10
mid:	resb	10

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
	
	mov esi,arr
	mov ecx,[size]
	call readArray
	
	mov eax,msg5
	call sprintf
	
	mov eax, 3	
	mov ebx, 0
	mov ecx, n3
	mov edx, l3
	call sys

	mov esi,n3
	call atoi
	mov [key],eax

	mov esi,arr
	xor edi,edi
	mov eax,[size]
	mov [l],edi	;l = 0
	mov [r],eax	;r = size
	BINARY_SEARCH:
		mov eax,[l]
		mov ebx,[r]
		sub ebx,eax
		cmp ebx,1
		jna EXIT_BS
		xor edx,edx
		mov eax,[l]
		mov ebx,[r]
		add eax,ebx
		mov ecx,2
		idiv ecx
		mov [mid],eax	;mid = (l + r)/2
		mov edx,[key]
		cmp dword[esi + 4 * eax],edx
		ja r_to_mid
		jna l_to_mid
		r_to_mid:
			mov [r],eax
			jmp continue
		l_to_mid:
			mov [l],eax
		continue:
		jmp BINARY_SEARCH
	EXIT_BS:
		mov edx,[key]
		mov eax,[l]
		cmp dword[esi + 4 * eax],edx
		je FOUND
		mov eax,msg3
		call sprintfLF
		jmp EXIT_MAIN
		FOUND:
			mov eax,msg4
			call sprintf
			mov eax,[l]
			call iprintf
			call breakline
	EXIT_MAIN:
		call quit
