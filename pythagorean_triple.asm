TITLE Pythagorean Triple     (pythagorean_triple.asm)

; Author: Devon Braner
; Last Modified: 6/29/2022
; Description: A simple program that uses the pythagorean theorem to calculate
;				the third value in a Pythagorean Triple given two numbers input
;				by the user.

INCLUDE Irvine32.inc

;--------------------------------------------------------------------------------------------------------------------------------
; Name: mDisplayString
; 
; Print a string stored in a specific memory location 
; 
; Preconditions: None
; 
; Receives: string_param, memory OFFSET of a string.
; 
; returns: Prints string_param to the console.
;--------------------------------------------------------------------------------------------------------------------------------
mDisplayString MACRO string_param
	PUSH	EDX

	MOV		EDX, string_param
	CALL	WriteString

	POP		EDX
ENDM

.data
	; variables
	dec_a			DWORD	?
	dec_b			DWORD	?
	dec_c			DWORD	?

	; squared variables
	a_squared		DWORD	?
	b_squared		DWORD	?
	c_squared		DWORD	?

	; strings
	title_disp		BYTE	"Simple Pythagorean Triple Program			By Devon Braner",13,10,13,10,0
	introduction	BYTE	"Welcome! You will be prompted to enter two positive integer.",13,10,
							"The program will then use the Pythagorean Theorem to find the third value in the Pythagorean Triple.",13,10,13,10,
							"Disclaimer: This program does not currently perform validation, and doesn't accurately calculate c unless it is a",13,10,
							"positive integer.",13,10,13,10,0
	input_prompt	BYTE	"Enter a positive integer: ",0
	result			BYTE	"Given your two inputs, the third value in the Pythagorean Triple is: ",0
	

.code
main PROC
	; Introduce the program
	mDisplayString OFFSET title_disp
	mDisplayString OFFSET introduction

;---------------------------------------------------
; Get input from the user.
; These will be a and b in the pythagorean theorem.
;---------------------------------------------------
	PUSH	OFFSET dec_a
	PUSH	OFFSET input_prompt
	CALL	getDec

	PUSH	OFFSET dec_b
	PUSH	OFFSET input_prompt
	CALL	getDec
	
;----------------------------------------------------
; Now that we have the input, we need to calculate c
; Pythagorean Theorem: a^2 + b^2 = c^2
;----------------------------------------------------
	
	; First calculate a^2
	PUSH	dec_a
	PUSH	OFFSET a_squared
	CALL	squareVar

	; Then calculate b^2
	PUSH	dec_b
	PUSH	OFFSET b_squared
	CALL	squareVar

	; a_squared + b_squared
	PUSH	a_squared
	PUSH	b_squared
	PUSH	OFFSET c_squared
	CALL	sumVar

	; Now we have c^2, so wee need to get the square root of c
	FILD	c_squared
	FSQRT
	FISTP	dec_c

	; Display results
	PUSH	dec_c
	PUSH	OFFSET result
	CALL	dispResult

Invoke ExitProcess,0	; exit to operating system
main ENDP

;--------------------------------------------------------------------------------------------------------------------------------
; Name: getDec
; Gets user input of a decimal number.
;
; Preconditions: None.
;
; Postconditions: None.
;
; Receives: 
;			[EBP+20] = Prompt String
;			[EBP+24] = Memory OFFSET to store user input
;
; Returns: EAX, EBX, EDX, EBP are restored. 
;			[EBP+24] holds the input value.
;--------------------------------------------------------------------------------------------------------------------------------
getDec PROC USES EAX EDX EBX
	PUSH	EBP
	MOV		EBP, ESP

	mDisplayString [EBP + 20]
	CALL	readDec
	MOV		EBX, [EBP + 24]
	MOV		[EBX], EAX
	CALL	CrLf

	POP		EBP
	RET		8
getDec ENDP

;--------------------------------------------------------------------------------------------------------------------------------
; Name: squareVar
; Squares a number.
;
; Preconditions: None.
;
; Postconditions: None.
;
; Receives: 
;			[EBP+16] = The memory address to store the squared value.
;			[EBP+20] = The value to square.
;
; Returns: EAX, EBX, EBP are restored. 
;			[EBP+16] holds the squared value.
;--------------------------------------------------------------------------------------------------------------------------------
squareVar PROC USES EAX EBX
	PUSH	EBP
	MOV		EBP, ESP

	MOV		EDX, 0
	MOV		EAX, [EBP + 20]
	MOV		EBX, [EBP + 20]
	MUL		EBX
	MOV		EBX, [EBP + 16]
	MOV		[EBX], EAX

	POP		EBP
	RET		8
squareVar ENDP

;--------------------------------------------------------------------------------------------------------------------------------
; Name: sumVar
; Sums two numbers.
;
; Preconditions: None.
;
; Postconditions: None.
;
; Receives: 
;			[EBP+16] = The memory address to store the sum value.
;			[EBP+20] = The second value to sum.
;			[EBP+24] = The first value to sum.
;
; Returns: EAX, EBX, EDX, EBP are restored. 
;			[EBP+16] holds the squared value.
;--------------------------------------------------------------------------------------------------------------------------------
sumVar PROC USES EAX EBX
	PUSH	EBP
	MOV		EBP, ESP

	MOV		EAX, [EBP + 24]
	MOV		EBX, [EBP + 20]
	ADD		EAX, EBX
	MOV		EDX, [EBP + 16]
	MOV		[EDX], EAX

	POP		EBP
	RET		12
sumVar ENDP

;--------------------------------------------------------------------------------------------------------------------------------
; Name: dispResult
; Gets user input of a decimal number.
;
; Preconditions: None.
;
; Postconditions: None.
;
; Receives: 
;			[EBP+16] = Result String
;			[EBP+20] = Value of result
;
; Returns: EAX, EDX, EBP are restored. 
;			The results are printed.
;--------------------------------------------------------------------------------------------------------------------------------
dispResult PROC USES EAX EDX
	PUSH	EBP
	MOV		EBP, ESP

	mDisplayString [EBP + 16]
	MOV		EAX, [EBP + 20]
	CALL	writeDec
	CALL	CrLf

	POP		EBP
	RET		8
dispResult ENDP


END main
