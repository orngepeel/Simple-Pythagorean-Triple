TITLE Program Template     (template.asm)

; Author: Devon Braner
; Last Modified: 1/23/2022
; OSU email address: branerd@oregonstate.edu
; Course number/section:   CS271 Section 400
; Project Number: Project 1        Due Date: 1/24/2022
; Description: Displays name, program title, and instructions for user. Prompts user to enter 3 numbers in descending order,
;				calculates and displays sum & differences & quotients. Displays a closing message. Allows user to continue so long as they want.

INCLUDE Irvine32.inc

.data

	; intro and instructions:
	intro			BYTE	"Basic Logic and Arithmetic Program		by Devon Braner",0
	instructions	BYTE	"Please enter 3 numbers. They must be in descending order: A > B > C. The program will calculate their sums and differences.",0

	; EXTRA CREDIT details:
	ec1_description	BYTE	"**EC: Repeat until the user chooses to quit.",0
	ec2_description	BYTE	"**EC: Verify descending order.",0
	ec3_description	BYTE	"**EC: Computes B-A, C-A, C-B, C-B-A. Handles negative results.",0
	ec4_description	BYTE	"**EC: Calculates and displays A/B, A/C, B/C. Prints Quotient and Remainder.",0
	ec2_bad_value	BYTE	"The number you entered is not less than the previous number...",0
	
	; prompts and variables for user input:
	prompt_1		BYTE	"First Number: ",0
	num_A			DWORD	?
	prompt_2		BYTE	"Second Number: ",0
	num_B			DWORD	?
	prompt_3		BYTE	"Third Number: ",0
	num_C			DWORD	?
	
	; values to be calculated:
	AB_sum			DWORD	?
	AB_difference	DWORD	?
	AC_sum			DWORD	?
	AC_difference	DWORD	?
	BC_sum			DWORD	?
	BC_difference	DWORD	?
	ABC_sum			DWORD	?

	; for results display:
	plus			BYTE	" + ",0
	minus			BYTE	" - ",0
	equals			BYTE	" = ",0

	; EXTRA CREDIT for results display:
	divided_by		BYTE	" / ",0
	remainder		BYTE	" with remainder: ",0

	; EXTRA CREDIT values to be calculated
	BA_difference	SDWORD	?
	CA_difference	SDWORD	?
	CB_difference	SDWORD	?
	CBA_difference	SDWORD	?
	
	AB_quotient		DWORD	?
	AB_remainder	DWORD	?
	AC_quotient		DWORD	?
	AC_remainder	DWORD	?
	BC_quotient		DWORD	?
	BC_remainder	DWORD	?

	; Closing message
	goodbye			BYTE	"Thanks for using this program! Bye...",0
	EC_goodbye		BYTE	"... But if you would like to continue, press 1 then Enter. If you're done, simply press Enter.",0
	continue_prompt	DWORD	?

