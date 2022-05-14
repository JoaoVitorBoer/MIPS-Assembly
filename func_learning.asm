# Descricao: implementa uma funcao que retorna o resultado da soma dos números A e B. O valor retornado é armazenado na posição de memória da variável C
# 
# O main deve chamar a função soma que recebe como parâmetros os endereços de A e B, retornando o valor da soma. A passagem de parâmetros e o retorno do valor seguem 
# as convenções do MIPS, ou seja, parametros através dos registradores $a0 a $a3 e o resultado através do registrador $v0
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
main:	la	$a0, A		# coloca o valor do 1o parametro no registrador $a0
	la	$a1, B		# coloca o valor do 2o parametro no registrador $a1
	jal	soma		# chama a funcao soma
	la	$t0, C
	sw	$v0, 0($t0)	# armazena o resultado da soma na posicao de memória da variável C
	
	li $v0, 10
	syscall
	
soma:	lw	$a0, 0($a0)	# carrega valor de A
	lw	$a1, 0($a1)	# carrega valor de B
	addu	$v0, $a0, $a1	# retorna o resultado da soma no registrador $v0
	jr $ra
	
	.data
	A: .word 1
	B: .word 2
	C: .word 0