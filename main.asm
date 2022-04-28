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
	
	GameBoardRow7:		.asciiz "\n\n    1   2   3   4   5   6   7"
	GameBoardRow6: 		.asciiz "\n  | _ | _ | _ | _ | _ | _ | _ |"
	GameBoardRow5:		.asciiz "\n  | _ | _ | _ | _ | _ | _ | _ |"
	GameBoardRow4:		.asciiz "\n  | _ | _ | _ | _ | _ | _ | _ |"
	GameBoardRow3:		.asciiz "\n  | _ | _ | _ | _ | _ | _ | _ |"
	GameBoardRow2:		.asciiz "\n  | _ | _ | _ | _ | _ | _ | _ |"
	GameBoardRow1:		.asciiz "\n  | _ | _ | _ | _ | _ | _ | _ |\n"
	
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
	
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	

	TooHighErrorMsg:	.asciiz "\n\n Error, Input too high. That column does not exist. Please enter a valid Input between 1-7.\n"
	TooLowErrorMsg:		.asciiz "\n\n Error, Input too low. That column does not exist. Please enter a valid Input between 1-7.\n"
	NoInputErrorMsg:	.asciiz "\n\n Error. No Input was detected, or that Column does not exist. Please enter a valid Input between 1-7.\n"
	
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
	la $a0, GameBoardRow7
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow6
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow5
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow4
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow3
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow2
	syscall
	
	li $v0, 4
	la $a0, GameBoardRow1
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
	
	bgt $v0, 7, TooHighError
	blt $v0, 1, TooLowError
	
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
	li $a1,'X'
	beq $v0, 1, UpdateColumnOneString
	beq $v0, 2, UpdateColumnTwoString
	beq $v0, 3, UpdateColumnThreeString
	beq $v0, 4, UpdateColumnFourString
	beq $v0, 5, UpdateColumnFiveString
	beq $v0, 6, UpdateColumnSixString
	beq $v0, 7, UpdateColumnSevenString
	
UpdateComputerArray:

	sw $t6, ComputerArray($t0)
	li $a1,'O'
	beq $v0, 1, UpdateColumnOneString
	beq $v0, 2, UpdateColumnTwoString
	beq $v0, 3, UpdateColumnThreeString
	beq $v0, 4, UpdateColumnFourString
	beq $v0, 5, UpdateColumnFiveString
	beq $v0, 6, UpdateColumnSixString
	beq $v0, 7, UpdateColumnSevenString
	
UpdateColumnOneString:

	beq $s0, 1, UpdateRow1Col1
	beq $s0, 2, UpdateRow2Col1
	beq $s0, 3, UpdateRow3Col1
	beq $s0, 4, UpdateRow4Col1
	beq $s0, 5, UpdateRow5Col1
	beq $s0, 6, UpdateRow6Col1

UpdateRow1Col1:

	li $t4, 0
	la $t4, GameBoardRow1
	lb $a0,5($t4)

	sb $a1, 5($t4)

	j CompleteTurn

UpdateRow2Col1:

	li $t4, 0
	la $t4, GameBoardRow2
	lb $a0,5($t4)

	sb $a1, 5($t4)

	j CompleteTurn
	
UpdateRow3Col1:

	li $t4, 0
	la $t4, GameBoardRow3
	lb $a0,5($t4)

	sb $a1, 5($t4)

	j CompleteTurn
UpdateRow4Col1:

	li $t4, 0
	la $t4, GameBoardRow4
	lb $a0,5($t4)

	sb $a1, 5($t4)

	j CompleteTurn
UpdateRow5Col1:

	li $t4, 0
	la $t4, GameBoardRow5
	lb $a0,5($t4)

	sb $a1, 5($t4)

	j CompleteTurn
UpdateRow6Col1:

	li $t4, 0
	la $t4, GameBoardRow6
	lb $a0,5($t4)

	sb $a1, 5($t4)

	j CompleteTurn
	
UpdateColumnTwoString:

	beq $s1, 1, UpdateRow1Col2
	beq $s1, 2, UpdateRow2Col2
	beq $s1, 3, UpdateRow3Col2
	beq $s1, 4, UpdateRow4Col2
	beq $s1, 5, UpdateRow5Col2
	beq $s1, 6, UpdateRow6Col2

UpdateRow1Col2:

	li $t4, 0
	la $t4, GameBoardRow1
	lb $a0,9($t4)

	sb $a1, 9($t4)

	j CompleteTurn

