# Estados de busca
@q0 = "fa"      # Procura 'a' limpo para marcar
@q1 = "faa"     # Procura 'b' limpo para marcar
@q2 = "faaa"    # Procura 'c' limpo para marcar
@q3 = "faaaa"   # Volta para a esquerda para reiniciar o ciclo
@q4 = "faaaaa"  # Fase de verificação (garante que não sobrou nada na fita)

# Estado de aceitação
@q_aceita = "fb"

# Símbolos da fita (Alfabeto Original)
@sa = "sc"        # 'a'
@sb = "scc"       # 'b'
@sc_char = "sccc" # 'c' (usando _char no nome para não confundir com a string "sc")

# Símbolos da fita (Marcações)
@ma = "scccc"     # 'A' marcado
@mb = "sccccc"    # 'B' marcado
@mc = "scccccc"   # 'C' marcado
@branco = "_"

# Direções
@dir = "d"
@esq = "e"

# === REGRAS DE TRANSIÇÃO (Lógica a^n b^n c^n) ===

# Q0: Lê 'a', marca com 'ma' e vai para Q1 procurar 'b'
@t1 = "#{@q0}#{@sa}#{@q1}#{@ma}#{@dir}"
# Q0: Se ler 'mb' (B marcado), significa que os 'a's acabaram. Vai para Q4 verificar se sobrou algo
@t2 = "#{@q0}#{@mb}#{@q4}#{@mb}#{@dir}"

# Q1: Pula 'a' limpo e 'mb' marcado indo para a direita
@t3 = "#{@q1}#{@sa}#{@q1}#{@sa}#{@dir}"
@t4 = "#{@q1}#{@mb}#{@q1}#{@mb}#{@dir}"
# Q1: Acha o 'b', marca com 'mb' e vai para Q2 procurar 'c'
@t5 = "#{@q1}#{@sb}#{@q2}#{@mb}#{@dir}"

# Q2: Pula 'b' limpo e 'mc' marcado indo para a direita
@t6 = "#{@q2}#{@sb}#{@q2}#{@sb}#{@dir}"
@t7 = "#{@q2}#{@mc}#{@q2}#{@mc}#{@dir}"
# Q2: Acha o 'c', marca com 'mc' e vai para Q3 para voltar ao início
@t8 = "#{@q2}#{@sc_char}#{@q3}#{@mc}#{@esq}"

# Q3: Volta tudo para a esquerda pulando as letras limpas e marcações do meio
@t9 = "#{@q3}#{@mc}#{@q3}#{@mc}#{@esq}"
@t10 = "#{@q3}#{@sb}#{@q3}#{@sb}#{@esq}"
@t11 = "#{@q3}#{@mb}#{@q3}#{@mb}#{@esq}"
@t12 = "#{@q3}#{@sa}#{@q3}#{@sa}#{@esq}"
# Q3: Bate na marcação 'ma' (A marcado), anda um para a direita e volta pro estado Q0
@t13 = "#{@q3}#{@ma}#{@q0}#{@ma}#{@dir}"

# Q4 (Verificação final): Os 'a's acabaram. Pula todas as marcações 'mb' e 'mc' indo para a direita
@t14 = "#{@q4}#{@mb}#{@q4}#{@mb}#{@dir}"
@t15 = "#{@q4}#{@mc}#{@q4}#{@mc}#{@dir}"
# Q4: Chegou no branco sem achar letras sobrando? Tudo casou perfeitamente! Vai para aceitação
@t16 = "#{@q4}#{@branco}#{@q_aceita}#{@branco}#{@dir}"

def linker
  "#{@t1}#{@t2}#{@t3}#{@t4}#{@t5}#{@t6}#{@t7}#{@t8}#{@t9}#{@t10}#{@t11}#{@t12}#{@t13}#{@t14}#{@t15}#{@t16}"
end

def codificacao_cadeia
  # =================================================================
  # HISTÓRICO DE TESTES (Linguagem a^n b^n c^n)
  # =================================================================
  # "aabbcc" -> (@sa * 2) + (@sb * 2) + (@sc_char * 2) | Esperado: true  (Válido)
  # "abc"    -> @sa + @sb + @sc_char                   | Esperado: true  (Mínimo válido)
  # "aabc"   -> (@sa * 2) + @sb + @sc_char             | Esperado: false (Falta b e c)
  # "aabbc"  -> (@sa * 2) + (@sb * 2) + @sc_char       | Esperado: false (Falta c)
  # "abcc"   -> @sa + @sb + (@sc_char * 2)             | Esperado: false (Sobra c)
  # "cba"    -> @sc_char + @sb + @sa                   | Esperado: false (Ordem invertida)
  # =================================================================
  
  # Cadeia ativa para a avaliação (aabbcc)
  (@sa * 2) + (@sb * 2) + (@sc_char * 2) 
end