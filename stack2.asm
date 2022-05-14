# Descricao: implementa uma funcao que retorna o resultado da soma dos números A e B. 
# O valor retornado é armazenado na posição de memória da variável C
# 
# O main deve chamar a função soma que recebe como parâmetros os endereços de A e B, retornando o valor da soma. 
# A passagem de parâmetros e o retorno do valor devem 
# ser realizados através da pilha
#
# Pseudo-Código
#
# void main()
# {
#    < declarações de variáveis necessárias >
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
	
	addiu	$sp, $sp, -8	# abre espaço de 8 bytes na pilha
	sw	$t0, 0($sp)	# armazena (push) o endereço de A na pilha
	sw	$t1, 4($sp)	# armazena (push) o endereço de B na pilha
	jal	soma		# chama a funcao soma
	lw	$t2, 0($sp)	# recupera da pilha (pop) o resultado armazenado pela funcao soma
	addiu	$sp, $sp, 4	# ajusta o ponteiro da pilha
	la	$t0, C
	sw	$t2, 0($t0)	# armazena o resultado da soma na posicao de memória da variável C
	
	li $v0, 10
	syscall
	
soma:	lw	$t0, 0($sp)	# recupera (pop) da pilha o endereço de A
	lw	$t1, 4($sp)	# recupera (pop) da pilha o endereço de B
	addiu	$sp, $sp, 8	# ajusta o ponteiro da pilha
	lw	$t0, 0($t0)	# carrega valor de A
	lw	$t1, 0($t1)	# carrega valor de B
	addu	$t3, $t0, $t1	# $t3 <- A+B
	addiu	$sp, $sp, -4	# abre espaço de 4 bytes na pilha
	sw	$t3, 0($sp)	# armazena (push) o conteúdo de $t3 na pilha
	jr $ra			# retorna 
	
	.data
	A: .word 1
	B: .word 2
	C: .word 0