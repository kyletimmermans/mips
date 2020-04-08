##### RAT TABLE #####
#      $a0 = 6      #
#      $t0 = 3      #
#      $t1 = 3      #
#  $v0 = zEquals    #
#####################

# Variables in RAM
.data
	x: .word 1
	y: .word 12
	xEquals: .asciiz "x="
	yEquals: .asciiz " y=" #Need a space here
	zEquals: .asciiz " z=" #Need a space here

.text # Code
main: #main()
       # Print xEquals
       li $v0,4
       la $a0,xEquals
       syscall
       # Load in x
       lw $t0, x
       move $a0, $t0
       li $v0, 1
       syscall
       move $a1, $a0 # Necessary move for compare func
       # Print yEquals
       li $v0,4
       la $a0,yEquals
       syscall
       # Load in y
       lw $t1, y
       move $a0, $t1
       li $v0, 1
       syscall
       # jump and link register
       jal compare   
       move $s0, $v0
       #Print zEquals
       li $v0,4
       la $a0,zEquals
       syscall
       # Print z
       move $a0, $s0    
       li $v0, 1
       syscall
       #End of main
       #Proper exit code
       li $v0,10
       syscall
	
compare:
	move $t0,$a1 #$t0=x
	move $t1,$a0 #t1=y
	beq $t0,$t1,adder #If x==y  # or beq
	addi $t1,$t1,3 #y+3
	#If x==y+3
	beq $t0,$t1,subtracter   # or beq
	add $v0,$0,$0  # finally, if not either of those, make it zero
	j return  # Return the final case z=0, if need be
adder:
	add $v0,$t0,$t1
	j return #z=x+y
subtracter:
	sub $v0,$t0,$a0
	j return #z=x-y
return:
	jr $ra #z final answer

