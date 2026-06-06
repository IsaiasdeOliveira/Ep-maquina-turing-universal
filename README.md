# EP 03 - Máquina de Turing Universal (MTU)

Este projeto consiste na implementação de uma Máquina de Turing Universal (MTU) desenvolvida em **Ruby**, capaz de simular e decidir cadeias para três diferentes tipos de linguagens: Regular, Livre de Contexto e Sensível ao Contexto.

##  Integrantes (Dupla)
* Isaias Maia de Oliveira
* Daniel Santos Baptista

##  Estrutura do Repositório
* `maquina-turing-universal.rb`: O motor principal da MTU que gerencia o estado, a fita, o cursor e processa a cadeia.
* `main.rb`: Arquivo principal utilizado para execução e interface de saída dos testes no terminal.
* `mt-linguagem-regular.rb`: Codificação da linguagem regular $a^*b^+$.
* `mt-linguagem-livre-contexto.rb`: Codificação da linguagem livre de contexto $a^n b^n$.
* `mt-linguagem-sensivel-ao-contexto.rb`: Codificação da linguagem sensível ao contexto $a^n b^n c^n$.

##  Como Executar e Testar

1. Certifique-se de ter o **Ruby** instalado em sua máquina.
2. Abra o arquivo `main.rb`.
3. No topo do arquivo, escolha qual linguagem deseja testar descomentando a linha correspondente (por padrão, a máquina sensível ao contexto vem ativa).
4. Execute o seguinte comando no terminal:

```bash
ruby main.rb
