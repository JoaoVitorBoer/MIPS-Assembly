# {
#    < declarações de variáveis necessárias >
#
#    for(i=0; i<size; i++)
#      C[i] = soma( A[], B[], i);
# }
#
# int soma_vet(int A[], int B[], int i)
#{
#    return (A[i]+B[i]);
# }

        
        .text                  
        .globl  main           
main:
        	la      $a0,A           # registrador $a0 contém o endereço do vetor A (parametro da função)
        	la	$a1,B		# registrador $a1 contém o endereço do vetor B (parametro da função)
        	
        	addiu 	$sp, $sp, -12
        	sw	$a0, 0($sp)
        	sw	$a1, 4($sp)
        	
        	la      $s0,C           # registrador $s0 contém o endereço do vetor C
        	
        	la 	$s1, size	# registrador $s1 contém o endereço da variável size
        	lw	$s1, 0($s1)     # registrador $s1 agora contém o valor da variável size
        	
        	li 	$a2, 0		# registrador $a2 contém o valor da variavel "i" (parametro da função)
        	sw	$a2, 8($sp)
        	
loop:		beq	$s1, $zero, fim
		
        	jal	soma_vet	# chama a subrotina
        	
        	mulu	$t0, $a2, 4 
        	addu	$t0, $t0, $s0   # calculo do endereço C[i] (C[]+indice*4)
        	
        	lw	$t6, 0($sp)
        	addiu	$sp, $sp, 4
        	
        	sw	$t6, 0($t0)     # armazenamento do valor calulado pela funcao na posição C[i]
        	
        	addiu	$a2, $a2, 1     # i++
        	sw	$a2, 8($sp)
        	
        	addiu	$s1, $s1, -1    # controle do loop
        	j	loop

fim:		addiu $sp, $sp, 12
		li $v0, 10
		syscall      	
        	
soma_vet:	lw	$t6, 8($sp)
		lw	$t7, 0($sp)
		lw	$t8, 4($sp)

		mulu	$t3, $t6, 4
		addu	$t4, $t7, $t3
		lw      $t0, 0($t4)      # carrega o valor da posição A[i]
		
		addu	$t5, $t8, $t3
		lw	$t1, 0($t5)      # carrega o valor da posição A[i]
		
		addu	$t0, $t0, $t1    # retorna em $v0 o valor da soma de A[i]+B[i]
		
		addiu	$sp, $sp, -4
		sw	$t0, 0($sp)
		
		jr	$ra              # retorno da função  

        .data                  
A:     .word   0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
B:     .word   0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
C:     .word   0x0  0x0  0x0 0X0  0x0   0x0   0x0  0X0  0x0  0x0  0x0 
                                
size:   .word   11              