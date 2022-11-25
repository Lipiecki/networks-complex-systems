include("graph_defs.jl")

function load_edges_file(filepath::String)
    return open(filepath) do f
        edges = readlines(f)
        edges = [split(e, " ") for e in edges]
        edges = [parse.(Int, e) for e in edges]
        n = findmax([maximum(e) for e in edges])[1] + 1
        g = G_empty(n)
        for e in edges
            make_edge!(g, e[1] + 1, e[2] + 1)
        end
        return g
    end
end