	.data
A:	.word 31
B:	.word 53
C:	.word 11
S:	.word 0

	.text
main:	lw $t0, A
	lw $t1, B
	lw $t2, C
	add $t0, $t0, $t1
	sub $t0, $t0, $t2
	ori $t0, $t0, 3
	sw $t0, S
exit:	j exit