UpdateRow2Col2:

	li $t4, 0
	la $t4, GameBoardRow2
	lb $a0,9($t4)

	sb $a1, 9($t4)

	j CompleteTurn
	
UpdateRow3Col2:

	li $t4, 0
	la $t4, GameBoardRow3
	lb $a0,9($t4)

	sb $a1, 9($t4)

	j CompleteTurn
UpdateRow4Col2:

	li $t4, 0
	la $t4, GameBoardRow4
	lb $a0,9($t4)

	sb $a1, 9($t4)

	j CompleteTurn
UpdateRow5Col2:

	li $t4, 0
	la $t4, GameBoardRow5
	lb $a0,9($t4)

	sb $a1, 9($t4)

	j CompleteTurn
UpdateRow6Col2:

	li $t4, 0
	la $t4, GameBoardRow6
	lb $a0,9($t4)

	sb $a1, 9($t4)

	j CompleteTurn

	
UpdateColumnThreeString:

	beq $s2, 1, UpdateRow1Col3
	beq $s2, 2, UpdateRow2Col3
	beq $s2, 3, UpdateRow3Col3
	beq $s2, 4, UpdateRow4Col3
	beq $s2, 5, UpdateRow5Col3
	beq $s2, 6, UpdateRow6Col3

UpdateRow1Col3:

	li $t4, 0
	la $t4, GameBoardRow1
	lb $a0,13($t4)

	sb $a1, 13($t4)

	j CompleteTurn

UpdateRow2Col3:

	li $t4, 0
	la $t4, GameBoardRow2
	lb $a0,13($t4)

	sb $a1, 13($t4)

	j CompleteTurn
	
UpdateRow3Col3:

	li $t4, 0
	la $t4, GameBoardRow3
	lb $a0,13($t4)

	sb $a1, 13($t4)

	j CompleteTurn
UpdateRow4Col3:

	li $t4, 0
	la $t4, GameBoardRow4
	lb $a0,13($t4)

	sb $a1, 13($t4)

	j CompleteTurn
UpdateRow5Col3:

	li $t4, 0
	la $t4, GameBoardRow5
	lb $a0,13($t4)

	sb $a1, 13($t4)

	j CompleteTurn
UpdateRow6Col3:

	li $t4, 0
	la $t4, GameBoardRow6
	lb $a0,13($t4)

	sb $a1, 13($t4)

	j CompleteTurn
	
UpdateColumnFourString:

	beq $s3, 1, UpdateRow1Col4
	beq $s3, 2, UpdateRow2Col4
	beq $s3, 3, UpdateRow3Col4
	beq $s3, 4, UpdateRow4Col4
	beq $s3, 5, UpdateRow5Col4
	beq $s3, 6, UpdateRow6Col4

UpdateRow1Col4:

	li $t4, 0
	la $t4, GameBoardRow1
	lb $a0,17($t4)

	sb $a1, 17($t4)

	j CompleteTurn

UpdateRow2Col4:

	li $t4, 0
	la $t4, GameBoardRow2
	lb $a0,17($t4)

	sb $a1, 17($t4)

	j CompleteTurn
	
UpdateRow3Col4:

	li $t4, 0
	la $t4, GameBoardRow3
	lb $a0,17($t4)

	sb $a1, 17($t4)

	j CompleteTurn
UpdateRow4Col4:

	li $t4, 0
	la $t4, GameBoardRow4
	lb $a0,17($t4)

	sb $a1, 17($t4)

	j CompleteTurn
UpdateRow5Col4:

	li $t4, 0
	la $t4, GameBoardRow5
	lb $a0,17($t4)

	sb $a1, 17($t4)

	j CompleteTurn
UpdateRow6Col4:

	li $t4, 0
	la $t4, GameBoardRow6
	lb $a0,17($t4)

	sb $a1, 17($t4)

	j CompleteTurn
	
UpdateColumnFiveString:

	beq $s4, 1, UpdateRow1Col5
	beq $s4, 2, UpdateRow2Col5
	beq $s4, 3, UpdateRow3Col5
	beq $s4, 4, UpdateRow4Col5
	beq $s4, 5, UpdateRow5Col5
	beq $s4, 6, UpdateRow6Col5
	
UpdateRow1Col5:

	li $t4, 0
	la $t4, GameBoardRow1
	lb $a0,21($t4)

	sb $a1, 21($t4)

	j CompleteTurn

