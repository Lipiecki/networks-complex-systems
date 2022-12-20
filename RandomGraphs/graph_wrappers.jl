using Graphs
include("graph_gen.jl")

function er(N::Int, p::Float64)
    g = erdos_renyi_gilbert(N, p)
    ext_g = SimpleGraph(g.n)
    for vertex in g.vertices
        for neighbor in g.edges[vertex]
            add_edge!(ext_g, vertex, neighbor)
        end
    end
    return ext_g
end

function ws(N::Int, k::Int, p::Float64)
    g = m_watts_strogatz(N, k, p)
    ext_g = SimpleGraph(g.n)
    for vertex in g.vertices
        for neighbor in g.edges[vertex]
            add_edge!(ext_g, vertex, neighbor)
        end
    end
    return ext_g
end