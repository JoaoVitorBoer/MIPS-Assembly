# TP4 - FUNDAMENTOS DE SISTEMAS DIGITAIS - JOÃO VITOR BOER ABITANTE E GUILHERME KOLLET


#Dicionário:	
#		t0 = n
#	  	t1 = i
#	  	t2 = auxiliar usada na hora de contar o valor de K.				
#		t3 = Vetor A
# 		t4 = Vetor B
#		t5 = Vetor C
#		t6 = Vetor D
#		t7 = k
#		t8 = auxiliar
#		t9 = Menor valor entre da média entre A, B, C
#		s0 = Vm de A
#		s1 = Vm de B
#		s2 = Vm de C


.text
	.globl main
	
main: 

	la $t0, n 			# Carrega o endereço de n em $t0.
	lw $t0, 0($t0) 		# Carrega o conteudo de n em $t0.
		
	xor $t1,$t1,$t1		# zera o i.
	xor $t2, $t2, $t2   
	
	la $t3, A 			# Carrega o endereço base do vetor A.
	la $t4, B			# Carrega o endereço base do vetor B.
	la $t5, C			# Carrega o endereço base do vetor C.
	la $t6, D			# Carrega o endereço base do vetor D.	
	
	
	
LOOP1:	addi $t1, $t1, 1   		  # Loop que faz a soma dos itens do vetor A e salva em $s0 o valor total.

		lw $t8, 0($t3)
		
		add $s0,$s0,$t8
		addi $t3,$t3,4
		
		blt $t1, $t0, LOOP1 	


MEDIA_A:	div $s0, $s0, $t0	 # Divide a soma total ($s0) do Vetor A pelo número de itens do vetor = n.
	 		

RESET:	    xor $t1,$t1,$t1		 # Reseta os vetores auxiliares para 0 e posições inciais.
	    	xor $t8,$t8,$t8	
	    	la $t3, A			
	    		

LOOP2: 	addi $t1, $t1, 1  		 # Loop que faz a soma dos itens do vetor B e salva em $s1 o valor total.

		lw $t8, 0($t4)
	
		add $s1,$s1,$t8
		addi $t4,$t4,4
		
		blt $t1, $t0, LOOP2 	


MEDIA_B: div $s1,$s1,$t0		# Divide a soma total ($s1) do Vetor B pelo número de itens do vetor = n.
		 
			
RESET2:		xor $t1,$t1,$t1 	
	     	xor $t8,$t8,$t8	
			la $t4, B			


LOOP3:	addi $t1, $t1, 1 		# Loop que faz a soma dos itens do vetor C e salva em $s2 o valor total.
		
		lw $t8, 0($t5)
		
		add $s2,$s2,$t8
		addi $t5,$t5,4
		
		blt $t1, $t0, LOOP3 
	
	
MEDIA_C:	div $s2,$s2,$t0		# Divide a soma total ($s2) do Vetor C pelo número de itens do vetor = n.


RESET3:		xor $t1,$t1,$t1
	      	xor $t8,$t8,$t8	
			la $t5, C		
				
				
VERIFICA_MENOR_VM: 	blt $s0, $s1, LA_s0		# Sequencia de If´s que verificam qual das médias entre $s0, $s1, $s2 é menor.
			 		j ELSE 					# Compara s0 e s1, se s0 for menor ele  vai para LA_s0 que salva o valor de $s2 em $t9, e em seguida para o LOOP_A que é a continuação do programa.	
 											# Se essa condição for falsa, ele vai para outra verificação e segue o fluxo e a mesma lógica.
ELSE:  blt $s1, $s2, LA_s1						
		la $t9,($s2)
		j LOOP_A             
                        
LA_s0:	la $t9,($s0)
		j LOOP_A
	
LA_s1:	la $t9,($s1)
		j LOOP_A		
	
	

	
	
LOOP_A:	addi $t1, $t1, 1 					# LOOP_X, onde X corresponde ao vetor.
											# Loop´s que varrem os vetores e adicionam todos os números maiores que a média mínima(%s0 = 400) no vetor D($t6).
		lw $t8, 0($t3)	
		bgt $t8, $t9, CONTINUA_LOOP_A	
		
		sw $t8, 0($t6) 
		
		addi $t6, $t6, 4
		addi $t2,$t2,1						# Utiliza de uma auxliar $t2 que é incrementada para futuramente saber o k($t7).


CONTINUA_LOOP_A:  addi $t3, $t3, 4	
		 	 	  blt $t1, $t0, LOOP_A
		
	
RESET4:  xor $t1,$t1,$t1	 
	     xor $t8, $t8, $t8
	                 
	                               
LOOP_B:	addi $t1, $t1, 1 
		
		lw $t8, 0($t4)	
		bgt $t8, $t9, CONTINUA_LOOP_B	
		
		sw $t8, 0($t6) 
		
		addi $t6, $t6, 4
		addi $t2,$t2,1						# Utiliza de uma auxliar $t2 que é incrementada para futuramente saber o k($t7).

CONTINUA_LOOP_B:	addi $t4, $t4, 4	
					blt $t1, $t0, LOOP_B
							
																																																					
RESET5:  xor $t1,$t1,$t1	 
	     xor $t8, $t8, $t8
	                 	
	                                                                                                                    
LOOP_C:	addi $t1, $t1, 1 
		
		lw $t8, 0($t5)	
		bgt $t8, $t9, CONTINUA_LOOP_C	
		
		sw $t8, 0($t6) 
		
		addi $t6, $t6, 4
		addi $t2,$t2,1						# Utiliza de uma auxliar $t2 que é incrementada para futuramente saber o k($t7).
		

CONTINUA_LOOP_C:	addi $t5, $t5, 4	
       	            blt $t1, $t0, LOOP_C	
  
  

       	 														     	 														     	 																										     	 														     	 														
STORE_K:	la $t7, k						# Armazena o valor de $t2, que corresponde ao tamanho do Vetor D, na primeira posição do $t7( t7 = K ).
		 	sw $t2, 0($t7)
		  
RESET_FINAL:	xor $t1,$t1,$t1				# Reset final nas auxiliares só para ficar bonitinho na tabela dos registradores.
				xor $t2, $t2, $t2	 		    		
	     	 	xor $t8, $t8, $t8		  
end: j end


.data

n: .word 6
k: .word 0
A: .word 900, 150, 350, 200, 700, 100   # Média de 400
B: .word 750, 536, 984, 163, 597, 570   # Média de 600
C: .word 425, 800, 269, 632, 468, 406	# Média de 500
D: .word 0								
