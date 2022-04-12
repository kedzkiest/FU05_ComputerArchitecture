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
B:      .space 40   # The storage size of array B is 40 byte.
	
        .text
main:	or $t0, $0, $0 # i = 0
	lw $t1, N
	la $t2, A      # load the base address of array A into $t2
	la $t3, B      # load the base address of array B into $t3

loop:	beq $t0, $t1, loopend	# if i == N, then loopend
	lw $t4, 0($t2)		# load A[i] into $t4
	lw $t5, 0($t3)		# load B[i] into $t5
	addi $t5, $t4, 0	# B[i] = A[i]
	sw $t5, 0($t3)		# store B[i] data into the memory
	addi $t2, $t2, 4	# advance A's and B's base addresses by 4 to -
	addi $t3, $t3, 4	# - access the next variables
	addi $t0 $t0, 1		# i++
	j loop

loopend:

exit:	j exit
