li $v0, 0
li $t1, 3 
li $t3, 1 
move $t4,$t1 
multiply: 
	beq $t4, 0, next
	addu $v0, $v0, $t1 
	subu $t4, $t4, $t3 
	b multiply 
next: 
	addu $v0, $v0, $t1 
	addu $v0, $v0, $t1 
	addiu $v0, $v0, 10 
end: b end
