import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

# ===============================
# Configurações Estéticas
# ===============================
sns.set(style="whitegrid", context="talk", font_scale=1.1)
plt.rcParams['figure.figsize'] = (10, 6)
plt.rcParams['axes.grid'] = True
plt.rcParams['grid.alpha'] = 0.3
plt.rcParams['lines.linewidth'] = 2.5
plt.rcParams['lines.markersize'] = 9

# ===============================
# 1. Carregar Dados
# ===============================
FILE_NAME = "resultados_tarefa_a.csv"

if not os.path.exists(FILE_NAME):
    print(f"ERRO: Arquivo '{FILE_NAME}' não encontrado.")
    exit()

df = pd.read_csv(FILE_NAME)

# Filtrar para garantir que estamos olhando o cenário correto
# (Ajuste N, K e Threads conforme o que você rodou no run.sh)
N_VAL = 1000000
K_VAL = 28
THREAD_VAL = 16

df_filtered = df[
    (df['N'] == N_VAL) & 
    (df['K'] == K_VAL) & 
    (df['Threads'] == THREAD_VAL)
].copy()

if df_filtered.empty:
    print(f"AVISO: Nenhum dado encontrado para N={N_VAL}, K={K_VAL}, Threads={THREAD_VAL}.")
    print("Verifique se o run.sh rodou com esses parâmetros.")
    exit()

# ===============================
# 2. Transformação dos Dados (O Truque)
# ===============================

# 1. Calcular a média do Static (que está salvo com Chunk=0)
static_mean = df_filtered[df_filtered['Variante'] == 'static']['Tempo'].mean()

# 2. Descobrir quais chunks foram testados nas outras variantes
chunks_existentes = df_filtered[df_filtered['Chunk'] > 0]['Chunk'].unique()
chunks_existentes.sort()

# 3. Criar dados artificiais para o Static
# Para cada chunk existente (1, 4, 16, 64), criamos uma entrada para o 'static'
# com o tempo médio calculado. Isso fará ele ser plotado como uma linha.
dados_static_expandidos = []
for c in chunks_existentes:
    dados_static_expandidos.append({
        'Variante': 'static',
        'N': N_VAL,
        'K': K_VAL,
        'Threads': THREAD_VAL,
        'Chunk': c,
        'Rep': 1, # Dummy
        'Tempo': static_mean
    })

# 4. Juntar tudo: Dynamic/Guided originais + Static expandido
df_dynamic_guided = df_filtered[df_filtered['Variante'].isin(['dynamic', 'guided'])].copy()
df_static_novo = pd.DataFrame(dados_static_expandidos)
df_final = pd.concat([df_dynamic_guided, df_static_novo], ignore_index=True)

# ===============================
# 3. Plotagem
# ===============================
plt.figure()

# Agora plotamos TUDO junto. O 'static' será tratado igual aos outros.
sns.lineplot(
    data=df_final, 
    x='Chunk', 
    y='Tempo', 
    hue='Variante', 
    style='Variante', 
    markers=True, 
    dashes=False # Garante linhas sólidas para todos
)

# ===============================
# 4. Ajustes Finais
# ===============================
plt.xscale('log')
plt.xticks(chunks_existentes, [str(c) for c in chunks_existentes]) # Labels bonitos
plt.minorticks_off()

plt.title(f"Comparativo de Políticas de Escalonamento\n(N={N_VAL}, K={K_VAL}, Threads={THREAD_VAL})", fontsize=16, pad=20)
plt.ylabel("Tempo de Execução (s)", fontsize=14)
plt.xlabel("Tamanho do Chunk (Escala Log)", fontsize=14)
plt.legend(title="Variante", loc='best', frameon=True)

OUTPUT_FILE = "grafico_comparativo_todas_linhas.png"
plt.tight_layout()
plt.savefig(OUTPUT_FILE, dpi=300)
print(f"Gráfico gerado: {OUTPUT_FILE}")
