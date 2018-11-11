# Assume your Howard ID as a decimal integer is X. Let N = 27 + (X % 10) where % is the modulo operation, and M = N – 10. 
# You will write a MIPS program that reads a string of up to 4 characters from user input.
.data
	char_array: .space 1000
	
	#Invalid Messages
	not_valid: .asciiz "Invalid base-31 number."
	empty: .asciiz "Input is empty."
	too_long: .asciiz "Input is too long."
.text
.globl main

main:
	
	#getting input from user
	li $v0, 8  
    	la $a0, max_input
    	li $a1, 1000
    	syscall
	
	add $t1, $0, 0 #initializes $t1 to zero (stores character)
	add $t4, $0, 0 #Permenanatly stores the first char of the string
	add $t3, $0, $0 #initializes $t3 to zero (counter)
	
	#checking is string empty before continuation
	la $t2, char_array #stores string address into register
	lb $t1,0($t2) #loads first index of string
	li $t0, 10 #10 is the ascii value of new line
	beq $t1, $t0 invalid_empty #looks for new_line character at first index: checking if input is empty
