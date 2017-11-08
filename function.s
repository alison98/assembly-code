#
#int main()
#{
#    int a = 5;
#    int b = 6;
#
#    setvalues(&a, &b);
#    printf("A is %d and B is %d\n", a, b);
#}
#
#void setvalues(int*  a, int*   b)
#{
#    *a = *a + 10;
#    *b = *b + 10;
#    printf("A is at %p, and contains %d\n", a, *a);
#    printf("B is at %p, and contains %d\n", b, *b);
#}
#

.data
a:	.word 5
bb:	.word 6
str0:	.asciiz "A is at "
str1:	.asciiz "B is at "
str2:	.asciiz ", and contains "
str3:	.asciiz "A is "
str4:	.asciiz ", B is "
newline: .asciiz "\n"

.text
main:
	#load arguments for method
	
	#a0 is the pointer to a
	la $a0, a
	#a1 is the pointer to bb
	la $a1, bb

	#call method
	jal setvalues
	nop

	#"\n"
	la $a0, newline
	li $v0, 4
	syscall

	#print "A is "
	la $a0, str3
	li $v0, 4
	syscall

	#print a
	lw $a0, a
	li $v0, 1
	syscall

	#print ", B is "
	la $a0, str4
	li $v0, 4
	syscall

	#print bb
	lw $a0, bb
	li $v0, 1
	syscall

	#close output
	li $v0, 10
	syscall

setvalues:
	#save s0 and s1 to stack so they can be used temporarily
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	#move a0 to a2 so a0 can be used for output
	move $a2, $a0

	#store the values of a and b to s0 and s1
	lw $s0, 0($a2)
	lw $s1, 0($a1)

	#*a += 10
	addi $s0, $s0, 10
	sw $s0, 0($a2)
	#*b += 20
	addi $s1, $s1, 20
	sw $s1, 0($a1)

	#print "A is at "
	la $a0, str0
	li $v0, 4
	syscall
	
	#print pointer to a
	move $a0, $a2
	li $v0, 1
	syscall

	#print ", and contains "
	la $a0, str2
	li $v0, 4
	syscall

	#print a
	move $a0, $s0
	li $v0, 1
	syscall

	#"\n"
	la $a0, newline
	li $v0, 4
	syscall

	la $a0, str1
	li $v0, 4
	syscall

	move $a0, $a1
	li $v0, 1
	syscall

	la $a0, str2
	li $v0, 4
	syscall

	move $a0, $s1
	li $v0, 1
	syscall

	lw $s1, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 8

	jr $ra