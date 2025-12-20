#OpenMP Task

Organização do projeto:

```
ippd/
├── src/
│   ├── seq/                 # Código-fonte da implementação sequencial
│   └── omp/                 # Código-fonte da implementação paralela com OpenMP
├── csv		# Contendo saídas das diversas execuções
├── png  		# Contendo resultados gráficos de plot.py
├── Makefile                 # Arquivo com as regras de compilação
├── script_dependencies.sh   # Script para garantir as dependências necessárias
├── run.sh                   # Script para automação da execução e coleta de dados
├── plot.py                  # Script Python para geração de gráficos
├── README.md                # Este arquivo de descrição geral do projeto
├── RESULTADOS.md            # Tabelas, gráficos, análise e decisões
└── REPRODUCIBILIDADE.md     # Detalhes do ambiente (CPU, compiler, flags, etc.)
```

## Tarefas escolhidas pela dupla

Tarefa A - Laço irregular e política de schedule

Tarefa C - Vetorização com simd


## Revisão de instalações/dependências de ambiente:

```
chmod +x script_dependencies.sh
```
```
chmod +x run.sh
```

## Para garantir as dependências de versões:

```
./script_dependencies.sh
```

## Para criar diretórios e compilar:

```
make setup
```

```
make
```

## Para executar os códigos c e gerar os csv’s:

```
./run.sh
```

## Agora com os resultados, plotagem de gráficos com python:

Instalar as bibliotecas de plotoagem de gráficos:
```
pip install pandas matplotlib seaborn
```

## Para Execução do Script plot.py em ambiente WSL, manualmente:

```
python3 -m venv .venv
```

```
source .venv/bin/activate
```

## E por fim executar:

```
python3 plot.py
```



