#!/bin/bash

# ===============================
# Configurações
# ===============================
N_VALUES=(100000 500000 1000000)
T_VALUES=(1 2 4 8 16)
k_VALUES=(20 24 28)
REPS=5

A_V1="./src/omp/tarefa_a/a_v1.c"
A_V2="./src/omp/tarefa_a/a_v2.c"
A_V3="./src/omp/tarefa_a/a_v3.c"

CSV_C_V1="c_v1.csv"
CSV_C_V2="c_v2.csv"
CSV_C_V3="c_v3.csv"

C_V1="./src/seq/saxpy_v1"
C_V2="./src/omp/saxpy_v2"
C_V3="./src/omp/saxpy_v3"

CSV_C_V1="c_v1.csv"
CSV_C_V2="c_v2.csv"
CSV_C_V3="c_v3.csv"

# Cabeçalhos dos CSVs

echo "N,execucao,tempo(ms)" > $CSV_V1
echo "N,execucao,tempo(ms)" > $CSV_V2
echo "N,T,execucao,tempo(ms)" > $CSV_V3

# Execuções

for N in "${N_VALUES[@]}"; do
    for ((i=1; i<=REPS; i++)); do

        

        # ------ Tarefa C ------

        # v1 (sequencial)
        time_C_v1=$($C_V1 $N)
        echo "$N,$i,$time_C_v1" >> $CSV_V1

        # v2 (SIMD)
        time_C_v2=$($C_V2 $N)
        echo "$N,$i,$time_C_v2" >> $CSV_V2

        # v3 (OMP + SIMD)
        for T in "${T_VALUES[@]}"; do
            time_C_v3=$($C_V3 $N $T)
            echo "$N,$T,$i,$time_C_v3" >> $CSV_V3
        done

    done
done

echo "Execuções finalizadas."
