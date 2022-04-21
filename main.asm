.data
	dividerLine:		.asciiz "\n-------------------------------------------------------------------------------------------------"
	introMessage: 	    	.asciiz "Welcome to MIPS Connect 4! This game is meant for one player versus a computer.\n"
	selectMessage:		.asciiz "\nPlease select an option from the menu below:"
	selectionMenu:		.asciiz "\n  1. New Game\n  2. Game Rules\n  3. Exit Game"
	menuSelect:		.asciiz "\n\n >: "
	gameRulesMessage:	.asciiz "\n     Hello and welcome to MIPS connect 4. Playing this game is quite simple. \n The objective is to fill four slots either horizontally, vertically, or diagonally. \n Your opponent is also trying to do the same and will work to try and interupt you. \n Simply choose a column to drop your token and the board will update to reflect \n your tokens location after it has 'fallen' down the column."
	returnMessage:		.asciiz "\n\n Enter '0' to return to the main menu."
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PlayerTurn:		.asciiz "\n PLAYERS TURN"
	ComputerTurn:		.asciiz "\n COMPUTER TURN"
	TurnMarker:		.word 1
	TurnLabel:		.asciiz "\n Turn Count: "
	TurnCounter:		.word 0
	
	GameBoardRow0:		.asciiz "\n\n    1   2   3   4   5   6   7"
	GameBoardRow1: 		.asciiz "\n  | _ | _ | _ | _ | _ | _ | _ |"
	GameBoardRow2:		.asciiz "\n  | _ | _ | _ | _ | _ | _ | _ |"
	GameBoardRow3:		.asciiz "\n  | _ | _ | _ | _ | _ | _ | _ |"
	GameBoardRow4:		.asciiz "\n  | _ | _ | _ | _ | _ | _ | _ |"
	GameBoardRow5:		.asciiz "\n  | _ | _ | _ | _ | _ | _ | _ |"
	GameBoardRow6:		.asciiz "\n  | _ | _ | _ | _ | _ | _ | _ |\n"
	
	InputColumn:		.asciiz "\nPlease select a Column:\n >:"
	
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	GBoardColumn1Array:	.space	24
	GBoardColumn2Array:	.space	24
	GBoardColumn3Array:	.space	24
	GBoardColumn4Array:	.space	24
	GBoardColumn5Array:	.space  24
	GBoardColumn6Array:	.space	24
	GBoardColumn7Array:	.space	24
.text

MainMenu:
# Display the intro message to the user. (Step 01)
	li $v0, 4
	la $a0, introMessage
	syscall
	
# Display the selection message to the user. (Step 02)
	li $v0, 4
	la $a0, selectMessage
	syscall

# Display the divider line message to the user. (Step 03)
	li $v0, 4
	la $a0, dividerLine
	syscall

# Display the selection message to the user. (Step 04)
	li $v0, 4
	la $a0, selectionMenu
	syscall

# Display the divider message to the user. (Step 05)
	li $v0, 4
	la $a0, dividerLine
	syscall
	
#Display the Menu Selection Character to the user.
	li $v0, 4
	la $a0, menuSelect
	syscall
	
# Wait for the user menu input.
	li $v0, 5
	syscall
	
# Take Inut and Branch Based on choice made.

	beq $v0, 1, NewGame

	beq $v0, 2, GameRules
	
	beq $v0, 0, Exit
NewGame:
	j CompleteTurn

CompleteTurn:
# Display the divider message to the user. (Step 05)
	li $v0, 4
	la $a0, dividerLine
	syscall
	
	beq $t1, 0, PTurn
	beq $t1, 1, CTurn

ContinueTurn:
	li $v0, 4
	la $a0, TurnLabel
	syscall
	
	addi $t7, $t7, 1

	move $a0, $t7
	
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow0
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow1
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow2
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow3
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow4
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow5
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow6
	syscall

# Display the divider message to the user. (Step 05)
	li $v0, 4
	la $a0, dividerLine
	syscall
	
#Display the Input Column Selector to the user.
	li $v0, 4
	la $a0, InputColumn
	syscall
	
	li $v0, 5
	syscall
	
	j CompleteTurn

PTurn:
	li $v0, 4
	la $a0, PlayerTurn
	syscall
	
	addi $t1, $zero, 1
	
	j ContinueTurn
CTurn:
	li $v0, 4
	la $a0, ComputerTurn
	syscall
	
	addi $t1, $zero, 0
	
	j ContinueTurn
GameRules:
	li $v0, 4
	la $a0, dividerLine
	syscall
	
	li $v0, 4
	la $a0, gameRulesMessage
	syscall
	
	li $v0, 4
	la $a0, dividerLine
	syscall
	
	li $v0, 4
	la $a0, returnMessage
	syscall
	
	li $v0, 4
	la $a0, menuSelect
	syscall

	li $v0, 5
	syscall
	
	beq $v0, 0, MainMenu
InputError:
Exit:
	li $v0, 10 #exits application.
	syscall
