include("RandomGraphs\\RandomGraphs.jl")
@time begin
    g = watts_strogatz(10^3, 50, 0.0)
    k = average_node_degree(g)
    sp = shortest_paths(g)
    avg_sp = sum([sp[1][i]*sp[2][i] for i in 1:length(sp[1])])
end