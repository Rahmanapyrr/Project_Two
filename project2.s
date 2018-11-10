# Assume your Howard ID as a decimal integer is X. Let N = 27 + (X % 10) where % is the modulo operation, and M = N – 10. 
# You will write a MIPS program that reads a string of up to 4 characters from user input.


.data
	max_input: .space 1000
	valid_space: .space 4
	not_valid: .asciiz "\nInvalid base-N number."
	empty: .asciiz "\nInput is empty."
	too_long: .asciiz "\nInput is too long."
.text

main:
	
	#getting input from user
	li $v0, 8  
    	la $a0, max_input
    	li $a1, 1000
    	syscall
