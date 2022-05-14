# MARS example: Manipulating arrays
# Author:  
# Function: implementa uma funcao que retorna o resultado da soma do conte�do de duas posi��es de dois vetores (A[i]+B[i]). 
# O valor retornado � armazenado em um terceiro vetor (C[i]=A[i]+B[i])
# 
# O main deve chamar a fun��o soma_vet que recebe como par�metros os endere�os dos dois vetores e o �ndice da posi��o, retornando o valor da soma. 
# A passagem de par�metros e o retorno do valor seguem 
# as conven��es do MIPS, ou seja, parametros atraves dos registradores $a0 a $a3 e o resultado do somatorio � retornado atraves do registrador $v0
#
# Pseudo-C�digo
#
# void main()
# {
#    < declara��es de vari�veis necess�rias >
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
        	la      $a0,A           # registrador $a0 cont�m o endere�o do vetor A (parametro da fun��o)
        	la	$a1,B		# registrador $a1 cont�m o endere�o do vetor B (parametro da fun��o)
        	
        	la      $s0,C           # registrador $s0 cont�m o endere�o do vetor C
        	
        	la 	$s1, size	# registrador $s1 cont�m o endere�o da vari�vel size
        	lw	$s1, 0($s1)     # registrador $s1 agora cont�m o valor da vari�vel size
        	
        	li 	$a2, 0		# registrador $a2 cont�m o valor da variavel "i" (parametro da fun��o)
        	
loop:		beq	$s1, $zero, fim
		
        	jal	soma_vet	# chama a subrotina
        	
        	mulu	$t0, $a2, 4 
        	addu	$t0, $t0, $s0   # calculo do endere�o C[i] (C[]+indice*4)
        	sw	$v0, 0($t0)     # armazenamento do valor calulado pela funcao na posi��o C[i]
        	
        	addiu	$a2, $a2, 1     # i++
        	addiu	$s1, $s1, -1    # controle do loop
        	j	loop

fim:		li $v0, 10
		syscall      	
        	
soma_vet:	mulu	$t3, $a2, 4
		addu	$t4, $a0, $t3
		lw      $t0, 0($t4)      # carrega o valor da posi��o A[i]
		
		addu	$t5, $a1, $t3
		lw	$t1, 0($t5)      # carrega o valor da posi��o B[i]
		
		addu	$v0, $t0, $t1    # retorna em $v0 o valor da soma de A[i]+B[i]
		
		jr	$ra              # retorno da fun��o  

        .data                  
A:     .word   0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
B:     .word   0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
C:     .word   0x0  0x0  0x0 0X0  0x0   0x0   0x0  0X0  0x0  0x0  0x0 
                                
size:   .word   11              