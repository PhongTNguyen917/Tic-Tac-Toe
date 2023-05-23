

# TIC -TAC-TOE 
# First player will be player X, and second player will be player O. Number 1 through 9 is
# the position where the players want to place their Values of X or O into the squares.
#-------------------------------------------------------------------------------------------


.data
grid: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
message_1: .asciiz "\n Player 1  pick the next square from (1-9): "
message_2: .asciiz "\n Player 2  pick the next square from (1-9): "
output_1: .asciiz "\n Invalid move! and please select again (1-9): "
output_2: .asciiz "\n Invalid index! and select the next empty squares (1-9): "
output_3: .asciiz "\n-----------------------\n"
output_4: .asciiz " "
output_5: .asciiz " |"
output_6: .asciiz "X"
output_7: .asciiz "0"
output_8: .asciiz "-"
output_9: .asciiz "\n Congratulations, Player 1 win the game!"
output_10: .asciiz "\n Congratulations, Player 2 win the game!"
output_11: .asciiz "\n THe Game is a DRAW!"
output_12: .asciiz "\n Do you want to continue? (1 = yes, 0 = no)"
output_13: .asciiz "\n To continue please choose (1 = yes, 0 = no)"
newline_l: .asciiz "\n"

.text
main:

addi $t3, $zero, 9 # Counter
addi $a2, $zero, 1 # X is symbolized by value 1.
addi $s2, $zero, 2 # y is symbolized by value 1.
addi $s0, $zero, 3 # a printing counter.
addi $s1, $zero, 3 # additional printing counter.
add $t9, $zero, $zero # A flag to indicate who has the next turnis.

print:
li $v0, 4  	# prints the tic-tac-toe board's current condition.
la $a1, grid

print_1:
lw $t8, 0($a1)
addi $a1, $a1, 4
la $a0, output_4
syscall
beq $t8, $zero, dash
beq $t8, $a2, X

O: la $a0, output_7
syscall
addi $s0, $s0, -1
bgtz $s0, dash_line
j A_line

X: la $a0, output_6
syscall
addi $s0, $s0, -1
bgtz $s0, dash_line
j A_line

dash:
la $a0, output_8
syscall
addi $s0, $s0, -1
bgtz $s0, dash_line
j A_line

dash_line:
la $a0, output_5
syscall
j print_1

A_line:

la $a0, output_3
syscall
addi $s1, $s1, -1
addi $s0, $s0, 3
bgtz $s1, print_1
beq $t9, $zero, main_2
j main_3

win_1: li $v0, 4 # declaring that player 1.
la $a1, grid

prin1: lw $t8, 0($a1)
addi $a1, $a1, 4
la $a0, output_4
syscall
beq $t8, $zero, dash1
beq $t8, $a2, X_1

O_1: la $a0, output_7
syscall
addi $s0, $s0, -1
bgtz $s0, hdash1
j nline1

X_1: la $a0, output_6
syscall
addi $s0, $s0, -1
bgtz $s0, hdash1
j nline1

dash1: la $a0, output_8
syscall
addi $s0, $s0, -1
bgtz $s0, hdash1
j nline1

hdash1: la $a0, output_5
syscall
j prin1

nline1: la $a0, output_3
syscall
addi $s1, $s1, -1
addi $s0, $s0, 3
bgtz $s1, prin1
la $a0, output_9
syscall
j continue

win_2: li $v0, 4 # prints that player 2 wins.
la $a1, grid

print_2: lw $t8, 0($a1)
addi $a1, $a1, 4
la $a0, output_4
syscall
beq $t8, $zero, dash_2
beq $t8, $a2, X2

O2: la $a0, output_7
syscall
addi $s0, $s0, -1
bgtz $s0, hdash2
j A_line

X2: la $a0, output_6
syscall
addi $s0, $s0, -1
bgtz $s0, hdash2
j nline2

dash_2: la $a0, output_8
syscall
addi $s0, $s0, -1
bgtz $s0, hdash2
j nline2

hdash2: la $a0, output_5
syscall
j print_2

nline2: la $a0, output_3
syscall
addi $s1, $s1, -1
addi $s0, $s0, 3
bgtz $s1, print_2
la $a0, output_10
syscall
j continue

draw: li $v0, 4 # identical to print, but it also states that it was a draw.
la $a1, grid

print_w: lw $t8, 0($a1)
addi $a1, $a1, 4
la $a0, output_4
syscall
beq $t8, $zero, dashw
beq $t8, $a2, Xw

