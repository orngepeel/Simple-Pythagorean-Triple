TITLE Program Template     (template.asm)

; Author: Devon Braner
; Last Modified:
; OSU email address: branerd@oregonstate.edu
; Course number/section:   CS271 Section 400
; Project Number: Project 1        Due Date: 1/24/2022
; Description: Displays name, program title, and instructions for user. Prompts user to enter 3 numbers in descending order,
;				calculates and displays sum & differences. Displays a closing message.

INCLUDE Irvine32.inc

; (insert macro definitions here)

; (insert constant definitions here)

.data

	intro			BYTE	"Basic Logic and Arithmetic Program		by Devon Braner",0
	instructions	BYTE	"Please enter 3 numbers. They must be in descending order.",0
	
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


.code
main PROC

	; Introduce program and display instructions


	; Get numbers from user


	; EXTRA CREDIT: check if numbers are not in descending order


	; Calculate sums


	; Calculate differences


	; EXTRA CREDIT: handle negative results


	; EXTRA CREDIT: calculate quotients (with remainders)


	; Display results


	; Say goodbye

	Invoke ExitProcess,0	; exit to operating system
main ENDP

END main
