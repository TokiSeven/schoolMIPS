li $v0, 5
li $t1, 5
li $t2, 4
li $t3, 1
cycle: 
	beq $t2, 0, end
	li $t4, 5
	addu $t5, $0, $v0
	multiply:
		beq $t4, 0, next
		addu $v0, $v0, $t5
		subu $t4, $t4, $t3
		b multiply
	next:
		subu $v0, $v0, $t5
		subu $t2, $t2, $t3
	b cycle
end: b end