Ow: la $a0, output_7
syscall
addi $s0, $s0, -1
bgtz $s0, hdashw
j nlinew

Xw: la $a0, output_6
syscall
addi $s0, $s0, -1
bgtz $s0, hdashw
j nlinew

dashw: la $a0, output_8
syscall
addi $s0, $s0, -1
bgtz $s0, hdashw
j nlinew

hdashw: la $a0, output_5
syscall
j print_w

nlinew: la $a0, output_3
syscall
addi $s1, $s1, -1
addi $s0, $s0, 3
bgtz $s1, print_w
la $a0, output_11
syscall
j continue

main21: li $v0, 4
la $a0, output_1
syscall

main_2: li $v0, 4  # Put a command in the output string.
la $a0, message_1
syscall

li $v0, 5  # Using the load command, enter an integer
syscall

slti $t1, $v0, 10  # Catches an exception, index > 9.
beq $t1, $zero, exception_1
slti $t1, $v0, 1 # Catches an exception, index < 1.
bne $t1, $zero, exception_1
la $a0, grid
addi $v0, $v0, -1
sll $t1, $v0, 2 # Multiply index by 4, for byte offset.
add $a0, $a0, $t1
lw $a1, 0($a0) # Applying the square to be an X.
bgtz $a1, main21
addi $a1, $a1, 1
sw $a1, 0($a0)
addi $t3, $t3, -1 # Subtractingthe program counter.
addi $t9, $t9, 1 # Player 2 turn is next 
addi $s1, $s1, 3
j end_1

main31: li $v0, 4
la $a0, output_1
syscall

main_3: li $v0, 4 # Put a command in the output 
la $a0, message_2
syscall
li $v0, 5 # Using the load command, enter an integer
syscall
slti $t1, $v0, 10 # Catches an exception, index > 9
beq $t1, $zero, exception_2
slti $t1, $v0, 1 # Catches an exception, index < 1
bne $t1, $zero, exception_2
la $a0, grid
addi $v0, $v0, -1
sll $t1, $v0, 2 # Multiply index by 4, for byte of offset.
add $a0, $a0, $t1
lw $a1, 0($a0) # Applying the square to be an O.
bgtz $a1, main31
addi $a1, $a1, 2
sw $a1, 0($a0)
addi $t3, $t3, -1 # subtracting the counter program.
addi $t9, $t9, -1 # It's now Player 1's turn.
addi $s1, $s1, 3
j end2

exception_1: li $v0, 4
la $a0, output_2
syscall
j main_2

exception_2: li $v0, 4
la $a0, output_2
syscall
j main_3

# end_1 and end_2 are applied to determine who wins, Player 1 or Player 2.
end_1: la $a0, grid

lw $t4, 0($a0) # Verify if Row 1 is filled or in X
lw $t5, 4($a0) # Read return values and restore important registers 
lw $t6, 8($a0)
beq $t4, $a2, condition_2
j next

condition_2: beq $t5, $a2, condition_3
j next

condition_3: beq $t6, $a2, win_1

next: lw $t4, 12($a0) # Verify that if Row 2 is filled with X
lw $t5, 16($a0)       # Read return values and restore important registers 
lw $t6, 20($a0)
beq $t4, $a2, condition_12
j next1

condition_12: beq $t5, $a2, condition_13
j next1

condition_13: beq $t6, $a2, win_1
next1: lw $t4, 24($a0) # Verify thatif Row 3 is filled with X
lw $t5, 28($a0)
lw $t6, 32($a0)
beq $t4, $a2, condition_22
j next2

condition_22: beq $t5, $a2, condition_23
j next2

condition_23: beq $t6, $a2, win_1
next2: lw $t4, 0($a0) # Verify that if this diagonal '\' is filled with X
lw $t5, 16($a0)
lw $t6, 32($a0)
beq $t4, $a2, condition_32
j next_3

condition_32: beq $t5, $a2, condition_33
j next_3

condition_33: beq $t6, $a2, win_1

next_3: lw $t4, 8($a0) # Verify that if this diagonal '/' is filled with X
lw $t5, 16($a0)	       # Read return values and restore important registers 
lw $t6, 24($a0)
beq $t4, $a2, condition_42
j next_4

condition_42: beq $t5, $a2, condition_43
j next_4

condition_43: beq $t6, $a2, win_1