.code
main PROC

	_start:
	; Introduce program and display instructions
	MOV		EDX, OFFSET intro
	CALL	WriteString
	CALL	CrLf

	MOV		EDX, OFFSET ec1_description
	CALL	WriteString
	CALL	CrLf

	MOV		EDX, OFFSET ec2_description
	CALL	WriteString
	CALL	CrLf

	MOV		EDX, OFFSET ec3_description
	CALL	WriteString
	CALL	CrLf

	MOV		EDX, OFFSET ec4_description
	CALL	WriteString
	CALL	CrLf

	MOV		EDX, OFFSET instructions
	CALL	WriteString
	CALL	CrLf

	; Get numbers from user and EXTRA CREDIT: check that they are in descending order
	MOV		EDX, OFFSET prompt_1
	CALL	WriteString
	CALL	ReadDec
	MOV		num_A, EAX

	MOV		EDX, OFFSET prompt_2
	CALL	WriteString
	CALL	ReadDec
	MOV		num_B, EAX

	MOV		EAX, num_A
	CMP		EAX, num_B
	JNA		_not_descending
	JMP		_continue

	_continue:
	MOV		EDX, OFFSET prompt_3
	CALL	WriteString
	CALL	ReadDec
	MOV		num_C, EAX
	CALL	CrLf

	MOV		EAX, num_B
	CMP		EAX, num_C
	JNA		_not_descending
	JMP		_calculations

	; call out not descending numbers.
	_not_descending:
	MOV		EDX, OFFSET ec2_bad_value
	CALL	WriteString
	CALL	CrLf
	JMP		_sign_off

	_calculations:
	; Calculate sums
	MOV		EAX, num_A
	MOV		EBX, num_B
	ADD		EAX, EBX
	MOV		AB_sum, EAX

	MOV		EAX, num_A
	MOV		EBX, num_C
	ADD		EAX, EBX
	MOV		AC_sum, EAX

	MOV		EAX, num_B
	MOV		EBX, num_C
	ADD		EAX, EBX
	MOV		BC_sum, EAX

	MOV		EAX, AB_sum
	MOV		EBX, num_C
	ADD		EAX, EBX
	MOV		ABC_sum, EAX

	; Calculate differences
	MOV		EAX, num_A
	MOV		EBX, num_B
	SUB		EAX, EBX
	MOV		AB_difference, EAX

	MOV		EAX, num_A
	MOV		EBX, num_C
	SUB		EAX, EBX
	MOV		AC_difference, EAX

	MOV		EAX, num_B
	MOV		EBX, num_C
	SUB		EAX, EBX
	MOV		BC_difference, EAX

	; EXTRA CREDIT: handle negative results, calculate B-A, C-A, C-B, C-B-A
	MOV		EAX, num_B
	MOV		EBX, num_A
	SUB		EAX, EBX
	MOV		BA_difference, EAX

	MOV		EAX, num_C
	MOV		EBX, num_A
	SUB		EAX, EBX
	MOV		CA_difference, EAX

	MOV		EAX, num_C
	MOV		EBX, num_B
	SUB		EAX, EBX
	MOV		CB_difference, EAX

	MOV		EAX, CB_difference
	MOV		EBX, num_A
	SUB		EAX, EBX
	MOV		CBA_difference, EAX

	; EXTRA CREDIT: calculate quotients (with remainders)
	MOV		EAX, num_A
	MOV		EDX, 0
	MOV		EBX, num_B
	DIV		EBX
	MOV		AB_quotient, EAX
	MOV		AB_remainder, EDX

	MOV		EAX, num_A
	MOV		EDX, 0
	MOV		EBX, num_C
	DIV		EBX
	MOV		AC_quotient, EAX
	MOV		AC_remainder, EDX

	MOV		EAX, num_B
	MOV		EDX, 0
	MOV		EBX, num_C
	DIV		EBX
	MOV		BC_quotient, EAX
	MOV		BC_remainder, EDX

	; Display results:
	; Required results:
	MOV		EAX, num_A
	CALL	WriteDec
	MOV		EDX, OFFSET plus
	CALL	WriteString
	MOV		EAX, num_B
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, AB_sum
	CALL	WriteDec
	CALL	CrLf

	MOV		EAX, num_A
	CALL	WriteDec
	MOV		EDX, OFFSET minus
	CALL	WriteString
	MOV		EAX, num_B
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, AB_difference
	CALL	WriteDec
	CALL	CrLf

	MOV		EAX, num_A
	CALL	WriteDec
	MOV		EDX, OFFSET plus
	CALL	WriteString
	MOV		EAX, num_C
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, AC_sum
	CALL	WriteDec
	CALL	CrLf

	MOV		EAX, num_A
	CALL	WriteDec
	MOV		EDX, OFFSET minus
	CALL	WriteString
	MOV		EAX, num_C
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, AC_difference
	CALL	WriteDec
	CALL	CrLf

	MOV		EAX, num_B
	CALL	WriteDec
	MOV		EDX, OFFSET plus
	CALL	WriteString
	MOV		EAX, num_C
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, BC_sum
	CALL	WriteDec
	CALL	CrLf

	MOV		EAX, num_B
	CALL	WriteDec
	MOV		EDX, OFFSET minus
	CALL	WriteString
	MOV		EAX, num_C
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, BC_difference
	CALL	WriteDec
	CALL	CrLf

	MOV		EAX, num_A
	CALL	WriteDec
	MOV		EDX, OFFSET plus
	CALL	WriteString
	MOV		EAX, num_B
	CALL	WriteDec
	CALL	WriteString		; plus already OFFSET
	MOV		EAX, num_C
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, ABC_sum
	CALL	WriteDec
	CALL	CrLf
	CALL	CrLf

	; Extra credit difference results: 
	MOV		EAX, num_B
	CALL	WriteDec
	MOV		EDX, OFFSET minus
	CALL	WriteString
	MOV		EAX, num_A
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, BA_difference
	CALL	WriteInt
	CALL	CrLf

	MOV		EAX, num_C
	CALL	WriteDec
	MOV		EDX, OFFSET minus
	CALL	WriteString
	MOV		EAX, num_A
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, CA_difference
	CALL	WriteInt
	CALL	CrLf

	MOV		EAX, num_C
	CALL	WriteDec
	MOV		EDX, OFFSET minus
	CALL	WriteString
	MOV		EAX, num_B
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, CB_difference
	CALL	WriteInt
	CALL	CrLf

	MOV		EAX, num_C
	CALL	WriteDec
	MOV		EDX, OFFSET minus
	CALL	WriteString
	MOV		EAX, num_B
	CALL	WriteDec
	CALL	WriteString		; minus already OFFSET
	MOV		EAX, num_A
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, CBA_difference
	CALL	WriteInt
	CALL	CrLf
	CALL	CrLf

	; Extra credit quotient/remainder results:
	MOV		EAX, num_A
	CALL	WriteDec
	MOV		EDX, OFFSET divided_by
	CALL	WriteString
	MOV		EAX, num_B
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, AB_quotient
	CALL	WriteDec
	MOV		EDX, OFFSET remainder
	CALL	WriteString
	MOV		EAX, AB_remainder
	CALL	WriteDec
	CALL	CrLf

	MOV		EAX, num_A
	CALL	WriteDec
	MOV		EDX, OFFSET divided_by
	CALL	WriteString
	MOV		EAX, num_C
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, AC_quotient
	CALL	WriteDec
	MOV		EDX, OFFSET remainder
	CALL	WriteString
	MOV		EAX, AC_remainder
	CALL	WriteDec
	CALL	CrLf

	MOV		EAX, num_B
	CALL	WriteDec
	MOV		EDX, OFFSET divided_by
	CALL	WriteString
	MOV		EAX, num_C
	CALL	WriteDec
	MOV		EDX, OFFSET equals
	CALL	WriteString
	MOV		EAX, BC_quotient
	CALL	WriteDec
	MOV		EDX, OFFSET remainder
	CALL	WriteString
	MOV		EAX, BC_remainder
	CALL	WriteDec
	CALL	CrLf
	CALL	CrLf

	_sign_off:
	; Say goodbye
	MOV		EDX, OFFSET goodbye
	CALL	WriteString
	CALL	CrLf

	; Extra Credit continue...
	MOV		EDX, OFFSET EC_goodbye
	CALL	WriteString
	CALL	ReadDec
	MOV		continue_prompt, EAX
	CALL	CrLf
	CMP		continue_prompt, 1
	JE		_start


	Invoke ExitProcess,0	; exit to operating system
main ENDP

END main
