.data
	# ————————————————————————— Jogador 1 ———————————————————————— #	

	p1_name:    	  .space  20		# Vetor de bytes para armazenar nome do primeiro jogador
	p1_input:   	  .space  16 		# Vetor de bytes para armazenar a mão do primeiro jogador 
	p1_symbols: 	  .space  5 		# Array de caracteres para armazenar o simbolo das cartas
	p1_suits:   	  .space  5		# Array de strings para armazenar o naipe das cartas
	p1_values:  	  .align  2		# Array de inteiros para armazenar o valor das cartas
		    	  .space  20		# Espaço em bytes (4 bytes * 5 posições)
	p1_force:   	  .word   0		# Variável que armazena a força da mão do primeiro jogador
	p1_combo:   	  .word   0,0,0,0	# Vetor auxiliar para aplicar critérios de desempate

	# ————————————————————————— Jogador 2 ———————————————————————— #	
			
	p2_name:    	  .space  20		# Vetor de bytes para armazenar nome do primeiro jogador
	p2_input:   	  .space  16 		# Vetor de bytes para armazenar a mão do primeiro jogador 
	p2_symbols: 	  .space  5 		# Array de caracteres para armazenar o simbolo das cartas
	p2_suits:   	  .space  5		# Array de strings para armazenar o naipe das cartas
	p2_values:  	  .align  2		# Array de inteiros para armazenar o valor das cartas
		    	  .space  20		# Espaço em bytes (4 bytes * 5 posições)
	p2_force:   	  .word   0		# Variável que armazena a força da mão do primeiro jogador
	p2_combo:   	  .word   0,0,0,0	# Vetor auxiliar para aplicar critérios de desempate
		
	# ——————————————————————— Mãos possíveis ——————————————————————— #		

	royal: 		  .asciiz "um ROYAL FLUSH"
	straight_flush:	  .asciiz "um STRAIGHT FLUSH"
	quadra: 		  .asciiz "uma QUADRA"
	full_house: 	  .asciiz "um FULL HOUSE"			
	flush:	 	  .asciiz "um FLUSH"
	straight: 	  .asciiz "uma SEQUÊNCIA"
	trinca: 		  .asciiz "uma TRINCA"
	pares:	 	  .asciiz "DOIS PARES"
	par: 		  .asciiz "um PAR"
	carta_alta: 	  .asciiz "uma CARTA ALTA"
	
	maos: .word carta_alta, par, pares, trinca, straight, flush, full_house, quadra, straight_flush, royal
		
	# ————————————————————————— Mensagens ———————————————————————— #	

	msg_start: 	  .asciiz "------------------------ Text-Based Poker ------------------------- \n"
	msg_separator: 	  .asciiz "------------------------------------------------------------------- \n"
	msg_registration: .asciiz "---------------------- Cadastro de Jogadores ---------------------- \n"
	msg_name: 	  .asciiz "Insira o nome do jogador "
	msg_welcome: 	  .asciiz "Seja bem-vindo, "
	msg_comma: 	  .asciiz ", "	
	msg_colons: 	  .asciiz ": "
	msg_blank_space:	  .asciiz " "	
	msg_new_hand: 	  .asciiz "Leitura das cartas de "
	msg_input: 	  .asciiz "Por favor, insira suas cartas (Ex.: 8c 9p Te Jo Qc): "
	msg_show: 	  .asciiz "Estas são suas cartas: "	
	msg_confirm: 	  .asciiz "\nDigite 1 para confirmar ou 0 para recomeçar: "	
	msg_warning: 	  .asciiz "Lembre-se de deixar apenas um espaço entre cartas.\nUse o símbolo T para representar a carta 10.\n"			
	msg_hand1: 	  .asciiz "Com essa mão você formou "
	msg_hand2: 	  .asciiz "Já você conseguiu formar "	
	msg_winner1: 	  .asciiz "Por isso o vencedor é o JOGADOR 1 com "
	msg_winner2: 	  .asciiz "Por isso o vencedor é o JOGADOR 2 com "
	msg_draw: 	  .asciiz "Por isso houve um EMPATE e pelos critérios de desempate "
	msg_draw0: 	  .asciiz "ambos \nvenceram (EMPATE).\n"		
	msg_draw1: 	  .asciiz "o vencedor \né o JOGADOR 1"	
	msg_draw2: 	  .asciiz "o vencedor \né o JOGADOR 2"	
	msg_congrats:	  .asciiz ".\nParabéns, "	
	msg_restart:	  .asciiz "Digite 1 para inserir novos jogadores, 2 para jogar outra mão ou 0 \npara encerrar: "
	msg_end: 	  .asciiz "--------------------------- FIM DE JOGO --------------------------- \n"
	
