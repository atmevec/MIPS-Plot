############### quadPlot.asm ##################
# Alexander Mevec                             #
# quadPlot.asm                                #
# Description                                 #
#     Ask for A, B, C                         #
#     Program receives input                  #
#     Program calculates (ax + B)x + c        #
#     Program displays the resulting graph    #
#     Program exits when complete             #
# Program Logic                               #
# 1.  display a message from data area        #
# 2.  store input                             #
# 3.  display a message from data area        #
# 4.  store input                             #
# 5.  display a message from data area        #
# 6.  store input                             #
# 7.  display a message from data area        #
# 8.  store input                             #
# 9.  display a message from data area        #
# 10. store input                             #
# 11. calculate Ax                            #
# 12. calculate Ax + B                        #
# 13. calculate (Ax + B)x                     #
# 14. calculate (Ax + B)x + C (f(x))          #
# 15. if y = f(x) display "*" and jump to 20  #
# 17. if (x == 0) display "|" and jump to 20  #
# 18. if (y == 0) display "-" and jump to 20  #
# 19. display " "                             #
# 20. if (x == x2) display "\n" and jump to 24#
# 21. x++ and go to 11                        #
# 22. if (y == ymin) jump to eop              #
# 23. y-- jump to 11 (reset x)                #
###############################################

        .text
        .globl __start
__start:
        la $a0,p1   # Display the message in p1
        li $v0,4    # v0 = 4 indicates display a string
        syscall     # Call to system

	li $v0,5    # v0 = 5, indicates read an int
	syscall     # Call to system

	# t0 = A
	move $t0,$v0

	la $a0,p2   # Display the message in p2
	li $v0,4    # v0 = 4 indicates display a string
	syscall     # Call to system

	li $v0,5    # v0 = 5, indicates read an int
	syscall

	# t1 = B
	move $t1,$v0

	la $a0,p3   # Display the message in p3
        li $v0,4    # v0 = 4 indicates display a string
        syscall     # Call to system

	li $v0,5    # v0 = 5, indicates read an int
	syscall     # Call to system

	# t2 = C
	move $t2,$v0

	la $a0,p4   # Display the message in p4
        li $v0,4    # v0 = 4 indicates display a string
        syscall     # Call to system

	li $v0,5    # v0 = 5, indicates read an int
	syscall     # Call to system

	# t3 = X1
	move $t3,$v0

        # t8 = X1
        move $t8,$t3

	la $a0,p5   # Display the message in p5
        li $v0,4    # v0 = 4 indicates display a string
        syscall     # Call to system

	li $v0,5    # v0 = 5, indicates read an int
	syscall     # Call to system

	# t4 = X2
	move $t4,$v0

	la $a0,p6   # Display the message in p6
        li $v0,4    # v0 = 4 indicates display a string
        syscall     # Call to system

	li $v0,5    # v0 = 5, indicates read an int
	syscall     # Call to system

	# t5 = ymin
	move $t5,$v0

	la $a0,p7   # Display the message in p7
        li $v0,4    # v0 = 4 indicates display a string
        syscall     # Call to system

	li $v0,5    # v0 = 5, indicates read an int
	syscall     # Call to system

	# t6 = ymax
	move $t6,$v0

	j loop

loop:
	# t7 = ax
	mul $t7,$t0,$t3

	# t7 = ax + b
	add $t7,$t7,$t1

	# t7 = (ax + b)x
	mul $t7,$t7,$t3

	# t7 = (ax + b)x + c
	add $t7,$t7,$t2

	# if y == f(x) go to st
	beq $t7,$t6,st

	# if (x==0) go to lin
	beqz $t3,lin

	# if (y==0) go to dsh
	beqz $t6,dsh

	la $a0,space   # Display the message in space
        li $v0,4    # v0 = 4 indicates display a string
        syscall     # Call to system

	j xCheck

lin:
	la $a0,line   # Display the message in line
        li $v0,4    # v0 = 4 indicates display a string
        syscall     # Call to system

	j xCheck

st:
	la $a0,star   # Display the message in star
        li $v0,4    # v0 = 4 indicates display a string
        syscall     # Call to system

	j xCheck

dsh:
	la $a0,dash   # Display the message in dash
        li $v0,4    # v0 = 4 indicates display a string
        syscall     # Call to system

	j xCheck

newline:
	la $a0,nl   # Display the message in nl
        li $v0,4    # v0 = 4 indicates display a string
        syscall     # Call to system

	j yCheck

yCheck:
	# if (y==ymin)
	beq $t5,$t6,eop

	# y--
	sub $t6,1

	# x = x1
	move $t3,$t8

	#jump to loop
	j loop

xCheck:
	# if (x==x2)
	beq $t3,$t4,newline
	
	# x++
	add $t3,1
	
	j loop

eop:
        li $v0,10   # End Of Program	
        syscall     # Call to system

        .data
p1:	.asciiz   "Enter integer coefficient A: "
p2:	.asciiz   "Enter integer coefficient B: "
p3:     .asciiz   "Enter integer coefficient C: "
p4:     .asciiz   "Enter integer X1: "
p5:	.asciiz   "Enter integer X2: "
p6:     .asciiz   "Enter integer ymin: "
p7:     .asciiz   "Enter integer ymax: "
p8:	.asciiz   "Repeat (1-yes 0-no): "
star:	.asciiz   "*"
space:	.asciiz   " "
dash:	.asciiz   "-"
line:   .asciiz   "|"
nl:	.asciiz   "\n"

############# OUTPUT ##############
# Enter integer coefficient A: 1  #
# Enter integer coefficient B: -1 #
# Enter integer coefficient C: -6 #
# Enter integer X1: -10           #
# Enter integer X2: 10            #
# Enter integer ymin: -10         #
# Enter integer ymax: 10          #
#           |                     #
#           |                     #
#           |                     #
#           |                     #
#        *  |   *                 #
#           |                     #
#           |                     #
#           |                     #
#           |                     #
#           |                     #
# --------*-|--*-------           #
#           |                     #
#           |                     #
#           |                     #
#          *| *                   #
#           |                     #
#           **                    #
#           |                     #
#           |                     #
#           |                     #
#           |                     #
###################################