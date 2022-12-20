include("graph_defs.jl")

function is_edge(g::G, vert1::Int, vert2::Int)
    return vert2 in g.edges[vert1]
end

function node_degree(g::G, vertex::Int)
    return length(g.edges[vertex])
end

function average_node_degree(g::G)
    return sum([node_degree(g, vertex) for vertex in g.vertices])/(g.n)
end

function degree_distribution(g::G)
    k = 1:maximum([node_degree(g, vertex) for vertex in g.vertices])
    freq = zeros(length(k))
    for vertex in g.vertices
        freq[node_degree(g, vertex)] += 1.0
    end
    return freq./(g.n)
end

function clustering(g::G, vertex::Int)
    k = node_degree(g, vertex)
    if k < 2
        return 0.0
    else
        number_of_edges = 0
        for neighbor1 in g.edges[vertex]
            for neighbor2 in g.edges[vertex]
                number_of_edges += (neighbor1 != neighbor2 && is_edge(g, neighbor1, neighbor2)) ? 1 : 0
            end
        end
        return (1.0*number_of_edges)/(k*k - k)
    end
end

function clustering_cdf(g::G, np::Int = 10000)
    cluster_coeffs= [clustering(g, vertex) for vertex in g.vertices]
    max_clustering = maximum(cluster_coeffs)
    ε = max_clustering/np
    x = ε:ε:max_clustering
    cdf = [count(c -> (c < i), cluster_coeffs) for i in x]
    return (x, cdf./g.n, cluster_coeffs)
end

