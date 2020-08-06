#############################################################################################################
#	Program Name: Sum of Integers
#	Programmer: Peter Antonaros
#	Date last modified: 2/6/20
#############################################################################################################
#Functional Description:
#A program to find the sum of the integers from 1 to N, where N is a value read in from the keyboard.
#############################################################################################################
#Psuedocode description of algorithm:
#main:	cout << "\n Please input a value for N = "
#	cin >> v0
#	If(v0 >0)
#		{t0 =0;
#		While (v0 >0) do
#			{t0=t0+v0;
#			v0=v0-1}
#		cout << "  The sum of the integers from 1 to N is ", t0;
#		go to main
#		}
#	else
#		cout << "\n **** Adios Amigo - Have a good day ****"
#############################################################################################################
#Cross References:
#v0 : N,
#t0: Sum
#############################################################################################################	
	.data
Prompt: .asciiz "\n Please Input a value for N = "
Result: .asciiz "The sum, of the integer from 1 to N is "
Bye:	.asciiz "\n **** Adios Amigo - Have a good day****"
	.globl 	main
	.text
main:
	li $v0, 4	#system call code for Print String
	la $a0, Prompt	#load adress of prompt into $a0
	syscall		#print prompt message
	li $v0, 5	#System call code for Read Integer
	syscall		#Reads the value of N into $v0
	blez $v0, End	#Branh to end if $v0 <= 0
	li $t0, 0	#clear register $t0 to 0
	
Loop:
	add $t0, $t0, $v0	#Sum of integers in $t0
	addi $v0, $v0, -1	#Summing integers in reverse order
	bnez $v0, Loop 	 	#Branch to Loop if $v0 is !=0
	
	li $v0,4 		#System call code for Print String
	la $a0, Result		#Load address of message into $a0
	syscall 		#Print the string
	
	li $v0, 1 		#System call code for Print Integer
	move $a0, $t0		#Move value to be printed to $a0
	syscall 		#Print sum of integers
	b main			#Branch to main
End:	
	li $v0, 4	#System call code for Print String
	la $a0, Bye	#load address of msg. into $a0
	syscall		#Print the String
	li $v0, 10	#Terminate the program run and
	syscall		#Return control to the system
	
