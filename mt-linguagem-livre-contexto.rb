# mt-livre-contexto.rb

# Estados de não-aceitação
@q0 = "fa"    # Estado inicial: procurando 'a' para marcar
@q1 = "faa"   # Indo para a direita procurando 'b' correspondente
@q2 = "faaa"  # Voltando para a esquerda procurando o começo da fita
@q3 = "faaaa" # Verificação final (garantir que não sobrou nenhum 'b')

# Estado de aceitação
@q_aceita = "fb"

# Símbolos da fita
@sa = "sc"     # Caractere 'a'
@sb = "scc"    # Caractere 'b'
@ma = "sccc"   # Marcação do 'a' consumido (A)
@mb = "scccc"  # Marcação do 'b' consumido (B)
@branco = "_"

# Direções
@dir = "d"
@esq = "e"

# === REGRAS DE TRANSIÇÃO (Lógica a^n b^n) ===

# No estado q0: acha um 'a', marca com 'ma' e vai procurar 'b' (vai para q1)
@t1 = "#{@q0}#{@sa}#{@q1}#{@ma}#{@dir}"

# No estado q1: pula os 'a's e as marcações 'mb' procurando um 'b' limpo
@t2 = "#{@q1}#{@sa}#{@q1}#{@sa}#{@dir}"
@t3 = "#{@q1}#{@mb}#{@q1}#{@mb}#{@dir}"

# No estado q1: achou o 'b' limpo! Marca com 'mb' e começa a voltar (vai para q2)
@t4 = "#{@q1}#{@sb}#{@q2}#{@mb}#{@esq}"

# No estado q2: pula as marcações 'mb' e os 'a's normais voltando para a esquerda
@t5 = "#{@q2}#{@mb}#{@q2}#{@mb}#{@esq}"
@t6 = "#{@q2}#{@sa}#{@q2}#{@sa}#{@esq}"

# No estado q2: achou a marcação 'ma'! Anda uma casa para a direita para pegar o próximo 'a' (volta para q0)
@t7 = "#{@q2}#{@ma}#{@q0}#{@ma}#{@dir}"

# No estado q0: se em vez de 'a' achar uma marcação 'mb', significa que os 'a's acabaram.
# Vai para o estado q3 para verificar se os 'b's também acabaram.
@t8 = "#{@q0}#{@mb}#{@q3}#{@mb}#{@dir}"

# No estado q3: pula as marcações 'mb' procurando o fim da fita
@t9 = "#{@q3}#{@mb}#{@q3}#{@mb}#{@dir}"

# No estado q3: chegou no final da fita (branco) e tudo casou! Aceita a palavra (vai para fb)
@t10 = "#{@q3}#{@branco}#{@q_aceita}#{@branco}#{@dir}"

def linker
  "#{@t1}#{@t2}#{@t3}#{@t4}#{@t5}#{@t6}#{@t7}#{@t8}#{@t9}#{@t10}"
end

def codificacao_cadeia
  # =================================================================
  # HISTÓRICO DE TESTES (Linguagem a^n b^n)
  # =================================================================
  # "aabb" -> (@sa * 2) + (@sb * 2) | Esperado: true  (Cadeia válida padrão)
  # "ab"   -> @sa + @sb             | Esperado: true  (Mínimo válido)
  # "aab"  -> (@sa * 2) + @sb       | Esperado: false (Falta um 'b')
  # "abb"  -> @sa + (@sb * 2)       | Esperado: false (Sobra um 'b')
  # "ba"   -> @sb + @sa             | Esperado: false (Ordem invertida)
  # =================================================================
  
  # Cadeia ativa para a avaliação do professor (aabb)
   (@sa * 2) + (@sb * 2)
end