.text
	# ———————————————————————— Apresentação ——————————————————————— #	

	la $a0, msg_separator			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0

	la $a0, msg_start			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, msg_separator			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	# ————————————————————— Cadastro de jogadores ———————————————————— #	

	player_registration:	
	
	la $a0, msg_registration			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, msg_separator			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
			
	move $s7, $zero				# Inicializa contador de jogadores $s7; "player = 0"
	la $s0, p1_name				# Carrega endereço do label em $s0; "p_name = p1_name"
		
	new_player:

	la $a0, msg_name				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	addi $a0, $s7, 1				# Copia conteúdo de $s7 para $a0; "arg = player + 1"
	li $v0, 1	 			# Indica exibição de um inteiro em a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, msg_colons			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, ($s0)				# Carrega endereço do label em $a0; "arg = p_name"
	li $a1, 20				# Carrega tamanho da string em $a1
	li $v0, 8				# Indica leitura de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, msg_welcome			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, ($s0)				# Carrega endereço do label em $a0; "arg = p_name"
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, msg_separator			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0

	la $s0, p2_name				# Carrega endereço do label em $s0; "p_name = p2_name"

	addi $s7, $s7, 1				# incrementa contador de jogadores; "player += 1"
	beq $s7, 1, new_player			# Desvia caso exista apenas 1 jogador; Registra o jogador 2

	# ————————————————————— Leitura das mãos ———————————————————— #	

	move $s7, $zero				# Inicializa o contador de jogadores $s7; "player = 0"

	la $s0, p1_name				# Carrega endereço do label em $s0; "p_name = p1_name"
	la $s1, p1_input				# Carrega endereço do label em $s1; "p_input = p1_input"
	la $s2, p1_symbols			# Carrega endereço do label em $s2; "p_symbols = p1_symbols"
	la $s3, p1_suits				# Carrega endereço do label em $s3; "p_suits" = "p1_suits"
	la $s4, p1_values			# Carrega endereço do label em $s4; "p_values = p1_values"
	la $s5, p1_force				# Carrega endereço do label em $s5; "p_force = p1_force"

	li $t4, 1				# Indica salto da label warning;
	beq $t4, 1, new_hand			# Desvia fluxo na igualdade; Pula o warning
	
	warning: 
	
	la $a0, msg_warning			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	la $a0, msg_separator			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0									
			
	new_hand:
	
	sw $zero, ($s5)				# Inicializa a força da mão $s5; "p_force = 0"
	
	la $a0, msg_new_hand			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, ($s0)				# Carrega endereço do label em $a0; "arg = p_name"
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0		
	
	la $a0, msg_input			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	la $a0, ($s1)				# Carrega endereço do label em $a0; "arg = p_input"
	li $a1, 16				# Carrega tamanho da string em $a1
	li $v0, 8				# Indica leitura de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	move $t0, $zero				# Inicializa iterador do input; "i = 0"
	move $t1, $zero				# Inicializa iterador de simbolos/naipes; "j = 0"
	
	# ————————————————————— Tratamento da entrada ———————————————————— #	
	
	input_segmentation:
	
		beq $t1, 5, end_segmentation 	# Desvia para label na igualdade; "j == 5"
		
		add $t7, $s1, $t0		# Soma endereço da label $s1 com iterador $t0; "aux = p_input + i"
		lb $t2, ($t7)			# Carrega um valor do vetor em $t2; Copia simbolo da carta
		
		add $t7, $s2, $t1		# Soma endereço da label $s2 com iterador $t1; "aux = p_symbols + j"
		sb $t2, ($t7)			# Armazena o valor de $t2 no vetor; Salva simbolo da carta
		
		addi $t0, $t0, 1			# Incrementa iterador do input; "i += 1"
		
		add $t7, $s1, $t0		# Soma endereço da label $s1 com iterador $t0; "aux = p_input + i"
		lb $t2, ($t7)			# Carrega um valor do vetor em $t2; Copia naipe da carta
		
		add $t7, $s3, $t1		# Soma endereço da label $s3 com iterador $t1; "aux = p_suits + j"
		sb $t2, ($t7)			# Armazena o valor de $t2 no vetor; Salva naipe da carta
		
		addi $t0, $t0, 2			# Incrementa iterador do input; "i += 2"
		addi $t1, $t1, 1			# Incrementa iterador de simbolos/naipes; "j += 1"
		
		j input_segmentation		# Salta para inicio do laco;
	
	end_segmentation:
	
	move $t0, $zero				# Inicializa iterador do vetor de simbolos; "i = 0"
	move $t1, $zero				# Inicializa iterador do vetor de valores; "j = 0"
		
	# ————————————————————— Tradução símbolo --> valor ———————————————————— #		
		
	symbol_valuation:
	
		beq $t0, 5, end_valuation 	# Desvia para label na igualdade; "i == 5"

		add $t7, $s2, $t0		# Soma endereço da label $s2 com iterador $t0; "aux = p_symbols + i"
		lb $t2, ($t7)			# Carrega um valor do vetor em $t2; Copia símbolo da carta
		blt $t2, 58, numeric		# Desvia para label quando menor; É um algarismo (2 ~ 9)
		
		subi $t2, $t2, 3			# Subtrai 3 de $t2; Se é Ás, passa a valer 62
		beq $t2, 62, numeric		# Desvia para label na igualdade; É um Ás (A: 14p)
		
		subi $t2, $t2, 11		# Subtrai 11 de $t2; Se é Rei, passa a valer 61
		beq $t2, 61, numeric		# Desvia para label na igualdade; É um Rei (K: 13p)

		subi $t2, $t2, 1			# Subtrai 11 de $t2; Se é Valete, passa a valer 59
		beq $t2, 59, numeric		# Desvia para label na igualdade; É um Valete (J: 11p)
		
		subi $t2, $t2, 6			# Subtrai 11 de $t2; Se é Dama, passa a valer 60
		beq $t2, 60, numeric		# Desvia para label na igualdade; É uma Dama (Q: 12p)		
		
		subi $t2, $t2, 5			# Subtrai 11 de $t2; Se é Carta 10, passa a valer 58 (Carta 10: 10p)
						
		numeric:
		subi $t2, $t2, 48		# Transforma ASCII em inteiro
		
		add $t7, $s4, $t1		# Soma endereço da label $s4 com iterador $t1; "aux = p_values + j"
		sw $t2, ($t7)			# Armazena o valor de $t2 no vetor; Salva o valor da carta
		
		addi $t0, $t0, 1			# Incrementa iterador do input; "i += 1"
		addi $t1, $t1, 4			# Incrementa iterador do valores; "j += 1"
		
		j symbol_valuation		# Salta para inicio do laco; 
	
	end_valuation:
	
	la $a0, msg_show				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	

	# ————————————————————— Impressão das cartas ———————————————————— #
	
	move $t1, $zero				# Inicializa o iterador de caracteres $t1; "i = 0"
	
	printing:
	
		beq $t1, 5, end_printing		# Desvia para label na igualdade; "i == 5"

		add $t7, $s2, $t1		# Soma endereço da label $s2 com iterador $t1; "aux = p_symbols + i"
		lb $a0, ($t7) 			# Carrega valor do vetor em $a0; Copia simbolo da carta
		li $v0, 11	 		# Indica exibição de um caractere em a0
		syscall 				# Executa operação indicada por $v0
	
		add $t7, $s3, $t1		# Soma endereço da label $s3 com iterador $t1; "aux = p_suits + i"
		lb $a0, ($t7)	 		# Carrega valor do vetor em $a0; Copia naipe da carta
		li $v0, 11	 		# Indica exibição de um caractere em a0
		syscall 				# Executa operação indicada por $v0
		
		la $a0, msg_blank_space		# Carrega endereço do label em $a0
		li $v0, 4 			# Indica exibição de string em $a0
		syscall 				# Executa operação indicada por $v0
																	
		addi $t1, $t1, 1			# Incrementa iterador de caracteres; "i += 1"
		
		j printing			# Salta para início do laço
		
	end_printing: 	
	
	# ——————————— Confirmação e preparação para próxima leitura ———————————— #

	la $a0, msg_confirm			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	li $v0, 5				# Indica leitura de inteiro em $v0
	syscall 					# Executa operação indicada por $v0	
	
	move $t4, $v0				# Copia conteúdo de $v0 para $t4
	
	la $a0, msg_separator			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	bne $t4, 1, warning 			# Desvia para label na diferença; Reinicia leitura com warning
		
	la $s0, p2_name				# Carrega endereço do label em $s0; "p_name = p2_name"
	la $s1, p2_input				# Carrega endereço do label em $s1; "p_input = p2_input"
	la $s2, p2_symbols			# Carrega endereço do label em $s2; "p_symbols = p2_symbols"
	la $s3, p2_suits				# Carrega endereço do label em $s3; "p_suits" = "p2_suits"
	la $s4, p2_values			# Carrega endereço do label em $s4; "p_values = p2_values"
	la $s5, p2_force				# Carrega endereço do label em $s5; "p_force = p2_force"

	addi $s7, $s7, 1				# Incrementa contador de jogadores $s7; "player += 1" 		
	beq $s7, 1, new_hand			# Desvia para label na igualdade; Reinicia leitura para jogador 2
		
	# ———————————————————— Ordenação das mãos ——————————————————— #	
	
	move $s7, $zero				# Inicializa contador de jogadores; "player = 0"
							
	selection_sort:
			
	move $t1, $zero				# Inicializa iterador do laco externo; "i = 0"
	
	outer_loop:
	
	beq $t1, 16, end_outer_loop		# Desvia fluxo na igualdade; "i == n - 1"
	move $t2, $t1				# Inicializa indice do menor elemento; "s = i"
	add $t3, $t1, 4 				# Inicializa iterador do loop interno; "j = i + 1"
				
	inner_loop:
	
		beq $t3, 20, end_inner_loop	# Desvia fluxo na igualdade; "i == n"

		add $t7, $s4, $t3		# Soma endereço da label $s4 com iterador $t3; "aux = p_values + j"
		lw $t4, ($t7)			# Carrega um valor do vetor em $t4; "element = p_values[j]"

		add $t7, $s4, $t2		# Soma endereço da label $s4 com iterador $t2; "aux = p_values + m"
		lw $t5, ($t7)			# Carrega um valor do vetor em $t5; "smallest = p_values[s]"
		
		bge $t4, $t5, increment		# Desvia fluxo quando maior ou igual; "element >= smallest"
		move $t2, $t3 			# Move conteúdo de $t3 para $t2; Atualiza indice do menor "s = j";
		
		increment:
		addi $t3, $t3, 4			# Incrementa iterador do loop interno; "j += 1"
		
		j inner_loop			# Desvia para o inicio do laco
		
	end_inner_loop:

	add $t7, $s4, $t1			# Soma endereço da label $s4 com iterador $t1; "aux = p_values + i"
	lw $t4, ($t7)				# Carrega um valor do vetor em $t4; "element = p_values[i]"

	add $t7, $s4, $t2			# Soma endereço da label $s4 com iterador $t2; "aux = p_values + s"
	lw $t5, ($t7)				# Carrega um valor do vetor em $t4; "smallest = p_values[s]"

	add $t7, $s4, $t1			# Soma endereço da label $s4 com iterador $t1; "aux = p_values + i"						
	sw $t5, ($t7)				# Armazena o valor de $t5 no vetor; "p_values[i] = smallest"
	
	add $t7, $s4, $t2			# Soma endereço da label $s4 com iterador $t2; Vetor de valores							
	sw $t4, ($t7)				# Armazena o valor de $t4 no vetor; "p_values[s] = element"
	
	sra $t6, $t1, 2				# Ajusta iterador de 4 bytes para 1; valores --> naipes/simbolos
	sra $t7, $t2, 2				# Ajusta iterador de 4 bytes para 1; valores --> naipes/simbolos

	add $t0, $s3, $t6			# Soma endereço da label $s4 com iterador $t6; "aux = p_suits + i"
	lb $t4, ($t0)				# Carrega um valor do vetor em $t4; "element = p_suits[i]"
	
	add $t0, $s3, $t7			# Soma endereço da label $s3 com iterador $t7; "aux = p_suits + s"
	lb $t5, ($t0)				# Carrega um valor do vetor em $t4; "smallest = p_suits[s]"

	add $t0, $s3, $t6			# Soma endereço da label $s3 com iterador $t6; "aux = p_suits + i"
	sb $t5, ($t0)				# Armazena o valor de $t5 no vetor; "p_suits[i] = smallest"
	
	add $t0, $s3, $t7			# Soma endereço da label $s3 com iterador $t7; "aux = p_suits + s"
	sb $t4, ($t0)				# Armazena o valor de $t4 no vetor; "p_suits[s] = element"

	add $t0, $s2, $t6			# Soma endereço da label $s2 com iterador $t6; "aux = p_symbols + i"
	lb $t4, ($t0)				# Carrega um valor do vetor em $t4; "element = p_suits[i]"
	
	add $t0, $s2, $t7			# Soma endereço da label $s3 com iterador $t7; "aux = p_symbols + s"
	lb $t5, ($t0)				# Carrega um valor do vetor em $t5; "smallest = p_suits[s]"

	add $t0, $s2, $t6			# Soma endereço da label $s2 com iterador $t6; "aux = p_symbols + i"
	sb $t5, ($t0)				# Armazena o valor de $t5 no vetor; "p_suits[i] = smallest"
	
	add $t0, $s2, $t7			# Soma endereço da label $s3 com iterador $t7; "aux = p_symbols + s"
	sb $t4, ($t0)				# Armazena o valor de $t4 no vetor; "p_suits[s] = element"
		
	addi $t1, $t1, 4				# Incrementa contador externo; "i += 1"
	
	j outer_loop				# Salta para o início do laço
	
	end_outer_loop:
	
	addi $s7, $s7, 1				# incrementa contador de jogadores; "player += 1"		
	
	la $s0, p1_name				# Carrega endereço do label em $s0; "p_name = p1_name"
	la $s1, p1_input				# Carrega endereço do label em $s1; "p_input = p1_input"
	la $s2, p1_symbols			# Carrega endereço do label em $s2; "p_symbols = p1_symbols"
	la $s3, p1_suits				# Carrega endereço do label em $s3; "p_suits" = "p1_suits"
	la $s4, p1_values			# Carrega endereço do label em $s4; "p_values = p1_values"
	la $s5, p1_force				# Carrega endereço do label em $s5; "p_force = p1_force"
		
	beq $s7, 1, selection_sort		# Desvia caso exista apenas 1 jogador

	# ———————————————————— Identificação de FULL HOUSE ————————————————————— #			
	
	li $s7, 1				# Inicializa contador de jogadores	
	move $s6, $zero				# Inicializa a força da mão;	
	
	identification:
	
	move $t0, $zero				# Inicializa o iterador de valores; "i = 0"
	move $t1, $zero				# Inicializa o contador de igualdades; "c = 0"
	
	comparator_loop1:
	
		beq $t0, 20, end_loop1		# Condição de parada; "i == 5"
		
		addi $t2, $t0, 4			# Inicializa iterador auxiliar; "j = i + 1"
		
		add $t7, $s4, $t0		# Soma o endereço base do vetor com seu offset; "aux = p_values + i"
		lw $t3, ($t7)			# Carrega elemento da posicao i; "temp1 = V[i]"
		
		add $t7, $s4, $t2		# Soma o endereço base do vetor com seu offset; "p_values + j"
		lw $t4, ($t7)			# Carrega elemento da posicao j; "temp2 = V[i+1]"
		
		addi $t0, $t0, 4			# Incrementa iterador de valores; "i += 1"
		
		bne $t3, $t4, comparator_loop1	# Desvia fluxo na diferença; "V[i] != V[i+1]"
		addi $t1, $t1, 1			# Incrementa contador de igualdades; "c++";
		
		j comparator_loop1
		
	end_loop1:
	
	bne $t1, 3, end1				# Desvia fluxo na diferença; "c != 3"
	
	addi $t7, $s4, 4				# Soma o endereço base do vetor com seu offset; "p_values + 4"
	lw $t3, ($t7)				# Carrega elemento da posicao 1; "aux1 = V[1]"
	
	addi $t7, $s4, 12			# Soma o endereço base do vetor com seu offset; "p_values + 12"
	lw $t4, ($t7)				# Carrega elemento da posicao 3; "aux2 = V[3]"
	
	beq $t3, $t4, end1			# Desvia fluxo na diferença; "V[1] != V[3]"
	
	li $s6, 6 				# Alterar registrador de controle; Sinaliza existência do full house
	
	end1:			
		
	sw $s6, ($s5)				# Armazena a força da mão em "p_force"
	bne $s6, 0, first_check			# Salta para etapa de verificação															
																																																						
	# ————————————————————— Identificação de QUADRA ——————————————————————— #
		
	move $t0, $zero				# Inicializa o iterador de valores; "i = 0"
	move $t1, $zero				# Inicializa o contador de igualdades; "c = 0"
	
	comparator_loop2:
	
		beq $t0, 20, end_loop2		# Condição de parada; "i == 5"
		
		addi $t2, $t0, 4			# Inicializa iterador auxiliar; "j = i + 1"
		
		add $t7, $s4, $t0		# Soma o endereço base do vetor com seu offset; "p_values + i"
		lw $t3, ($t7)			# Carrega elemento da posicao i; "aux = V[i]"
		
		add $t7, $s4, $t2		# Soma o endereço base do vetor com seu offset; "p_values + j"
		lw $t4, ($t7)			# Carrega elemento da posicao j; "aux = V[i+1]"
		
		addi $t0, $t0, 4			# Incrementa iterador de valores; "i++"
		
		bne $t3, $t4, comparator_loop2	# Desvia fluxo na diferença; "V[i] != V[i+1]"
		addi $t1, $t1, 1			# Incrementa contador de igualdades; "c++";
		
		j comparator_loop2
		
	end_loop2:
	
	bne $t1, 3, end2				# Desvia fluxo na diferença; "c != 3"
	li $s6, 7 				# Alterar registrador de controle; Sinaliza existência da quadra
	
	end2:			
		
	sw $s6, ($s5)				# Carrega a força da mão em "p_force"
	bne $s6, 0, first_check			# Salta para etapa de verificação

		
	# —————————— Identificação de FLUSH, STRAIGHT, STRAIGHT FLUSH e ROYAL FLUSH ——————————— #				

	flush_def:
	
	move $t0, $zero				# Inicializa iterador; "i = 0"
	
	flush_start:
	
		beq $t0, 4, flush_set		# Condição de parada; "if (i == 4) flush = true"
	
		add $t7, $s3, $t0		# "aux = p_suits + i"
		lb $t1, ($t7)			# "temp1 = p_suits[i]"
		addi $t0, $t0, 1			# "i += 1"

		add $t7, $s3, $t0		# "aux = p_suits + i" (sucessor)
		lb $t2, ($t7)			# "temp2 = p_suits[i]"
		bne $t1,$t2, flush_end		# "if (temp1 != temp2) flush = false"
	
		j flush_start			# Salta para início do laço
	
	flush_set:
	
	addi $s6, $zero, 5			# Alterar registrador de controle; Sinaliza existência do flush
	
	flush_end:
	
	straight_def:
	
	move $t0, $zero				# Inicializa iterador de inteiros (4 bytes); "i = 0"
	
	lw $t4, ($s4)				# Carrega a primeira carta em t4; "temp = p_values[0]"
	beq $t4, 2, straight_edge_case		# Se a primeira carta é 2, testa o caso especial de straight
	
	straight_start:
	
		beq $t0, 16, straight_set	# Condição de parada "if (i == 4) straight = true";
	
		add $t7, $s4, $t0		# "aux = p_values + i"
		lw $t1, ($t7)			# "temp1 = p_values[i]"
		addi $t0, $t0, 4			# "i += 1"

		add $t7, $s4, $t0		# "aux = p_values + i"
		lw $t2, ($t7)			# "temp2 = p_values[i]"
		
		addi $t1, $t1, 1			# "temp1 += 1"
		bne $t1,$t2, straight_end	# "if (temp1 != temp2) straight = false"; (p/ cartas ordenadas)
		
		j straight_start
	
	straight_edge_case:
	
		beq $t0, 16, straight_set	# ondição de parada "if (i == 4) straight = true";
	
		add $t7, $s4, $t0		# "aux = p_values + i"
		lw $t1, ($t7)			# "temp1 = p_values[i]"
		
		addi $t0, $t0, 4			# "i += 1"

		add $t7, $s4, $t0		# "aux = p_values + i"
		lw $t2, ($t7)			# "temp2 = p_values[i]"
		
		addi $t1, $t1, 1			# "temp1 += 1"
		beq $t0, 16, straight_edge_case_2	# "if (i == 4) check_special_case()"
		bne $t1, $t2, straight_end	# "if (temp1 != temp2) straight = false"; (p/ cartas ordenadas)
		
		j straight_edge_case		# Salta para o início do laço

	straight_edge_case_2:
	
	beq $t2, 14 straight_edge_case_3		# "if (temp2 == 14) straight = true"; Há um Às (14p) formando um straight do tipo {A,2,3,4,5};
	beq $t1, $t2 straight_set		# "if (temp1 == temp2) straight = true"; (p/ cartas ordenadas); Straight do tipo {2,3,4,5,6};
	j straight_end
	
	straight_edge_case_3:
	
	move $t1, $s4
	lw $t2, ($t1)
	addi $t1, $t1, 4
	lw $t3, ($t1)
	addi $t1, $t1, 4
	lw $t4, ($t1)
	addi $t1, $t1, 4
	lw $t5, ($t1)

	move $t1, $s4
	li $t6, 1
	sw $t6, ($t1)
	addi $t1, $t1, 4
	sw $t2, ($t1)
	addi $t1, $t1, 4
	sw $t3, ($t1)
	addi $t1, $t1, 4
	sw $t4, ($t1)
	addi $t1, $t1, 4
	sw $t5, ($t1)
	
	straight_set:
	
	beq $s6, 5, straightflush_set		# "if (flush) straight_flush = true"; Se já era flush, torna-se straight flush;
	li $s6, 4				# "else straight = true"; Se não, sinaliza apenas straight;
	j straight_end				# Salta para o fim da rotina
	
	straightflush_set:
	
	li $s6, 8				# "straight_flush = true"

	addi $t0, $zero, 16			# Inicialiar iterador de inteiros; "i = 4"
	
	add $t7, $s4, $t0			# "aux = p_values[4];
	lw $t1, ($t7)				# "temp = p_values[4]; (última carta)
	
	bne $t1, 14, straight_end		# "if (temp != 14) end"; Se não é um Ás, salta para o final
	
	move $t0, $zero				# "i = 0"

	add $t7, $s4, $t0			# "aux = p_values + i" 
	lw $t1, ($t7)				# "temp = p_values[0]"; (primeira carta)
	
	beq $t1, 10, royalflush_set		# "if (temp == 10) royal_flush = true"; Se é um 10, há royal flush
	
	j straight_end				# Salta para o fim da rotina
	
	royalflush_set:
	
	addi $s6, $zero, 9			# Alterar registrador de controle; Sinaliza a existência do royal flush
	
	straight_end:

	sw $s6, ($s5)				# Carrega a força da mão em "p_force"
	bne $s6, 0, first_check			# Salta para etapa de verificação
			
	# ———————————————————— Identificação de TRINCA ———————————————————— #
		
	move $t0, $zero				# Inicializa o iterador de inteiros; "i = 0"
	move $t1, $zero				# Inicializa o contador de igualdades; "c = 0"
	
	comparator_loop3:
	
		beq $t0, 20, end_loop3		# Condição de parada; "if (i == 5) break"
		
		addi $t2, $t0, 4			# Inicializa iterador auxiliar; "j = i + 1" (sucessor)
		
		add $t7, $s4, $t0		# Soma o endereço base do vetor com seu offset; "aux = p_values + i"
		lw $t3, ($t7)			# Carrega elemento da posicao i; "temp1 = p_values[i]"
		
		add $t7, $s4, $t2		# Soma o endereço base do vetor com seu offset; "aux = p_values + j"
		lw $t4, ($t7)			# Carrega elemento da posicao j; "temp2 = p_values[i + 1]"
		
		addi $t0, $t0, 4			# "i += 1"
		
		bne $t3, $t4, comparator_loop3	# "if (temp1 != temp2) continue";

		addi $t2, $t2, 4			# "j = i + 2"
		add $t7, $s4, $t2		# "aux = p_values + j"
		lw $t4, ($t7)			# "temp2 = p_values[i + 2]
		
		bne $t3, $t4, end_loop3		# "if (temp1 != temp2) break"; Não há trinca
		
		li $s6, 3 			# Alterar registrador de controle; Sinaliza existência da trinca	
		
	end_loop3:

	sw $s6, ($s5)				# Carrega a força da mão em "p_force"
	bne $s6, 0, first_check			# Salta para etapa de verificação
						
	# ———————————————————— Identificação de DOIS PARES ———————————————————— #			
			
	move $t0, $zero				# Inicializa o iterador de inteiros; "i = 0"
	move $t1, $zero				# Inicializa o contador de igualdades; "c = 0"
		
	comparator_loop4:
	
		beq $t0, 20, end_loop4		# Condição de parada; "if (i == 5) break"
		
		addi $t2, $t0, 4			# Inicializa iterador auxiliar; "j = i + 1" (sucessor)
		
		add $t7, $s4, $t0		# Soma o endereço base do vetor com seu offset; "aux = p_values + i"
		lw $t3, ($t7)			# Carrega elemento da posicao i; "temp1 = p_values[i]"
		
		add $t7, $s4, $t2		# Soma o endereço base do vetor com seu offset; "aux = p_values + j"
		lw $t4, ($t7)			# Carrega elemento da posicao j; "temp1 = p_values[i + 1]"
		
		addi $t0, $t0, 4			# Incrementa i; "i += 1"
		
		bne $t3, $t4, comparator_loop4	# Reinicia antecipadamente na diferença
		addi $t1, $t1, 1			# Incrementa contador de igualdades
		
		j comparator_loop4
	end_loop4:
	
	bne $t1, 2, end4
	li $s6, 2
	
	end4:					
					
	sw $s6, ($s5)				# Carrega a força da mão em "p_force"
	bne $s6, 0, first_check			# Salta para etapa de verificação
									
	# ———————————————————— Identificação de PAR ———————————————————— #	
	
	move $t0, $zero				# Inicializa o iterador de valores $t0
	move $t1, $zero				# Inicializa o contador de igualdades $t1
	
	comparator_loop5:
	
		beq $t0, 20, end_loop5		# Condição de parada
		
		addi $t2, $t0, 4			# Posicao do elemento sucessor
		
		add $t7, $s4, $t0
		lw $t3, ($t7)			# Carrega elemento i
		
		add $t7, $s4, $t2
		lw $t4, ($t7)			# Carrega elemento i + 1
		
		addi $t0, $t0, 4			# Incrementa i
		
		bne $t3, $t4, comparator_loop5	# Reinicia antecipadamente na diferença
		addi $t1, $t1, 1			# Incrementa contador de igualdades
		
		j comparator_loop5
		
	end_loop5:
	
	bne $t1, 1, end5
	li $s6, 1
	
	end5:											
															
	sw $s6, ($s5)				# Carrega a força da mão em "p_force"
																												
	# ———————————————————— Primeira verificação ———————————————————— #
																		
	first_check:

	la $s0, p2_name				# Carrega endereço do label em $s0 (nome do jogador)
	la $s3, p2_suits				# Carrega endereço do label em $s3 (vetor com naipes)
	la $s4, p2_values			# Carrega endereço do label em $s4 (vetor com valores)		
	la $s5, p2_force				# Carrega endereço do label em $s5 (força da mão)		

	move $s6, $zero				# Inicializa a força da mão;		
	addi $s7, $s7, 1				# Incrementa contador de jogadores;
	
	beq $s7, 2, identification		# Repete rotina para o jogador 2
																							
	# ———————————————————— Critérios de desempate ———————————————————— #

	tiebreaker:

	lw $t0, p1_force
	lw $t1, p2_force

	bne $t0, $t1, results			# Desvia na diferença; Pula o desempate
		
	tiebreaker_start:
	beq $t0, 0, tiebreaker_simple		# Carta Alta(0), Straight(4), Flush(5) e Straight Flush (8) requerem um tiebreaker simples (compara maior carta
	beq $t0, 1, tiebreaker_1combo		# de tras pra frente)
	beq $t0, 2, tiebreaker_2combo		# Par(1), Trinca (3) e Quadra(7) requerem um tiebreaker que compara o par/trinca/quadra e em caso de empate
	beq $t0, 3, tiebreaker_1combo		# o tiebreaker anterior funciona para o desampate
	beq $t0, 4, tiebreaker_simple		# 2 Pares(3) e Full House(6) requerem um tiebreaker que compara o maior par, ou a maior trinca e depois o menor par
	beq $t0, 5, tiebreaker_simple		# e em caso de empate o tiebreaker simples funciona pra o desempate
	beq $t0, 6, tiebreaker_2combo		# Royal Flush(9) e uma mao unica logo sempre havera empate
	beq $t0, 7, tiebreaker_1combo
	beq $t0, 8, tiebreaker_simple
	beq $t0, 9, tiebreaker_tie
		
	tiebreaker_1combo:			# Tiebreaker para par, trinca e quadra
	move $t0, $zero
	
	tiebreaker_1combo_clear:			# Limpa a primeira posicao de vetor p1_combo e p2_combo (caso jogador jogue mais de uma mão)
	sw $zero, p1_combo($t0)
	sw $zero, p2_combo($t0)
	
	tiebreaker_1combo_p1:			# Inicializa i($t0)
	move $t0, $zero
	j tiebreaker_1combo_p1_outsideloop
	
	tiebreaker_1combo_p1_outsideloop_start:	# Incrementa i($t0)
	addi $t0, $t0, 4
	
	tiebreaker_1combo_p1_outsideloop:	# Incializa j($t2) = i+1, se j fora dos indices de p1_values significa que nao ha uma combinacao o que em teoria e
	addi $t2, $t0, 4				# impossivel se a classificacao esta certa
	bge $t0, 16, tiebreaker_end
	
	tiebreaker_1combo_p1_insideloop:		# Compara p1_values(i) com p1_values(j), se iguais manda para setar o vetor combo_p1, se diferentes incrementa j,
	lw $t1, p1_values($t0)			# testa se j e out of bounds do p1_values, se sim vai mandar incrementar i (loop externo), se nao continua o loop interno
	lw $t3, p1_values($t2)
	beq $t1,$t3, tiebreaker_1combo_set1
	addi $t2, $t2, 4
	bge $t2, 20, tiebreaker_1combo_p1_outsideloop_start
	j tiebreaker_1combo_p1_insideloop
		
	tiebreaker_1combo_set1:			# Guarda o valor do par/trinca/quadra em p1_combo(0)
	move $t0, $zero
	sw $t1, p1_combo($t0)
	
	###########################################
	
	tiebreaker_1combo_p2:			# Idem tiebreaker_1combo_p1 so que para p2
	move $t0, $zero
	j tiebreaker_1combo_p2_outsideloop
	
	tiebreaker_1combo_p2_outsideloop_start:	# Idem tiebreaker_1combo_p1 so que para p2
	addi $t0, $t0, 4
	
	tiebreaker_1combo_p2_outsideloop:	# Idem tiebreaker_1combo_p1 so que para p2
	addi $t2, $t0, 4
	bge $t0, 16, tiebreaker_end

	tiebreaker_1combo_p2_insideloop:		# Idem tiebreaker_1combo_p1 so que para p2
	lw $t1, p2_values($t0)
	lw $t3, p2_values($t2)
	beq $t1,$t3, tiebreaker_1combo_p2_set
	addi $t2, $t2, 4
	bge $t2, 20, tiebreaker_1combo_p2_outsideloop_start
	j tiebreaker_1combo_p2_insideloop
		
	tiebreaker_1combo_p2_set:		# Idem tiebreaker_1combo_p1 so que para p2
	move $t0, $zero
	sw $t1, p2_combo($t0)
	
	tiebreaker_1combo_result:		# Compata p1_combo(0) com p2_combo(0), se algum e maior mandar para definir vencendor, se iguais manda para o
	move $t0, $zero				# tiebreaker simples
	lw $t1, p1_combo($t0)
	lw $t2, p2_combo($t0)
	bgt $t1, $t2, tiebreaker_p1win
	bgt $t2, $t1, tiebreaker_p2win
	beq $t1, $t2, tiebreaker_simple
		
	######################################
	
	tiebreaker_2combo:			# Incializa i($t0)
	move $t0, $zero
	
	tiebreaker_2combo_clear:			# Idem ao clear do tiebreaker_1combo_clear so que limpa as 4 posicoes de cada vetor
	bgt $t0, 12, tiebreaker_2combo_p1
	sw $zero, p1_combo($t0)
	sw $zero, p2_combo($t0)
	addi $t0, $t0, 4
	j tiebreaker_2combo_clear
		
	tiebreaker_2combo_p1:			# Incializa i($t0)
	move $t0, $zero				# Inicializa $t8, esse registrador mostra em qual posicao de p1_combo deve ser inseridas as informacoes das combinacoes
	move $t8, $zero
		
	tiebreaker_2combo_p1_start:		# Se i out of bounds, termina o tiebreaker desse player. Atribue j($t1) = i+1, compara p1_values(i) com p1_values(j)
	bge $t0, 16, tiebreaker_2combo_p1_end	# se iguais ha um combinacao a ser definida, caso contrario i = j e o loop reinicia
	addi $t1, $t0, 4
	lw $t2, p1_values($t0)
	lw $t3, p1_values($t1)
	beq $t2,$t3, tiebreaker_2combo_p1_combodef
	move $t0, $t1
	j tiebreaker_2combo_p1_start
	
	
	tiebreaker_2combo_p1_combodef:		# Define k($t4) = j+1 = i+2, se k out of bounds o vetor acabou e a combinacao que vc achou e um par no fim. Caso 
	addi $t4, $t1, 4				# contrario pega p1_values(k) e compara com p1_value(j), se iguais vc achou uma trinca se diferentes, um par
	bgt $t4, 16, tiebreaker_2combo_p1_combodef_par
	
	lw $t4, p1_values($t4)
	beq $t4, $t3, tiebreaker_2combo_p1_combodef_trinca
	j tiebreaker_2combo_p1_combodef_par
	
	
	tiebreaker_2combo_p1_combodef_trinca:	# Guarda 3 na posicao $t8 de p1_combo, guarda o valor da carta na proxima posicao e incrementa para a proxima vez
	li $t5, 3				# que for utilizado. i = i+3 (12 bytes) pois i e suas duas cartas seguintes ja foram verificadas. Se i maior que 3(12)
	sw $t5, p1_combo($t8)			# estamos na ultima posicao e esse tiebreaker termina, caso contrario volta ao loop de comparacao
	addi $t8, $t8, 4
	sw $t2, p1_combo($t8)
	addi $t0, $t0, 12
	addi $t8, $t8, 4
	bgt $t0, 12, tiebreaker_2combo_p1_end
	j tiebreaker_2combo_p1_start
	
	tiebreaker_2combo_p1_combodef_par:	# Guarda 2 na posicao $t8 de p1_combo, guarda o valor da carta na proxima posicao e incrementa para a proxima vez
	li $t5, 2				# que for utilizado. i = i+2 (8 bytes) pois i e a carta seguinte ja foram verificadas. Se i maior que 3(12)
	sw $t5, p1_combo($t8)			# estamos na ultima posicao e esse tiebreaker termina, caso contrario volta ao loop de comparacao
	addi $t8, $t8, 4
	sw $t2, p1_combo($t8)
	addi $t8, $t8, 4
	addi $t0, $t0, 8
	bgt $t0, 12, tiebreaker_2combo_p1_end
	j tiebreaker_2combo_p1_start
	
	tiebreaker_2combo_p1_end:
	
	#####################################
	
	tiebreaker_2combo_p2:			# Idem tiebreaker_2combo_p1 so que para p2
	move $t0, $zero
	move $t8, $zero
	
	tiebreaker_2combo_p2_start:		# Idem tiebreaker_2combo_p1 so que para p2
	bge $t0, 16, tiebreaker_2combo_p2_end
	addi $t1, $t0, 4
	lw $t2, p2_values($t0)
	lw $t3, p2_values($t1)
	beq $t2,$t3, tiebreaker_2combo_p2_combodef
	move $t0, $t1
	j tiebreaker_2combo_p2_start
	
	
	tiebreaker_2combo_p2_combodef:		# Idem tiebreaker_2combo_p1 so que para p2
	addi $t4, $t1, 4
	bgt $t4, 16, tiebreaker_2combo_p2_combodef_par
	
	lw $t4, p2_values($t4)
	beq $t4, $t3, tiebreaker_2combo_p2_combodef_trinca
	j tiebreaker_2combo_p2_combodef_par
		
	tiebreaker_2combo_p2_combodef_trinca:	# Idem tiebreaker_2combo_p1 so que para p2
	li $t5, 3
	sw $t5, p2_combo($t8)
	addi $t8, $t8, 4
	sw $t2, p2_combo($t8)
	addi $t8, $t8, 4
	addi $t0, $t0, 12
	bgt $t0, 12, tiebreaker_2combo_p2_end
	j tiebreaker_2combo_p2_start
	
	tiebreaker_2combo_p2_combodef_par:	# Idem tiebreaker_2combo_p1 so que para p2
	li $t5, 2
	sw $t5, p2_combo($t8)
	addi $t8, $t8, 4
	sw $t2, p2_combo($t8)
	addi $t8, $t8, 4
	addi $t0, $t0, 8
	bgt $t0, 12, tiebreaker_2combo_p2_end
	j tiebreaker_2combo_p2_start
	
	tiebreaker_2combo_p2_end:
	
	##################################
	
	tiebreaker_2combo_result:		# Verifica as informacoes dos vetores p1_combo e p2_combo
	
	tiebreaker_2combo_result_p1_check:	# Checa se a primeira posicao guarda a combinacao de hierarquia mais alta. Se não infere-se que e um full house
	move $t0, $zero				# e manda p1_combo ser ordenado. Se sim testa para saber se um full house ou 2 pares. Se e full house, p1_combo
	lw $t1, p1_combo($t0)			# esta apto pra ser utilizado e pula para o procedimento do proximo player, se 2 pares manda fazer uma 
	addi $t0, $t0, 8				# verificacao adicional
	lw $t2, p1_combo($t0)
	bgt $t2, $t1 tiebreaker_2combo_result_p1_sort
	beq $t1, $t2, tiebreaker_2combo_result_p1_check2
	j tiebreaker_2combo_result_p2_check
	
	tiebreaker_2combo_result_p1_check2:	# Checa se o segundo par e maior que o primeiro, se sim manda ordenenar caso contrario prossegue para o
	li $t0, 4				# procedimento do proximo player
	lw $t1, p1_combo($t0)
	addi $t0, $t0, 8
	lw $t2, p1_combo($t0)
	bgt $t2, $t1 tiebreaker_2combo_result_p1_sort
	j tiebreaker_2combo_result_p2_check
		
	tiebreaker_2combo_result_p1_sort:	# Troca a ordem dos pares/Troca a ordem do par e trinca no vetor p1_combo
	move $t0, $zero
	lw $t1, p1_combo($t0)
	addi $t0, $t0, 4
	lw $t2, p1_combo($t0)
	addi $t0, $t0, 4
	lw $t3, p1_combo($t0)
	addi $t0, $t0, 4
	lw $t4, p1_combo($t0)
	
	move $t0, $zero
	sw $t3, p1_combo($t0)
	addi $t0, $t0, 4
	sw $t4, p1_combo($t0)
	addi $t0, $t0, 4
	sw $t1, p1_combo($t0)
	addi $t0, $t0, 4
	sw $t2, p1_combo($t0)
		
	tiebreaker_2combo_result_p2_check:	# Idem a tiebreaker_2combo_result_p1 so que para p2
	move $t0, $zero
	lw $t1, p2_combo($t0)
	addi $t0, $t0, 8
	lw $t2, p2_combo($t0)
	bgt $t2, $t1 tiebreaker_2combo_result_p2_sort
	beq $t1, $t2, tiebreaker_2combo_result_p2_check2
	j tiebreaker_2combo_result_def
	
	tiebreaker_2combo_result_p2_check2:	# Idem a tiebreaker_2combo_result_p1 so que para p2
	li $t0, 4				
	lw $t1, p2_combo($t0)
	addi $t0, $t0, 8
	lw $t2, p2_combo($t0)
	bgt $t2, $t1 tiebreaker_2combo_result_p2_sort
	j tiebreaker_2combo_result_p2_check
		
	tiebreaker_2combo_result_p2_sort:	# Idem a tiebreaker_2combo_result_p1 so que para p2
	move $t0, $zero
	lw $t1, p2_combo($t0)
	addi $t0, $t0, 4
	lw $t2, p2_combo($t0)
	addi $t0, $t0, 4
	lw $t3, p2_combo($t0)
	addi $t0, $t0, 4
	lw $t4, p2_combo($t0)
	
	move $t0, $zero
	sw $t3, p2_combo($t0)
	addi $t0, $t0, 4
	sw $t4, p2_combo($t0)
	addi $t0, $t0, 4
	sw $t1, p2_combo($t0)
	addi $t0, $t0, 4
	sw $t2, p2_combo($t0)
	
	tiebreaker_2combo_result_def:		# Compara as primeiras combinacoes de maior hierarquia(ou de maior valor) e caso ache seta um vencedor. Caso
	li $t0, 4				# contrario faz o mesmo pras combinacoes seguintes. Se em nenhuma das duas ha vencedor manda pro tiebreaker_simple
	lw $t1, p1_combo($t0)
	lw $t2, p2_combo($t0)
	bgt $t1,$t2, tiebreaker_p1win
	bgt $t2, $t1, tiebreaker_p2win
	addi $t0, $t0, 8
	lw $t1, p1_combo($t0)
	lw $t2, p2_combo($t0)
	bgt $t1,$t2, tiebreaker_p1win
	bgt $t2, $t1, tiebreaker_p2win
	j tiebreaker_simple
		
	tiebreaker_simple:			# Incializa i($t0) = 4(16)
	li $t0, 16
	
	tiebreaker_simple_start:
	blt $t0, 0, tiebreaker_tie		# Se i<0 o loop nao encontrou diferencas entre as maos logo ha um empate. Caso contrario compara p1_values(i) com
	lw $t1, p1_values($t0)			# com p1_values(2), se encontra diferenca desvia para setar o vencedor, caso contrario decrementa i e resfaz o loop
	lw $t2, p2_values($t0)
	bgt $t1, $t2, tiebreaker_p1win
	bgt $t2, $t1, tiebreaker_p2win
	subi $t0, $t0, 4
	j tiebreaker_simple_start
	
	tiebreaker_p1win:			# $s6 = 1 siginifca que p1 venceu
	li $s6, 1
	j tiebreaker_end
	
	tiebreaker_p2win:			# $s6 = 2 siginfica que p2 venceu
	li $s6, 2
	j tiebreaker_end
	
	tiebreaker_tie:				# $s6 = 0 significa empate
	move $s6, $zero
		
	tiebreaker_end:			
									
	# ——————————————————— Exibição dos resultados ——————————————————— #	

	results:			

	lw $s1, p1_force		
	lw $s2, p2_force

	la $a0, msg_hand1			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	sll $t0, $s1, 2
	lw $t1, maos($t0) 
	
	la $a0, ($t1)				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, msg_comma			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0		
	
	la $a0, p1_name				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	la $a0, msg_hand2			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	sll $t0, $s2, 2
	lw $t1, maos($t0) 
	
	la $a0, ($t1)				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, msg_comma			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0		
	
	la $a0, p2_name				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	beq $s1, $s2, draw
	blt $s1, $s2, p2_win
	
	p1_win:
	
	la $a0, msg_winner1			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	sll $t0, $s1, 2
	lw $t1, maos($t0) 
	
	la $a0, ($t1)				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0		
		
	la $a0, msg_congrats			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, p1_name				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0		
	
	j end			
		
	p2_win:	
	
	la $a0, msg_winner2			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	sll $t0, $s2, 2
	lw $t1, maos($t0) 
	
	la $a0, ($t1)				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0		
		
	la $a0, msg_congrats			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, p2_name				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	j end	
	
	draw:
	
	la $a0, msg_draw				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	beq $s6, 1, p1_draw
	beq $s6, 2, p2_draw	
	
	la $a0, msg_draw0			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0		
	
	j end
	
	p1_draw:
	
	la $a0, msg_draw1			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	la $a0, msg_congrats			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, p1_name				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	j end
	
	p2_draw:
	
	la $a0, msg_draw2			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	la $a0, msg_congrats			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
	
	la $a0, p2_name				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	j end	
	
	end:	
	
	la $a0, msg_separator			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0	
	
	la $a0, msg_restart			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0

	li $v0, 5				# Indica leitura de inteiro em $v0
	syscall 					# Executa operação indicada por $v0	
	
	move $t0, $v0	
		
	la $a0, msg_separator			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0
				
	beq $t0, 1, player_registration
	
	la $s0, p1_name				# Carrega endereço do label em $s0 (nome do jogador)
	la $s1, p1_input				# Carrega endereço do label em $s1 (entrada de cartas)
	la $s2, p1_symbols			# Carrega endereço do label em $s2 (vetor com simbolos)
	la $s3, p1_suits				# Carrega endereço do label em $s3 (vetor com naipes)
	la $s4, p1_values			# Carrega endereço do label em $s4 (vetor com valores)	
	la $s5, p1_force				# Carrega endereço do label em $s4 (vetor com valores)	
	
	move $s7, $zero				# Inicializa o contador de jogadores $s7; "player = 0"
			
	beq $t0, 2, new_hand																																																																																																																																																																																																								
										
	la $a0, msg_end				# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0										
										
	la $a0, msg_separator			# Carrega endereço do label em $a0
	li $v0, 4 				# Indica exibição de string em $a0
	syscall 					# Executa operação indicada por $v0																																																																																																																																																																																																																																																																																																																																																																																																																																																																		
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																		
	li $v0, 10 				# Indica encerramento do programa
	syscall					# Executa a operação indicada em $v0;
