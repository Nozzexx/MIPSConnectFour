.data
	dividerLine:		.asciiz "\n-------------------------------------------------------------------------------------------------"
	introMessage: 	    .asciiz "Welcome to MIPS Connect 4! This game is meant for one player versus a computer.\n"
	selectMessage:		.asciiz "\nPlease select an option from the menu below:"
	selectionMenu:		.asciiz "\n  1. New Game\n  2. Game Rules\n  3. Exit Game"
	menuSelect:			.asciiz "\n\n >: "
	gameRulesMessage:	.asciiz "\n     Hello and welcome to MIPS connect 4. Playing this game is quite simple. \n The objective is to fill four slots either horizontally, vertically, or diagonally. \n Your opponent is also trying to do the same and will work to try and interupt you. \n Simply choose a column to drop your token and the board will update to reflect \n your tokens location after it has 'fallen' down the column."
	returnMessage:		.asciiz "\n\n Enter '0' to return to the main menu."
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PlayerTurn:			.asciiz "\n PLAYERS TURN"
	ComputerTurn:		.asciiz "\n COMPUTER TURN"
	TurnMarker:			.word 1
	TurnLabel:			.asciiz "\n Turn Count: "
	TurnCounter:		.word 0
	
	PlayerToken:		.asciiz "X"
	ComputerToken:		.asciiz "O"
	
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
	
	Column1KeyArray:	.word 11, 21, 31, 41, 51, 61
	Column2KeyArray:	.word 12, 22, 32, 42, 52, 62
	Column3KeyArray:	.word 13, 23, 33, 43, 53, 63
	Column4KeyArray:	.word 14, 24, 34, 44, 54, 64
	Column5KeyArray:	.word 15, 25, 35, 45, 55, 65
	Column6KeyArray:	.word 16, 26, 36, 46, 56, 66
	Column7KeyArray:	.word 17, 27, 37, 47, 57, 67
	
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	PlayerArray:		.space  168
	ComputerArray:		.space	168
	
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
	
	beq $v0, 1, ColumnOneIter
	beq $v0, 2, ColumnTwoIter
	beq $v0, 3, ColumnThreeIter
	beq $v0, 4, ColumnFourIter
	beq $v0, 5, ColumnFiveIter
	beq $v0, 6, ColumnSixIter
	beq $v0, 7, ColumnSevenIter

ColumnOneIter:
	addi $s0, $s0, 1
	j AddToColumnOne
ColumnTwoIter:
	addi $s1, $s1, 1
	j AddToColumnTwo
ColumnThreeIter:
	addi $s2, $s2, 1
	j AddToColumnThree
ColumnFourIter:
	addi $s3, $s3, 1
	j AddToColumnFour
ColumnFiveIter:
	addi $s4, $s4, 1
	j AddToColumnFive
ColumnSixIter:
	addi $s5, $s5, 1
	j AddToColumnSix
ColumnSevenIter:
	addi $s6, $s6, 1
	j AddToColumnSeven
AddToColumnOne:
	
	mul $t0, $s0, 4
	add $t0, $t0, -4
	sw $v0, GBoardColumn1Array($t0)
	
	j GetColumnOneKey
	
AddToColumnTwo:

	mul $t0, $s1, 4
	add $t0, $t0, -4
	sw $v0, GBoardColumn1Array($t0)
	
	j GetColumnTwoKey
AddToColumnThree:

	mul $t0, $s2, 4
	add $t0, $t0, -4
	sw $v0, GBoardColumn1Array($t0)
	
	j GetColumnThreeKey
AddToColumnFour:

	mul $t0, $s3, 4
	add $t0, $t0, -4
	sw $v0, GBoardColumn1Array($t0)
	
	j GetColumnFourKey
AddToColumnFive:
	
	mul $t0, $s4, 4
	add $t0, $t0, -4
	sw $v0, GBoardColumn1Array($t0)
	
	j GetColumnFiveKey
AddToColumnSix:

	mul $t0, $s5, 4
	add $t0, $t0, -4
	sw $v0, GBoardColumn1Array($t0)
	
	j GetColumnSixKey
AddToColumnSeven:

	mul $t0, $s6, 4
	add $t0, $t0, -4
	sw $v0, GBoardColumn1Array($t0)
	
	j GetColumnSevenKey

GetColumnOneKey:

	lw $t6, Column1KeyArray($t0)

	beq $t1, 1, UpdatePlayerArray
	beq $t1, 0, UpdateComputerArray

GetColumnTwoKey:

	lw $t6, Column2KeyArray($t0)

	beq $t1, 1, UpdatePlayerArray
	beq $t1, 0, UpdateComputerArray
	
GetColumnThreeKey:

	lw $t6, Column3KeyArray($t0)
	beq $t1, 1, UpdatePlayerArray
	beq $t1, 0, UpdateComputerArray
GetColumnFourKey:

	lw $t6, Column4KeyArray($t0)
	beq $t1, 1, UpdatePlayerArray
	beq $t1, 0, UpdateComputerArray
	
GetColumnFiveKey:

	lw $t6, Column5KeyArray($t0)
	beq $t1, 1, UpdatePlayerArray
	beq $t1, 0, UpdateComputerArray
	
GetColumnSixKey:

	lw $t6, Column6KeyArray($t0)
	beq $t1, 1, UpdatePlayerArray
	beq $t1, 0, UpdateComputerArray
	
GetColumnSevenKey:
	
	lw $t6, Column7KeyArray($t0)
	beq $t1, 1, UpdatePlayerArray
	beq $t1, 0, UpdateComputerArray

UpdatePlayerArray:

	sw $t6, PlayerArray($t0)
	beq $v0, 1, UpdateColumnOneString
	beq $v0, 2, UpdateColumnTwoString
	beq $v0, 3, UpdateColumnThreeString
	beq $v0, 4, UpdateColumnFourString
	beq $v0, 5, UpdateColumnFiveString
	beq $v0, 6, UpdateColumnSixString
	beq $v0, 7, UpdateColumnSevenString
	
UpdateComputerArray:

	sw $t6, ComputerArray($t0)
	beq $v0, 1, UpdateColumnOneString
	beq $v0, 2, UpdateColumnTwoString
	beq $v0, 3, UpdateColumnThreeString
	beq $v0, 4, UpdateColumnFourString
	beq $v0, 5, UpdateColumnFiveString
	beq $v0, 6, UpdateColumnSixString
	beq $v0, 7, UpdateColumnSevenString
	
UpdateColumnOneString:

	j CompleteTurn
UpdateColumnTwoString:
	j CompleteTurn
UpdateColumnThreeString:
	j CompleteTurn
UpdateColumnFourString:
	j CompleteTurn
UpdateColumnFiveString:
	j CompleteTurn
UpdateColumnSixString:
	j CompleteTurn
UpdateColumnSevenString:	
	j CompleteTurn

PTurn:
	li $v0, 4
	la $a0, PlayerTurn
	syscall
	
	addi $t1, $zero, 1
	
	#Load Player Token
	lw $t5, PlayerToken
	
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
