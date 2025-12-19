CC = gcc
OMP_FLAGS = -fopenmp

# Diretórios
SRC_SEQ = src/seq
SRC_OMP = src/omp

# Binários
BIN_A_V1 = a_v1
BIN_A_V2 = a_v2
BIN_A_V3 = a_v3
BIN_C_V1 = c_v1
BIN_C_V2 = c_v2
BIN_C_V3 = c_v3

all: seq omp

seq: $(BIN_C_V1)

omp: $(BIN_A_V1) $(BIN_A_V2) $(BIN_A_V3) $(BIN_C_V2) $(BIN_C_V3)

# Tarefa A
$(BIN_A_V1): $(SRC_OMP)/a_v1.c
	$(CC) $(OMP_FLAGS) $< -o $@

$(BIN_A_V2): $(SRC_OMP)/a_v2.c
	$(CC) $(OMP_FLAGS) $< -o $@

$(BIN_A_V3): $(SRC_OMP)/a_v3.c
	$(CC) $(OMP_FLAGS) $< -o $@

# Tarefa C
$(BIN_C_V1): $(SRC_SEQ)/c_v1.c
	$(CC) $(OMP_FLAGS) $< -o $@

$(BIN_C_V2): $(SRC_OMP)/c_v2.c
	$(CC) $(OMP_FLAGS) $< -o $@

$(BIN_C_V3): $(SRC_OMP)/c_v3.c
	$(CC) $(OMP_FLAGS) $< -o $@

run: all
	bash run.sh

plot:
	python3 plot.py

clean:
	rm -f $(BIN_A_V1) $(BIN_A_V2) $(BIN_A_V3) $(BIN_C_V1) $(BIN_C_V2) $(BIN_C_V3)