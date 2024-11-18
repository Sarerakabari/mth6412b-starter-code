include("../phase1/main.jl")
include("weighted_node.jl")
export weigth_update!
""" Mise à jour des poides des arretes d'un graphe """
function weigth_update!(graph::Graph{T,S},pi_k::Vector{weighted_node{T}})where {T,S}

    for edge in graph.Edges
        edge.data= edge.data + pi_k[findfirst(x->x.node==edge.node1,pi_k)].priority+pi_k[findfirst(x->x.node==edge.node2,pi_k)].priority
    end
end