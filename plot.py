import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

sns.set(style="whitegrid")

# ===============================
# Leitura dos dados
# ===============================
v1 = pd.read_csv("saxpy_v1.csv")
v2 = pd.read_csv("saxpy_v2.csv")
v3 = pd.read_csv("saxpy_v3.csv")

# ===============================
# Estatísticas
# ===============================
def stats(df, group_cols):
    return (
        df.groupby(group_cols)["tempo"]
        .agg(["mean", "std"])
        .reset_index()
        .rename(columns={"mean": "media", "std": "desvio_padrao"})
    )

stats_v1 = stats(v1, ["N"])
stats_v2 = stats(v2, ["N"])
stats_v3 = stats(v3, ["N", "T"])

print("=== V1 ===")
print(stats_v1)
print("\n=== V2 ===")
print(stats_v2)
print("\n=== V3 ===")
print(stats_v3)

# ===============================
# Funções de plot
# ===============================
def scatter_plot(df, x, y, hue, title, filename):
    plt.figure(figsize=(8, 5))
    sns.scatterplot(data=df, x=x, y=y, hue=hue)
    plt.title(title)
    plt.tight_layout()
    plt.savefig(filename)
    plt.close()

def box_plot(df, x, y, hue, title, filename):
    plt.figure(figsize=(8, 5))
    sns.boxplot(data=df, x=x, y=y, hue=hue)
    plt.title(title)
    plt.tight_layout()
    plt.savefig(filename)
    plt.close()

# ===============================
# V1 – Sequencial
# ===============================
scatter_plot(
    v1, "N", "tempo", None,
    "SAXPY v1 – Nuvem de pontos",
    "v1_scatter.png"
)

box_plot(
    v1, "N", "tempo", None,
    "SAXPY v1 – Boxplot",
    "v1_boxplot.png"
)

# ===============================
# V2 – SIMD
# ===============================
scatter_plot(
    v2, "N", "tempo", None,
    "SAXPY v2 (SIMD) – Nuvem de pontos",
    "v2_scatter.png"
)

box_plot(
    v2, "N", "tempo", None,
    "SAXPY v2 (SIMD) – Boxplot",
    "v2_boxplot.png"
)

# ===============================
# V3 – OpenMP + SIMD
# ===============================
scatter_plot(
    v3, "N", "tempo", "T",
    "SAXPY v3 (OMP + SIMD) – Nuvem de pontos",
    "v3_scatter.png"
)

box_plot(
    v3, "N", "tempo", "T",
    "SAXPY v3 (OMP + SIMD) – Boxplot",
    "v3_boxplot.png"
)

print("\nGráficos gerados com sucesso.")
