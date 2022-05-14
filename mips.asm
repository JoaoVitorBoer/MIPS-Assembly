        
        .text                   
        .globl  main            
main:
          la    $a0,LC3        
	  li    $v0,4        # Imprime "Digite o nro de elementos do vetor: "
  	  syscall   

	  li    $v0, 5          
	  syscall            # Leitura de um inteiro. Lembre-se que o valor digitado no teclado será armazenado no registrador $v0 (olhar tabela de códigos syscall) 
  	  move  $t1, $v0     # Move o valor armazenado em $v0 para $t1. Registrador $t1 contem o tamanho do vetor
         
          la    $t0,array    # register $t0 contains the address of array
          xor   $s0,$s0,$s0  # garantir que o registrador esta inicializado com 0

le_vetor: beq   $s0, $t1, processa         
          
          la    $a0,LC4        
	  li    $v0,4        # Imprime "Digite o valor do elemento "
  	  syscall   

	  move	$a0, $s0     # contador de elementos  	
	  li    $v0, 1       # Imprime o nro do elemento
  	  syscall   

	  la    $a0,LC5        
	  li    $v0,4        # Imprime ": "
  	  syscall   


	  li    $v0, 5          
	  syscall            # Leitura de um inteiro. Lembre-se que o valor digitado no teclado será armazenado no registrador $v0 (olhar tabela de códigos syscall) 
  	  
          sw	$v0, 0($t0)
          
          addiu $t0, $t0, 4
          addiu $s0,$s0, 1
          
          j le_vetor
         
processa: la $t0, array         
loop:	  beq	 $t1, $zero, end
          lw     $t3,0($t0)      # get array element
          
          
          andi   $t3,$t3,1       # test if bit0 = 0 or bit0 = 1
          
          
          beq	 $t3, $zero, par # if bit0=0 "par" else "impair"
          addiu	 $t4, $t4,1	 # update cont_impar
	  j	continua
par:	  addiu	$t5,$t5,1        # update cont-par

continua: addiu   $t0,$t0,4      # update array pointer. Remember, 1word=4 memory addresses
          addiu   $t1,$t1,-1     # decrement array size counter
          j       loop           # continue execution
        
end:      la    $a0,LC1        
	  li    $v0,4        		# Imprime "Quantidade de numeros pares: "
  	  syscall

	  move	$a0, $t5	
	  li    $v0, 1           
  	  syscall

          la    $a0,LC2        
	  li    $v0,4        		# Imprime "Quantidade de numeros impares: "
  	  syscall

	  move	$a0, $t4	
	  li    $v0, 1           
  	  syscall


	  li $v0, 10
	  syscall       

        .data                   
LC1:	.asciiz "\nQuantidade de numeros pares: "
LC2:	.asciiz "\nQuantidade de numeros impares: "
LC3:	.asciiz "Digite o nro de elementos do vetor: "
LC4:	.asciiz "Digite o valor do elemento "
LC5:	.asciiz ": "
array:  .word 0