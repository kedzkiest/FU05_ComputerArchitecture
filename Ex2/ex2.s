	.data
A:	.word 28
B:	.word 188
S:	.word 0
	
	.text
	lw $a0, A # multiplicand
	lw $a1, B # multiplier
	or $v0, $0, $0 # result = 0
	or $t0, $0, $0 # cnt = 0
	addi $t1, $0, 1 # bit mask. initially 1, will be L-shifted

loop:	beq $t0, 32, loopend
	and $t2, $a1, $t1 # 1st -> 32nd bit eject
	beq $t2, $0, next # if ejected bit is 0, then no addition
	add $v0, $v0, $a0
	
next:	addu $a0, $a0, $a0 # multiplicand 1-bit L-shift
	addu $t1, $t1, $t1 # bit mask 1-bit L-shift
	addi $t0, $t0, 1 # cnt++
	j loop
	
loopend:	sw $v0, S
	
exit:	j exit
	
	
