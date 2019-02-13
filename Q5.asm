%include 'function.asm'

section .data
msg1:db	'Enter array size: ',0h
msg2:db	'Enter array element',0h
msg3:db	'Element having highest frequency: ',0h
msg4:db	'Element having lowest frequency: ',0h
arr:	TIMES 100 dd 0
cnt:	TIMES 100 dd 0

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

	mov eax,msg2
	call sprintfLF

	mov esi,n2
	call atosigned
	mov [size],eax
	
	mov esi,arr
	mov ecx,[size]
	call readArray
	mov edx,cnt

	xor edi,edi	;i = 0
	SOLVE:
		cmp edi,[size]
		je END_SOLVE
		xor eax,eax
		mov eax,dword[esi + 4 * edi]
		inc dword[edx + 4 * eax]
		inc edi
		jmp SOLVE
	END_SOLVE:
		xor eax,eax	;mx = 0
		xor ebx,ebx	;mn = INF
		mov esi,0
		mov ecx,10000
		xor edi,edi
		find:
			cmp edi,100
			je end_find
			cmp dword[edx + 4 * edi],esi
			ja getit
			jna continue
			getit:
				mov esi,dword[edx + 4 * edi]
				mov eax,edi
			continue:
				cmp dword[edx + 4 * edi],0
				je more_continue
				cmp dword[edx + 4 * edi],ecx
				jl get_less
				jnl more_continue
				get_less:
					mov ecx,dword[edx + 4 * edi]
					mov ebx,edi
				more_continue:
				inc edi
				jmp find
		end_find:
			push eax
			mov eax,msg3
			call sprintf
			pop eax
			call iprintf
			call breakline
	
			mov eax,msg4
			call sprintf
			mov eax,ebx
			call iprintf
			call breakline
		
			call quit
