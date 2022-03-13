########### RAT Table ############
# $v0=10, $a2=10, $t1=10, $s2=10 #
#           $t2=2026             #
#            $s0=90              #
#            $s1=9               #
##################################

# Variables in RAM
.data
   low: .asciiz "low="
   high: .asciiz " high=" # Need a space here
   quotient: .asciiz "quotient = "
   #array of length 10 from 0 to 9
   A: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
   size: .word 0
   answer: .word 0
   newLine: .asciiz "\n"

.text  # Code
# Init vars here
lw $t1, size #t1 is the current index
lw $t2, answer #t2 stores sum
  funcQ5: 
	bge $t1, 10, end_loop  # loop 10 times
	mul $t3, $t1, 4 #int is 4 bytes long
	lw $t3, A($t3) #A[i]
	add $t2, $t2, $t3 #sum plus value of A[i]
	add $t1, $t1, 1 #increment i
	mul $t2, $t2, 2 # mulitply itself by 2
 	j funcQ5 # loop
  end_loop:

	#print sum
	li $v0, 1
	move $a0, $t2
	syscall

   main: #main()
       addi $s0, $zero, 90 # High = 90
       addi $s1, $zero, 9 # Low = 9
       div $s2, $s0, $s1        # Divide high by low to yield quotient
       la $a1,A # load array A[]
       la $a2,10 # Place length into Array, A[10] 
       # Print a new line
       li $v0,4  # syscall for asciiz printing
       la $a0,newLine # Load into $a0
       syscall
       # Print "Low="
       li $v0,4
       la $a0,low
       syscall
       #Print low var value
       li $v0,1
       addi $a0,$s0,0
       syscall
       #Print " high="
       li $v0,4
       la $a0,high
       syscall
       #Print high var value
       li $v0,1
       addi $a0,$s1,0
       syscall
       #Print newLine with "\n"
       li $v0,4
       la $a0,newLine
       syscall
       #Print "quotient = "
       li $v0,4
       la $a0,quotient
       syscall
       #Print quotient var val
       li $v0,1
       addi $a0,$s2,0
       syscall
       #Print newLine with "\n"
       li $v0,4
       la $a0,newLine
       syscall
       #End of main
       #Proper exit code
       li $v0,10
       syscall
 
