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
	

        # Initialize outer loop variable
	.text
	lw $t0, N
	addi $t0, $t0, -1 # const $t0 = N - 1
	or $t1, $0, $0 # i = 0
	or $t2, $0, $0 # true or false
	or $t3, $0, $0 # j = 0
	or $t4, $0, $0 # var i - 1 in innerLoop
	

outerloop:  slt $t2, $t1, $t0	# test outer loop condition
            beq $t2, $0, endOuterLp # conditionally branch to end of outer loop

            # Initialize inner loop variable
            addi $t3, $t0, -1 # j = N - 2

innerloop:  addi $t4, $t1, -1 # var i - 1
	    slt $t2, $t4, $t3      # test inner loop condition
            beq $t2, $0, endInnerLp # conditionally branch to end of inner loop

            # do something (body of inner loop)
	    la $t5, A
	    or $t6, $0, $0 # cnt = 0

addressIncrementLoop:	
	    beq $t6, $t3, endAddressIncrementLp
	    addi $t6, $t6, 1
	    addi $t5, $t5, 4
	    j addressIncrementLoop

endAddressIncrementLp:
	    lw $t7, 0($t5)
	    lw $t8, 4($t5)
	    slt $t2, $t8, $t7 # test swap condition
	    beq $t2, $0, Else
	    or $t9, $0, $0 # tmp = 0
	    add $t9, $0, $t7 # tmp = A[j]
	    add $t7, $0, $t8 # A[j] = A[j+1]
	    add $t8, $0, $t9 # A[j+1] = tmp
	    sw $t7, 0($t5)
	    sw $t8, 4($t5)
	
            # step for inner loop, e.g., j++
	    addi $t3, $t3, -1

            j innerloop

Else:
	    # step for inner loop, e.g., j++
	    addi $t3, $t3, -1

            j innerloop
	
endInnerLp: # is there more to do here?

            # step for outer loop, e.g., i++
	    addi $t1, $t1, 1

            j outerloop

endOuterLp: # is there more to do here?
	
exit:	j exit
