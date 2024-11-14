using Graphs
using GraphPlot

include("../phase1/main.jl")
include("../phase3/node_priority.jl")
include("../phase3/queue.jl")
include("../phase3/prim.jl")
include("rsl.jl")
include("finetuning.jl")


# Création du graphe à partir bayg29.tsp

G=create_graph("/Users/mouhtal/Desktop/mth6412b-starter-code-3/instances/stsp/bays29.tsp")

#Test sur le fichier bayg29.tsp

T,C=rsl(G,G.Nodes[1])
println(C)
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
    gplot(g, layout = spring_layout,nodelabel = [node.name for node in nodes], nodesize=13)
end
GG=create_graph("/Users/mouhtal/Desktop/mth6412b-starter-code-3/instances/stsp/bays29.tsp")

#show(T)
T,C,noeud = finetuning_start(rsl, G)
show(noeud)
println(C)
visualize_graph(T.Nodes, T.Edges)