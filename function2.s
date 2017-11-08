#
#int main()
#{
#    int a = 5;
#    int b = 6;
#
#    setvalues(a, b)
#    printf("A is %d and B is %d\n", a, b);
#}
#
#void setvalues(int a, int b)
#{
#    a += 10;
#    b += 20;
#    printf("A is %d, B is %d\n", a, b);
#}
#
.data
a:	.word 5
bb:	.word 6
str0:	.asciiz "A is "
str1:	.asciiz ", B is "
newline: .asciiz "\n"

.text
main:
	#load arguments for method

	#$a0 is the value of a
	lw $a0, a
	#$a1 is the value of bb
	lw $a1, bb

	#call method
	jal setvalues
	nop

	#new line
	la $a0, newline
	li $v0, 4
	syscall

	#print "A is "
	la $a0, str0
	li $v0, 4
	syscall
	
	#print a
	lw $a0, a
	li $v0, 1
	syscall

	#print ", B is "
	la $a0, str1
	li $v0, 4
	syscall
	
	#print a
	lw $a0, bb
	li $v0, 1
	syscall

	#close output
	li $v0, 10
	syscall

setvalues:
	#a += 10
	addi $a0, $a0, 10
	
	#bb += 20
	addi $a1, $a1, 20

	#a0 used for output
	move $a2, $a0

	#print "A is "
	la $a0, str0
	li $v0, 4
	syscall

	#print a
	move $a0, $a2
	li $v0, 1
	syscall

	#print ", B is "
	la $a0, str1
	li $v0, 4
	syscall

	#print bb
	move $a0, $a1
	li $v0, 1
	syscall

	#end method
	jr $ra