UpdateRow2Col5:

	li $t4, 0
	la $t4, GameBoardRow2
	lb $a0,21($t4)

	sb $a1, 21($t4)

	j CompleteTurn
	
UpdateRow3Col5:

	li $t4, 0
	la $t4, GameBoardRow3
	lb $a0,21($t4)

	sb $a1, 21($t4)

	j CompleteTurn
UpdateRow4Col5:

	li $t4, 0
	la $t4, GameBoardRow4
	lb $a0,21($t4)

	sb $a1, 21($t4)

	j CompleteTurn
UpdateRow5Col5:

	li $t4, 0
	la $t4, GameBoardRow5
	lb $a0,21($t4)

	sb $a1, 21($t4)

	j CompleteTurn
UpdateRow6Col5:

	li $t4, 0
	la $t4, GameBoardRow6
	lb $a0,21($t4)

	sb $a1, 21($t4)

	j CompleteTurn
	
UpdateColumnSixString:
	
	beq $s5, 1, UpdateRow1Col6
	beq $s5, 2, UpdateRow2Col6
	beq $s5, 3, UpdateRow3Col6
	beq $s5, 4, UpdateRow4Col6
	beq $s5, 5, UpdateRow5Col6
	beq $s5, 6, UpdateRow6Col6

UpdateRow1Col6:

	li $t4, 0
	la $t4, GameBoardRow1
	lb $a0,25($t4)

	sb $a1, 25($t4)

	j CompleteTurn

UpdateRow2Col6:

	li $t4, 0
	la $t4, GameBoardRow2
	lb $a0,25($t4)

	sb $a1, 25($t4)

	j CompleteTurn
	
UpdateRow3Col6:

	li $t4, 0
	la $t4, GameBoardRow3
	lb $a0,25($t4)

	sb $a1, 25($t4)

	j CompleteTurn
UpdateRow4Col6:

	li $t4, 0
	la $t4, GameBoardRow4
	lb $a0,25($t4)

	sb $a1, 25($t4)

	j CompleteTurn
UpdateRow5Col6:

	li $t4, 0
	la $t4, GameBoardRow5
	lb $a0,25($t4)

	sb $a1, 25($t4)

	j CompleteTurn
UpdateRow6Col6:

	li $t4, 0
	la $t4, GameBoardRow6
	lb $a0,25($t4)

	sb $a1, 25($t4)

	j CompleteTurn
	
UpdateColumnSevenString:

	beq $s6, 1, UpdateRow1Col7
	beq $s6, 2, UpdateRow2Col7
	beq $s6, 3, UpdateRow3Col7
	beq $s6, 4, UpdateRow4Col7
	beq $s6, 5, UpdateRow5Col7
	beq $s6, 6, UpdateRow6Col7	

UpdateRow1Col7:

	li $t4, 0
	la $t4, GameBoardRow1
	lb $a0,29($t4)

	sb $a1, 29($t4)

	j CompleteTurn

UpdateRow2Col7:

	li $t4, 0
	la $t4, GameBoardRow2
	lb $a0,29($t4)

	sb $a1, 29($t4)

	j CompleteTurn
	
UpdateRow3Col7:

	li $t4, 0
	la $t4, GameBoardRow3
	lb $a0,29($t4)

	sb $a1, 29($t4)

	j CompleteTurn
UpdateRow4Col7:

	li $t4, 0
	la $t4, GameBoardRow4
	lb $a0,29($t4)

	sb $a1, 29($t4)

	j CompleteTurn
UpdateRow5Col7:

	li $t4, 0
	la $t4, GameBoardRow5
	lb $a0,29($t4)

	sb $a1, 29($t4)

	j CompleteTurn
UpdateRow6Col7:

	li $t4, 0
	la $t4, GameBoardRow6
	lb $a0,29($t4)

	sb $a1, 29($t4)

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


TooHighError:

	add $t7, $t7, -1

	li $v0, 4
	la $a0, TooHighErrorMsg
	syscall
	
	li $v0, 4
	la $a0, dividerLine
	syscall
	
	j ContinueTurn

TooLowError:

	add $t7, $t7, -1
	
	li $v0, 4
	la $a0, dividerLine
	syscall

	li $v0, 4
	la $a0, TooLowErrorMsg
	syscall
	
	li $v0, 4
	la $a0, dividerLine
	syscall
	
	j ContinueTurn
Exit:
	li $v0, 10 #exits application.
	syscall
