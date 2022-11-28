include("RandomGraphs/RandomGraphs.jl")
ws = watts_strogatz(1000, 50, 1.0);
clws = clustering_cdf(ws)