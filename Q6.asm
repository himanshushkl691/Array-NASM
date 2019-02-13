%include 'function.asm'

section .data
msg1:db	'Enter array size: ',0h
msg2:db	'Enter array element',0h
msg3:db	'Sorted array: ',0h
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
	xor eax,eax	;i = 0
	BUBBLE_SORT:
		cmp eax,[size]
		je END_BUBBLE
		xor ebx,ebx	;j = 0
		mov edi,[size]
		dec edi
			SECOND_LOOP:
				cmp ebx,edi
				jnl continue
				mov ecx,dword[esi + 4 * ebx]	;tmp = arr[j]
				push edi
				mov edi,ebx
				inc edi
				cmp ecx,dword[esi + 4 * edi];if arr[j]>arr[j+1]
				jng continue_inner
				swap:
					mov edx,dword[esi + 4 * edi];tmp1 = arr[j+1]
					mov dword[esi + 4 * ebx],edx	;arr[j] = tmp1
					mov dword[esi + 4 * edi],ecx;arr[j+1] = tmp
				continue_inner:
				inc ebx
				pop edi
				jmp SECOND_LOOP
		continue:
		inc eax
		jmp BUBBLE_SORT
	END_BUBBLE:
		mov eax,msg3
		call sprintf
		
		mov esi,arr
		mov ecx,[size]
		call printArray
		call breakline

		call quit
