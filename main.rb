# main.rb
require_relative 'maquina-turing-universal'
require_relative 'mt-linguagem-sensivel-ao-contexto' # <-- Mude para o nome do arquivo novo!

entrada = linker + "#" + codificacao_cadeia
mt = MTU.new

puts "Entrada:\n #{entrada}"
puts "Decidiu? #{mt.processar(entrada)}"
puts "Fita Resultante:\n #{mt.fita}"
puts "Cursor parou em #{mt.cursor}"
puts "Cursor no estado #{mt.estado}"
caractere_atual = mt.fita[mt.cursor]
puts "Cursor está lendo \"#{caractere_atual.nil? ? '_' : caractere_atual}\""