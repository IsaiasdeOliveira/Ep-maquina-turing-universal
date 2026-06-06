# Estados internos de não-aceitação
@q0 = "fa"
@q1 = "faa"
@q2 = "faaa"

# Estados internos de aceitação
@q_aceita = "fb"

# Símbolos da fita
@sa = "sc"   # representa o caractere 'a'
@sb = "scc"  # representa o caractere 'b'
@branco = "_"

# Movimentações do cursor
@dir = "d"
@esq = "e"

# REGRAS DE TRANSIÇÃO
@t1 = "#{@q0}#{@sa}#{@q0}#{@sa}#{@dir}"
@t2 = "#{@q0}#{@sb}#{@q_aceita}#{@sb}#{@dir}"
@t3 = "#{@q_aceita}#{@sb}#{@q_aceita}#{@sb}#{@dir}"

def linker
  "#{@t1}#{@t2}#{@t3}"
end

def codificacao_cadeia
  # =================================================================
  # HISTÓRICO DE TESTES DA BATERIA (Linguagem a*b+)
  # =================================================================
  # "aabb" -> (@sa * 2) + (@sb * 2) | Esperado: true  (Cadeia válida padrão)
  # "bbb"  -> (@sb * 3)             | Esperado: true  (Sem 'a' no início, válido)
  # "ba"   -> @sb + @sa             | Esperado: false (Invertido, trava no 'fb')
  # "a"    -> @sa                   | Esperado: false (Falta o 'b' obrigatório)
  # Letras estranhas (ex: 'c' ou 'd') resultam em false por falta de regra.
  # =================================================================
  
  # Cadeia ativa para a avaliação (aabb)
  (@sa * 2) + (@sb * 2)
end