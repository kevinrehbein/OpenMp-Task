#OpenMP Task

## Integrantes e Divisão de Trabalho

| Membro | Responsabilidades |
| Kevin Rehbein | Implementação da Tarefa A, Scripts de Automação |
| Gustavo Ulyssea Estivalet | Implementação da Tarefa C, Análise de Resultados |

## Estrutura do Projeto

```text
.
├── Makefile                # Automação de compilação e execução
├── README.md               # Este arquivo
├── REPRODUCIBILIDADE.md    # Detalhes do ambiente de hardware/software
├── RESULTADOS.md           # Análise detalhada dos dados e gráficos
├── run.sh                  # Script de execução da matriz de testes
├── plot.py                 # Script Python para geração dos gráficos
└── src
    ├── seq                 # Códigos sequenciais (base)
    └── omp                 # Códigos paralelos (OpenMP)
        ├── a_vn            # Fontes da Tarefa A (Fibonacci/Schedule) - variante n
        └── c_vn            # Fontes da Tarefa C (SAXPY/SIMD) - variante n

## Introdução

Este repositório trata-se de um trabalho prático sobre OpenMP, relativo à disciplina de Introdução ao Processamento Paralelo e Distribuído. No escopo deste projeto serão exploradas:

## Tarefas escolhidas pela dupla:

### Tarefa A — Laço irregular e políticas de schedule

Kernel: para i = 0..N-1, compute fib(i % K) e grave em v[i] usando fib custosa sem memoização.
Variante 1: #pragma omp parallel for schedule(static)
Variante 2: schedule(dynamic,chunk) com chunk ∈ {1,4,16,64}
Variante 3: schedule(guided,chunk) com chunk ∈ {1,4,16,64}
Se houver dois laços paralelos em sequência, use uma única região parallel e dois for internos

### Tarefa C — Vetorização com simd

SAXPY: y[i] = a*x[i] + y[i].
V1: sequencial.
V2: #pragma omp simd.
V3: #pragma omp parallel for simd.
Analisar ganhos e limitações.

## Pré-requisitos

Para compilar e executar este projeto, o ambiente deve possuir:

Sistema Operacional: Linux

Compilador: GCC ou Clang com suporte a OpenMP 5.x (ex: gcc -fopenmp)

Python 3: Para geração de gráficos

Bibliotecas necessárias: pandas, matplotlib, seaborn

Instalação rápida: pip install pandas matplotlib seaborn


## Como Compilar

Utilizamos um Makefile para gerenciar a compilação de todas as variantes (sequenciais e paralelas).

Para compilar todo o projeto:

Bash

make

Para limpar os binários e arquivos temporários:

Bash

make clean

## Como Executar os Experimentos

O projeto conta com um script automatizado (run.sh) que executa a matriz completa de testes solicitada na especificação (variando N, Threads, Chunk, K, etc.). Atenção: A execução leva bastante tempo, pois realiza múltiplas repetições (média de 5 execuções) nos casos de carga desbalanceada (Tarefa A).

Para rodar todos os experimentos:

Bash

make run

Ao final, dois arquivos CSV serão gerados na raiz:

resultados_tarefa_a.csv

resultados_tarefa_c.csv

## Gerando Gráficos

Após a execução dos experimentos (existência dos arquivos CSV), execute o script de plotagem para gerar as visualizações:

Bash

make plot

Os gráficos serão salvos como imagens PNG na raiz do projeto.
```
