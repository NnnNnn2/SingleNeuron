.686
.model flat
public _single_neuron

.data
	result dd 0.0

.code
_single_neuron PROC
	push ebp
	mov ebp, esp

	push ebx
	push esi

	mov ebx, [ebp + 8]				; X array
	mov esi, [ebp + 12]				; w array
	mov ecx, [ebp + 16]				; n

	finit

	fld DWORD PTR [esi]				; storing w0
	;dec ecx

	jecxz end_func

	;loop to calculate X1 * w1 + X2 * w2 + ... + Xn * wn
	calc_loop:
		
		mov eax, 8					; X elements are 8 bytes each
		mul ecx
		add eax, ebx
		sub eax, 8
		fld QWORD PTR [eax]			; storing X[ecx]

		mov eax, 4					; w elements are 4 bytes each
		mul ecx
		;add eax, 4
		add eax, esi
		fld DWORD PTR [eax]			; storing w[ecx+1]

		fmulp						; X[ecx] * w[ecx+1]
		faddp						; result += multuplication result

	loop calc_loop


	end_func:
		fcom DWORD PTR result
		fstsw ax
		sahf
		jnb above_zero
			mov result, DWORD PTR 0	; when result < 0 result = 0
			jmp below_zero

		above_zero:
			fst DWORD PTR result
			lea eax, result

		below_zero:
			pop esi
			pop ebx
			pop ebp
			ret

_single_neuron ENDP

END