require_relative 'maquina-turing-universal'
# =================================================================
# INSTRUÇÕES DE TESTE:
# Descomente apenas a linha da linguagem que deseja testar no motor:
# =================================================================

# require_relative 'mt-linguagem-regular'
# require_relative 'mt-linguagem-livre-contexto'
require_relative 'mt-linguagem-sensivel-ao-contexto' 

entrada = linker + "#" + codificacao_cadeia
mt = MTU.new

puts "Entrada:\n #{entrada}"
puts "Decidiu? #{mt.processar(entrada)}"
puts "Fita Resultante:\n #{mt.fita}"
puts "Cursor parou em #{mt.cursor}"
puts "Cursor no estado #{mt.estado}"
caractere_atual = mt.fita[mt.cursor]
puts "Cursor está lendo \"#{caractere_atual.nil? ? '_' : caractere_atual}\""