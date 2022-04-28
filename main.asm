.data
	dividerLine:		.asciiz "\n-------------------------------------------------------------------------------------------------"
	introMessage: 	    .asciiz "Welcome to MIPS Connect 4! This game is meant for one player versus a computer.\n"
	selectMessage:		.asciiz "\nPlease select an option from the menu below:"
	selectionMenu:		.asciiz "\n  1. New Game\n  2. Game Rules\n  3. Exit Game"
.text

# Display the intro message to the user. (Step 01)
	li $v0, 4
	la $a0, introMessage
	syscall
	
# Display the intro message to the user. (Step 01)
	li $v0, 4
	la $a0, selectMessage
	syscall

# Display the intro message to the user. (Step 01)
	li $v0, 4
	la $a0, dividerLine
	syscall

# Display the intro message to the user. (Step 01)
	li $v0, 4
	la $a0, selectionMenu
	syscall

# Display the intro message to the user. (Step 01)
	li $v0, 4
	la $a0, dividerLine
	syscall
	
	li $v0, 10 #exits application.
	syscall