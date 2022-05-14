# Descricao: implementa uma funcao que retorna o resultado da soma dos n�meros A e B. 
# O valor retornado � armazenado na posi��o de mem�ria da vari�vel C
# 
# O main deve chamar a fun��o soma que recebe como par�metros os endere�os de A e B, retornando o valor da soma. 
# A passagem de par�metros e o retorno do valor devem 
# ser realizados atrav�s da pilha
#
# Pseudo-C�digo
#
# void main()
# {
#    < declara��es de vari�veis necess�rias >
#
#      C = soma(A,B);
# }
#
# int soma(int A, int B)
#{
#    return (A+B);
# }

        
        .text                  
        .globl  main           
main:	la	$t0, A	
	# lw	$t0, 0($t0)	
	la	$t1, B
	# lw	$t1, 0($t1)
	
	addiu	$sp, $sp, -8	# abre espa�o de 8 bytes na pilha
	sw	$t0, 0($sp)	# armazena (push) o endere�o de A na pilha
	sw	$t1, 4($sp)	# armazena (push) o endere�o de B na pilha
	jal	soma		# chama a funcao soma
	lw	$t2, 0($sp)	# recupera da pilha (pop) o resultado armazenado pela funcao soma
	addiu	$sp, $sp, 4	# ajusta o ponteiro da pilha
	la	$t0, C
	sw	$t2, 0($t0)	# armazena o resultado da soma na posicao de mem�ria da vari�vel C
	
	li $v0, 10
	syscall
	
soma:	lw	$t0, 0($sp)	# recupera (pop) da pilha o endere�o de A
	lw	$t1, 4($sp)	# recupera (pop) da pilha o endere�o de B
	addiu	$sp, $sp, 8	# ajusta o ponteiro da pilha
	lw	$t0, 0($t0)	# carrega valor de A
	lw	$t1, 0($t1)	# carrega valor de B
	addu	$t3, $t0, $t1	# $t3 <- A+B
	addiu	$sp, $sp, -4	# abre espa�o de 4 bytes na pilha
	sw	$t3, 0($sp)	# armazena (push) o conte�do de $t3 na pilha
	jr $ra			# retorna 
	
	.data
	A: .word 1
	B: .word 2
	C: .word 0