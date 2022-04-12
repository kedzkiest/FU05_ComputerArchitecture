        .data
N:      .word 10    # The length of Array
A:      .word 9     # A[0] = 9
        .word 3     # A[1] = 3
        .word 12
        .word 7
        .word 23
        .word 1
        .word 23
        .word 43
        .word 54    # A[8] = 54
        .word 31    # A[9] = 31
B:      .space 40   # 配列B の格納先　大きさは40バイト
	
        .text
main:	or $t0, $0, $0 # i = 0
	lw $t1, N
	la $t2, A
	la $t3, B

loop:	beq $t0, $t1, loopend
	lw $t4, 0($t2)
	lw $t5, 0($t3)
	addi $t5, $t4, 0
	sw $t5, 0($t3)
	addi $t2, $t2, 4
	addi $t3, $t3, 4
	addi $t0 $t0, 1
	j loop

loopend:

exit:	j exit
