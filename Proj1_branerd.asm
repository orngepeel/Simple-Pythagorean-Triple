TITLE Program Template     (template.asm)

; Author: Devon Braner
; Last Modified:
; OSU email address: branerd@oregonstate.edu
; Course number/section:   CS271 Section 400
; Project Number: Project 1        Due Date: 1/24/2022
; Description: Displays name, program title, and instructions for user. Prompts user to enter 3 numbers in descending order,
;				calculates and displays sum & differences. Displays a closing message.

INCLUDE Irvine32.inc

.data

	intro			BYTE	"Basic Logic and Arithmetic Program		by Devon Braner",0
	instructions	BYTE	"Please enter 3 numbers. They must be in descending order: A > B > C. The program will calculate their sums and differences.",0
	
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
	ec1_description	BYTE	"**EC: Repeat until the user chooses to quit.",0
	ec2_description	BYTE	"**EC: Verify descending order.",0
	ec3_description	BYTE	"**EC: Computes B-A, C-A, C-B, C-B-A. Handles negative results.",0
	ec4_description	BYTE	"**EC: Calculates and displays A/B, A/C, B/C. Prints Quotient and Remainder.",0
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
	goodbye			BYTE	"Thanks for using this program! Bye.",0


.code
main PROC

	; Introduce program and display instructions
	MOV		EDX, OFFSET intro
	CALL	WriteString
	CALL	CrLf

	MOV		EDX, OFFSET instructions
	CALL	WriteString
	CALL	CrLf

	; Get numbers from user
	MOV		EDX, OFFSET prompt_1
	CALL	WriteString
	CALL	ReadDec
	MOV		num_A, EAX

	MOV		EDX, OFFSET prompt_2
	CALL	WriteString
	CALL	ReadDec
	MOV		num_B, EAX

	MOV		EDX, OFFSET prompt_3
	CALL	WriteString
	CALL	ReadDec
	MOV		num_C, EAX
	CALL	CrLf

	; EXTRA CREDIT: check if numbers are not in descending order


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

	; EXTRA CREDIT: handle negative results


	; EXTRA CREDIT: calculate quotients (with remainders)


	; Display results
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
	MOV		EAX, BC_sum
	CALL	WriteDec
	CALL	CrLf
	CALL	CrLf

	; Say goodbye
	MOV		EDX, OFFSET goodbye
	CALL	WriteString
	Call	CrLf

	Invoke ExitProcess,0	; exit to operating system
main ENDP

END main
