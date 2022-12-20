mutable struct G
    n::Int
    vertices::Vector{Int}
    edges::Vector{Vector{Int}}
end

function G_empty(n::Int)
    vertices = 1:n
    edges = [Vector{Int}(undef, 0) for vertex in vertices] 
    return G(n, vertices, edges) 
end

function make_edge!(g::G, i::Int, j::Int, no_self_loops = false)
    if no_self_loops && i == j
        return false
    elseif i ∉ g.edges[j] && j ∉ g.edges[i]
        append!(g.edges[i], j)
        append!(g.edges[j], i)
        return true
    else
        return false
    end
end

function make_edge_unsec!(g::G, i::Int, j::Int)
    append!(g.edges[i], j)
    append!(g.edges[j], i)
end

function remove_edge!(g, i::Int, j::Int)
    idx1 = findfirst([x == j for x in g.edges[i]])
    idx2 = findfirst([x == i for x in g.edges[j]])
    did_delete = false
    if !isnothing(idx1)
        deleteat!(g.edges[i], idx1)
        did_delete = true 
    end
    if !isnothing(idx2)
        deleteat!(g.edges[j], idx2)
        did_delete = true
    end
    return did_delete
end