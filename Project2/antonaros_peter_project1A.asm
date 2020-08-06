.data
Prompt: .asciiz "\nPlease input a value for N = "
Truncate: .asciiz "Your floating point number was: "
Truncate2: .asciiz "\nThe truncated number was the integer: "
Result: .asciiz "\nThe sum from 1 to N is "
Done: .asciiz "\n***End of Program***"
.globl main

.text
main:
	li $v0,4
	la $a0,Prompt
	syscall #Prints prompt message to console 
	li $v0, 6
	syscall
	li $t0, 0
	mfc1 $t1, $f0 #Move floating point to $t1
	add.s $f12, $f12, $f0 #Copy original floating point to empty register for later use
	blez $t1, End #Branch to End if input is <=0
	srl $t2, $t1, 23
	add $s3, $t2, -127
	sll $t4, $t1, 9
	srl $t5, $t4, 9
	add $t6, $t5, 8388608
	add $t7, $s3, 9
	sllv $s4, $t6, $t7 #If this number NE to 0 there is a fraction
	rol $t4, $t6, $t7
	li $t5, 31
	sub $t2, $t5, $s3
	sllv $t5, $t4, $t2
	srlv $s5, $t5, $t2
	la $v0, ($s5) #load integer stored in $s5 to $v0
	beqz $s4, loop #Branch to integer loop if fraction in $s4 E zero
	bnez $s4, loop2 #Branch to float loop if fraction in $s4 NE to zero
	
loop:
	add $t0, $t0, $v0
	addi $v0, $v0, -1
	bnez $v0, loop
	
	li $v0, 4
	la $a0, Result
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	b End

loop2:
	add $t0, $t0, $v0
	addi $v0, $v0, -1
	bnez $v0, loop2
	
	li $v0, 4
	la $a0, Truncate #Print out Truncate message from .data
	syscall
	
	li $v0, 2 #Print out initial float entered
	mfc1 $a0, $f12 
	syscall 
	
	li $v0, 4
	la $a0, Truncate2 #Print out Truncate2 message from .data
	syscall
	
	li $v0, 1 #Print out float -> integer (Truncated)
	move $a0, $s5
	syscall
	
	li $v0, 4
	la $a0, Result
	syscall 
	
	li $v0, 1
	move $a0, $t0
	syscall 
	b End	

End:
	li $v0,4
	la $a0, Done
	syscall
	li $v0, 10
	syscall #Terminates program and returns control
