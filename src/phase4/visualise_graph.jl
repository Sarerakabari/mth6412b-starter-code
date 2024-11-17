using Graphs
using GraphPlot
export visualize_graph
"""Fonction pour afficher les graphes graphiquement"""
function visualize_graph(nodes::Vector{Node{T}}, edges::Vector{Edge{T,S}}) where {T,S}
    # Associer chaque nœud à un identifiant numérique pour Graphs.jl
    node_to_index = Dict{Node{T}, Int}()
    for (i, node) in enumerate(nodes)
        node_to_index[node] = i
    end

    # Créer un graphe avec Graphs.jl
    g = SimpleGraph(length(nodes))
    for edge in edges
        u = node_to_index[edge.node1]
        v = node_to_index[edge.node2]
        Graphs.add_edge!(g, u, v)
    end

    # Tracer le graphe avec GraphPlot.jl
    gplot(g, layout = circular_layout,nodelabel = [node.name for node in nodes], nodesize=13)
end