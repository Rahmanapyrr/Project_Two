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
	
	addi $t5, $0, 1 # $t5 = $pow_reg Initialized to 1.
	addi $t6, $0, 0 # $t6 = $sum_reg. Initialized to 0
	addi $t7, $0, 0 # contents of $t6 will be moved to t7
	addi $s0, $0, 31 # s0 contains the multiplicand increment, the base 31
	
	find_length:
		lb $t1,0($t2) #loads index of string
		beq $t1,0, Convert #checks for null, then branches to Exits
		beq $t1, 10, Convert #looks for new line character, then branches to Exits
		#We already established that we're not at the end of the list, so if the counter is greater than 4 at this point, the string is too long. 
		beq $t3, 5, invalid_length #Stops the program when it realizes the input is too long
		addi $t2, $t2, 1 #points to next character in string
		beq $t1, 32, find_length  # to skip spaces
		addi $t3, $t3, 1 #counter increments
		j find_length #jumps to continues loop
		
	Convert:
		addi $t2, $t2, -1
		lb $t1, ($t2)
		addi $t3, $t3, -1 #decrement the length
		j check_string
	
	Loop:
		mult $t1, $t5 #multiplying the current char of the string times a power of 31
		mflo $t6 		#moving the product
		add $t7, $t7, $t6 #adding the product to the total sum
		mult $t5, $s0 #multiplying the power regester times 31, to get to the next power of 31
		mflo $t5 		#storing the incrementation of the power register
		bne $t3, $zero Convert
		j Exit
