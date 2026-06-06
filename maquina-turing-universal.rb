# maquina-turing-universal.rb

class MTU
  attr_accessor :fita, :cursor
  attr_reader :estado

  def initialize
    @cursor = 0
    @estado = "fa"
  end

  def processar(entrada)
    @fita = entrada.chars
    @estado = "fa"
    @posicao_palavra = @fita.join.index('#') + 1

    loop do
      @cursor = @posicao_palavra

      simbolo_atual = ler_simbolo_w
      
      transicao_encontrada = buscar_transicao(@estado, simbolo_atual)

      if transicao_encontrada.nil?
        return @estado.start_with?("fb")
      end

      novo_estado, novo_simbolo, direcao = transicao_encontrada

      escrever_simbolo_w(novo_simbolo)
      @estado = novo_estado 

      if direcao == "d"
        @posicao_palavra += novo_simbolo.length
      else
        @posicao_palavra -= 1
        string_fita = @fita.join
        while @posicao_palavra > string_fita.index('#') && !string_fita[@posicao_palavra..].start_with?("sc", "_", " ")
          @posicao_palavra -= 1
        end
      end
    end
  end

  def fita
    @fita.join
  end

  private

  def ler_simbolo_w
    return "_" if @posicao_palavra >= @fita.length || @fita[@posicao_palavra] == "_" || @fita[@posicao_palavra] == " "
    
    string_fita = @fita.join[@posicao_palavra..]
    if string_fita.start_with?("scccccc")
      return "scccccc"
    elsif string_fita.start_with?("sccccc")
      return "sccccc"
    elsif string_fita.start_with?("scccc")
      return "scccc"
    elsif string_fita.start_with?("sccc")
      return "sccc"
    elsif string_fita.start_with?("scc")
      return "scc"
    elsif string_fita.start_with?("sc")
      return "sc"
    end
    "_"
  end

  def escrever_simbolo_w(novo_simbolo)
    tamanho_atual = ler_simbolo_w.length
    
    if novo_simbolo.length < tamanho_atual
      novo_simbolo = novo_simbolo.ljust(tamanho_atual, " ")
    end

    @fita.slice!(@posicao_palavra, tamanho_atual)
    novo_simbolo.chars.reverse_each do |char|
      @fita.insert(@posicao_palavra, char)
    end
  end

  # NOVO: Lê a fita de regras pulando de bloco em bloco para não se confundir
  def buscar_transicao(estado, simbolo)
    conteudo_fita = @fita.join
    fim_regras = conteudo_fita.index('#')
    return nil if fim_regras.nil?
    
    regras = conteudo_fita[0...fim_regras]
    ponteiro = 0

    while ponteiro < regras.length
      estado_origem = identificar_estado(regras[ponteiro..])
      ponteiro += estado_origem.length

      simbolo_origem = identificar_simbolo(regras[ponteiro..])
      ponteiro += simbolo_origem.length

      estado_destino = identificar_estado(regras[ponteiro..])
      ponteiro += estado_destino.length

      simbolo_destino = identificar_simbolo(regras[ponteiro..])
      ponteiro += simbolo_destino.length

      direcao = regras[ponteiro]
      ponteiro += 1

      if estado_origem == estado && simbolo_origem == simbolo
        return [estado_destino, simbolo_destino, direcao]
      end
    end

    return nil
  end

  def identificar_estado(str)
    return "faaaaa" if str.start_with?("faaaaa")
    return "faaaa" if str.start_with?("faaaa")
    return "faaa"  if str.start_with?("faaa")
    return "faa"   if str.start_with?("faa")
    return "fa"    if str.start_with?("fa")
    return "fbbb"  if str.start_with?("fbbb")
    return "fbb"   if str.start_with?("fbb")
    return "fb"    if str.start_with?("fb")
    ""
  end

  def identificar_simbolo(str)
    return "scccccc"if str.start_with?("scccccc")
    return "sccccc"if str.start_with?("sccccc")
    return "scccc" if str.start_with?("scccc")
    return "sccc"  if str.start_with?("sccc")
    return "scc"   if str.start_with?("scc")
    return "sc"    if str.start_with?("sc")
    return "_"     if str.start_with?("_") || str.start_with?(" ")
    ""
  end
end