using Graphs
include("graph_defs.jl")

function shortest_paths(g::G)
    ext_g = SimpleGraph(g.n)
    for vertex in g.vertices
        for neighbor in g.edges[vertex]
            add_edge!(ext_g, vertex, neighbor)
        end
    end
    paths = Vector{Int}(undef, 0)
    for vertex in g.vertices
        dsp = dijkstra_shortest_paths(ext_g, vertex)
        paths = vcat(paths, dsp.dists)
    end

    path_lens = unique(paths)
    sort!(path_lens, rev = false)
    freq = [count(i -> (i == l), paths) for l in path_lens] 
    
    return path_lens, freq./(1.0*length(paths))
end