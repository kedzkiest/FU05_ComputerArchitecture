	.data
A:	.word 31
B:	.word 53
C:	.word 11
S:	.word 0

	.text
main:	lw $t0, A # load a variable from the memory into the register
	lw $t1, B # same as above
	lw $t2, C # same as above
	
	add $t0, $t0, $t1 # A = A + B
	sub $t0, $t0, $t2 # A = A - C
	ori $t0, $t0, 3   # A = A | 3
	sw $t0, S	  # store data in the register $t0 into the memory
exit:	j exit
