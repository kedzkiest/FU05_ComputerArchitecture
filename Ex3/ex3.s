	.data
mat1:	.word 0, 0, 0, 1
	.word 0, 2, 0, 0
	.word 0, 0, 3, 0
	.word 4, 0, 0, 0

mat2:	.word 0, 1, 2, 3
	.word 4, 5, 6, 7
	.word 8, 9, 10, 11
	.word 12, 13, 14, 15

result:	.word 1911, 1911, 1911, 1911
	.word 1911, 1911, 1911, 1911
	.word 1911, 1911, 1911, 1911
	.word 1911, 1911, 1911, 1911

	.text
main:	addi $s0, $0, 4 # const $s0 = 4
	or $t0, $0, $0 # true or false

	#initialize i-loop variable
	or $s1, $0, $0 # i = 0

iLoop:	slt $t0, $s1, $s0
	beq $t0, $0, endILoop

	#initialize j-loop variable
	or $s2, $0, $0 # j = 0

jLoop:	slt $t0, $s2, $s0
	beq $t0, $0, endJLoop

	#initialize each element's sum
	or $s3, $0, $0 # tmpSum = 0

	#initialize k-loop variable
	or $s4, $0, $0 # k = 0

kLoop:	slt $t0, $s4, $s0
	beq $t0, $0, endKLoop

	la $s5, mat1
	la $s6, mat2
	
	add $a0, $0, $s1 # i
	add $a1, $0, $s4 # k	
	jal calcAddress # get target address -> mat1[i][k]
	add $s5, $s5, $v0 # advance mat1's address
	lw $t5, 0($s5) # mat1[i][k]

	add $a0, $0, $s4 # k
	add $a1, $0, $s2 # j
	jal calcAddress # get target address -> mat2[k][j]
	add $s6, $s6, $v0 # advance mat2's address
	lw $t6, 0($s6) # mat2[k][j]

	add $a0, $0, $t5
	add $a1, $0, $t6
	jal myMul # calc product = mat1[i][k] * mat2[k][j]

	add $s3, $s3, $v0 # tmpSum += product

	# step for k-loop
	addi $s4, $s4, 1 # k++

	j kLoop
	

endKLoop:
	la $s7, result
	
	add $a0, $0, $s1 # i
	add $a1, $0, $s2 # j
	jal calcAddress # get target address -> result[i][j]
	add $s7, $s7, $v0 # advance result's address
	sw $s3, 0($s7) # result[i][j] = tmpSum
	
	# step for j-loop
	addi $s2, $s2, 1 # j++

	j jLoop

endJLoop:
	# step for i-loop
	addi $s1, $s1, 1 # i++

	j iLoop

endILoop:

exit:	j exit

	##############################################################
	
myMul:
	# takes two arguments $a0, $a1 and returns $v0 = $a0 * $a1
	
	or $v0, $0, $0 # result = 0
        or $t0, $0, $0 # cnt = 0
        addi $t1, $0, 1 # bit mask. initially 1, will be L-shifted

loop:   beq $t0, 32, loopend
        and $t2, $a1, $t1 # 1st -> 32nd bit eject
        beq $t2, $0, next # if ejected bit is 0, then no addition
        add $v0, $v0, $a0

next:   addu $a0, $a0, $a0 # multiplicand 1-bit L-shift
        addu $t1, $t1, $t1 # bit mask 1-bit L-shift
        addi $t0, $t0, 1 # cnt++
        j loop

loopend: jr $ra

	##############################################################

calcAddress:
	# takes two arguments $a0, $a1 and returns addr(array[$a0][$a1])
	# In other words, returns (4 * $a0 + $a1) * 4 this time
	
	addi $sp, $sp, -12 # adjust stack for 3 items
	sw $ra, 0($sp) # save return address
	sw $a0, 4($sp) # save original arg1 (a0)
	sw $a1, 8($sp) # save original arg2 (a1)

	add $a0, $0, $s0 # 4
	lw $a1, 4($sp) # original $a0
	jal myMul # myMul(4 * $a0)

	add $t3, $0, $v0 # copy return value
	lw $t4, 8($sp) # original $a1
	add $t3, $t3, $t4 # 4 * $a0 + $a1

	add $a0, $0, $t3 # 4 * $a0 + $a1
	add $a1, $0, $s0 # 4
	jal myMul # myMul(4 * $a0 + $a1, 4). return this as $v0
	
	
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	jr $ra

	
	

	

