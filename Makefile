# ==========================================
# Configurações de Compilação
# ==========================================
CC = gcc
# -O3: Otimização agressiva
# -march=native: Habilita instruções específicas da sua CPU (AVX2/SIMD)
# -Wall: Mostra todos os avisos (boa prática)
CFLAGS = -O3 -march=native -Wall
OMP_FLAGS = -fopenmp
LIBS = -lm

# ==========================================
# Caminhos e Alvos
# ==========================================
# O seu run.sh espera os binários nestes locais específicos
BIN_V1 = src/seq/saxpy_v1
BIN_V2 = src/omp/saxpy_v2
BIN_V3 = src/omp/saxpy_v3

# Fontes (ajuste os nomes se necessário)
SRC_V1 = src/seq/saxpy_v1.c
SRC_V2 = src/omp/saxpy_v2.c
SRC_V3 = src/omp/saxpy_v3.c

# ==========================================
# Regras de Compilação
# ==========================================

# Alvo padrão: compila tudo
all: $(BIN_V1) $(BIN_V2) $(BIN_V3)

# Compilação Sequencial (v1)
$(BIN_V1): $(SRC_V1)
	$(CC) $(CFLAGS) $< -o $@ $(LIBS)

# Compilação SIMD (v2) - requer flags de OpenMP para o #pragma omp simd
$(BIN_V2): $(SRC_V2)
	$(CC) $(CFLAGS) $(OMP_FLAGS) $< -o $@ $(LIBS)

# Compilação OMP + SIMD (v3)
$(BIN_V3): $(SRC_V3)
	$(CC) $(CFLAGS) $(OMP_FLAGS) $< -o $@ $(LIBS)

# ==========================================
# Utilidades
# ==========================================

# Limpa os binários gerados
clean:
	rm -f $(BIN_V1) $(BIN_V2) $(BIN_V3)

# Atalho para garantir que a pasta csv exista (usada pelo seu run.sh)
setup:
	mkdir -p csv png