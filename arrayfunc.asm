# MARS example: Manipulating arrays
# Author:  
# Function: implementa uma funcao que retorna o resultado da soma do conteúdo de duas posições de dois vetores (A[i]+B[i]). 
# O valor retornado é armazenado em um terceiro vetor (C[i]=A[i]+B[i])
# 
# O main deve chamar a função soma_vet que recebe como parâmetros os endereços dos dois vetores e o índice da posição, retornando o valor da soma. 
# A passagem de parâmetros e o retorno do valor seguem 
# as convenções do MIPS, ou seja, parametros atraves dos registradores $a0 a $a3 e o resultado do somatorio é retornado atraves do registrador $v0
#
# Pseudo-Código
#
# void main()
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
        	
        	la      $s0,C           # registrador $s0 contém o endereço do vetor C
        	
        	la 	$s1, size	# registrador $s1 contém o endereço da variável size
        	lw	$s1, 0($s1)     # registrador $s1 agora contém o valor da variável size
        	
        	li 	$a2, 0		# registrador $a2 contém o valor da variavel "i" (parametro da função)
        	
loop:		beq	$s1, $zero, fim
		
        	jal	soma_vet	# chama a subrotina
        	
        	mulu	$t0, $a2, 4 
        	addu	$t0, $t0, $s0   # calculo do endereço C[i] (C[]+indice*4)
        	sw	$v0, 0($t0)     # armazenamento do valor calulado pela funcao na posição C[i]
        	
        	addiu	$a2, $a2, 1     # i++
        	addiu	$s1, $s1, -1    # controle do loop
        	j	loop

fim:		li $v0, 10
		syscall      	
        	
soma_vet:	mulu	$t3, $a2, 4
		addu	$t4, $a0, $t3
		lw      $t0, 0($t4)      # carrega o valor da posição A[i]
		
		addu	$t5, $a1, $t3
		lw	$t1, 0($t5)      # carrega o valor da posição B[i]
		
		addu	$v0, $t0, $t1    # retorna em $v0 o valor da soma de A[i]+B[i]
		
		jr	$ra              # retorno da função  

        .data                  
A:     .word   0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
B:     .word   0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
C:     .word   0x0  0x0  0x0 0X0  0x0   0x0   0x0  0X0  0x0  0x0  0x0 
                                
size:   .word   11              