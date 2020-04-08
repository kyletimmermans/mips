##### RAT TABLE #####
#      $a0 = 6      #
#      $t0 = 3      #
#      $t1 = 3      #
#  $v0 = zEquals    #
#####################

# Variables in RAM
.data
	x: .word 3
	y: .word 3
	#z: .word 0  # init value
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
       lw $t1, x
       move $a0, $t0
       li $v0, 1
       syscall
       # Load x and y into compare
       jal compare   # or jal compare
       move $s0, $v0
       #Print zEquals
       li $v0,4
       la $a0,zEquals
       syscall
       # Print z
       move $a0, $s0    # problem here
       li $v0, 1
       syscall
       #End of main
       #Proper exit code
       li $v0,10
       syscall
	
compare:
	#t0=x
	move $t0,$a1
	#t1=y
	move $t1,$a0
	#If x==y
	beq $t0,$t1,setZ
	#y+3
	addi $t1,$t1,3
	#If x==y+3
	beq $t0,$t1,setZNext
	add $v0,$0,$0
setZ:
	add $v0,$t0,$t1
	j ret
	#z=x-y
setZNext:
	sub $v0,$t0,$a0
	j ret
ret:
	jr $ra
	#z=x+y