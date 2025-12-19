#!/bin/bash

# Parâmetros definidos no roteiro
NS=(100000 500000 1000000)
THREADS=(1 2 4 8 16)
REPS=5
OUTPUT="resultados_brutos.csv"

# Cabeçalho do CSV
echo "Versao,N,Threads,Tempo" > $OUTPUT

echo "Iniciando benchmarks..."

# 1. Execução Sequencial (v1)
for n in "${NS[@]}"; do
    echo "Rodando v1 (Seq) para N=$n"
    for i in $(seq 1 $REPS); do
        tempo=$(./bin/saxpy_v1 $n)
        echo "v1,$n,1,$tempo" >> $OUTPUT
    done
done

# 2. Execução SIMD (v2)
for n in "${NS[@]}"; do
    echo "Rodando v2 (SIMD) para N=$n"
    for i in $(seq 1 $REPS); do
        tempo=$(./bin/saxpy_v2 $n)
        echo "v2,$n,1,$tempo" >> $OUTPUT
    done
done

# 3. Execução OMP + SIMD (v3)
for n in "${NS[@]}"; do
    for t in "${THREADS[@]}"; do
        echo "Rodando v3 (OMP+SIMD) para N=$n com T=$t"
        for i in $(seq 1 $REPS); do
            tempo=$(./bin/saxpy_v3 $n $t)
            echo "v3,$n,$t,$tempo" >> $OUTPUT
        done
    done
done

echo "Concluído! Resultados salvos em $OUTPUT"
