include("graph_defs.jl")

"""
The implemented Erdos-Renyi generation algorithm is efficient for sparse graphs,
but it is not optimal for generating dense graphs.
"""

function find_random_new_neighbor(g::G, vertex::Int, no_self_loops = true)
    r = rand(g.vertices)
    if ((no_self_loops && r == vertex) || r ∈ g.edges[vertex])
        return find_random_new_neighbor(g, vertex, no_self_loops)
    else
        return r
    end
end

function rand_edge(N::Int, no_self_loops::Bool = true)    
    r = rand(0:(N*N - 1))
    i = r % N
    j = trunc(Int, (r - i)//N)
    if (i == j && no_self_loops)
        return rand_edge(N, no_self_loops)
    else
        return i+1, j+1
    end
end

function erdos_renyi(N::Int, L::Int)
    g = G_empty(N)
    for i in 1:L
        did_make_edge = false
        while !did_make_edge
            v1, v2 = rand_edge(N)
            did_make_edge = make_edge!(g, v1, v2)
        end
    end
    return g
end



function erdos_renyi_gilbert(N::Int, p::Float64)
    g = G_empty(N)
    v = 1
    w = -1
    while w < N
        r = rand()
        w = w + 1 + floor(Int, log(1-r)/log(1-p))
        while w >= v && v < N
            w -= v
            v += 1
        end
        if v < N
            make_edge_unsec!(g, w+1, v+1)
        end
    end
    return g
end

function watts_strogatz(N::Int, k::Int, β::Float64)
    g = G_empty(N)
    k_left, k_right = (k % 2 == 0) ? (trunc(Int, k/2), trunc(Int, k/2)) : (trunc(Int, (k-1)/2), trunc(Int, (k+1)/2))
    for vertex in g.vertices
        for neighbor in (-k_left):(k_right)
            make_edge!(g, vertex, mod1(vertex + neighbor, N), true)
        end
    end
    for vertex in g.vertices
        for neighbor in 1:(k_right)
            if rand() < β
                remove_edge!(g, vertex, mod1(vertex + neighbor, N))
                r = find_random_new_neighbor(g, vertex, true)
                make_edge!(g, vertex, r)
            end
        end
    end
    return g
end