next_4: lw $t4, 0($a0) # Verify if column 1 is filled with X
lw $t5, 12($a0)	       	# Read return values and restore important registers 
lw $t6, 24($a0)
beq $t4, $a2, condition_52
j next_5

condition_52: beq $t5, $a2, condition_53
j next_5

condition_53: beq $t6, $a2, win_1

# Read return values and restore important registers 
next_5: lw $t4, 4($a0) # Verify if column 2 is filled with X
lw $t5, 16($a0)		
lw $t6, 28($a0)
beq $t4, $a2, condition_62
j next_6

condition_62: beq $t5, $a2, condition_63
j next_6

condition_63: beq $t6, $a2, win_1

next_6: lw $t4, 8($a0) # Verify if column 3 is filled with X
lw $t5, 20($a0)	       # Read return values and restore important registers 
lw $t6, 32($a0)
beq $t4, $a2, condition_72
j next_7

condition_72: beq $t5, $a2, condition_73
j next_7

condition_73: beq $t6, $a2, win_1
next_7: bne $t3, $zero, print
j draw # If X doesn't win by the ninth turn, it's a draw.

end2: la $a0, grid
lw $t4, 0($a0) # Verify that if row 1 is filled with O
lw $t5, 4($a0)
lw $t6, 8($a0)
beq $t4, $s2, con2
j nex

con2: beq $t5, $s2, con3
j nex

con3: beq $t6, $s2, win_2
nex: lw $t4, 12($a0) # Verofu if row 2 is filled with O
lw $t5, 16($a0)		# Loadwrod of offset 16
lw $t6, 20($a0)		# load word of offset 20 
beq $t4, $s2, co12
j next_1
co12: beq $t5, $s2, co13
j next_1

co13: beq $t6, $s2, win_2

next_1: lw $t4, 24($a0) # Verify if row 3 is filled with O
lw $t5, 28($a0)		# load word offset by 28
lw $t6, 32($a0)		# load word offset by 32
beq $t4, $s2, co22
j nex2

co22: beq $t5, $s2, co23
j nex2

co23: beq $t6, $s2, win_2
nex2: lw $t4, 0($a0) # Verify that if diagonal '\' is filled with O
lw $t5, 16($a0)		
lw $t6, 32($a0)
beq $t4, $s2, co32
j nex3
co32: beq $t5, $s2, co33
j nex3
co33: beq $t6, $s2, win_2
nex3: lw $t4, 8($a0) # Verify that this diagonal '/' is filled in with O
lw $t5, 16($a0)
lw $t6, 24($a0)
beq $t4, $s2, co42
j nex4

co42: beq $t5, $s2, co43
j nex4

co43: beq $t6, $s2, win_2

nex4: lw $t4, 0($a0)  # Verity that column 1 is filled with O
lw $t5, 12($a0)
lw $t6, 24($a0)
beq $t4, $s2, co52
j nex5

co52: beq $t5, $s2, co53
j nex5

co53: beq $t6, $s2, win_2

nex5: lw $t4, 4($a0)  # Verify that column 2 is filled with O
lw $t5, 16($a0)
lw $t6, 28($a0)
beq $t4, $s2, co62
j nex6

co62: beq $t5, $s2, co63
j nex6

co63: beq $t6, $s2, win_2

nex6: lw $t4, 8($a0) # Verify that column 3 contains an O.
lw $t5, 20($a0)
lw $t6, 32($a0)
beq $t4, $s2, co72
j nex7

co72: beq $t5, $s2, co73
j nex7

co73: beq $t6, $s2, win_2
nex7: j print

excep3: li $v0, 4
la $a0, output_13
syscall
j continue

# For a new round of tic-tac-toe, clears the board.
clmain: la $a0, grid
add $a2, $zero, $zero

loop2: slti $t1, $a2, 10
beq $t1, $zero, main
loop: lw $a1, 0($a0)

addi $a2, $a2, 1 #Counter for clearing data.
add $a1, $zero, $zero
sw $a1, 0($a0)
addi $a0, $a0, 4 # move the address
j loop2

# determines whether the user wishes to proceed or not.
continue:
li $v0, 4 # brings a command into the output 
la $a0, output_12
syscall
li $v0, 5 # commands to load an integer for input
syscall
bltz $v0, excep3 # Improve the clarity of the input
slti $t1, $v0, 2
beq $t1, $zero, excep3
slti $t1, $v0, 1
li $v0, 4
la $a0, newline_l
syscall
beq $t1, $zero, clmain
li $v0, 10
syscall
