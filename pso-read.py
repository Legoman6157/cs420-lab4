import pandas as pd
import os

parameters = [
    "num_particles",
    "inertia",
    "cognition",
    "social"
]

parameter_dfs = []
int_columns = [`"particles", "function", "epochs"`]

for p in parameters:
    if os.path.isfile(f"pso-{p}.csv"):
        print(p)
        parameter_dfs.append(pd.read_csv(f"pso-{p}.csv", encoding="utf-8").dropna())

        for ic in int_columns:
            parameter_dfs[-1][ic] = parameter_dfs[-1][ic].astype("int32")

        print(parameter_dfs[-1])
