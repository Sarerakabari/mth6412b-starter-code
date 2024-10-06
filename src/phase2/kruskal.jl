import Base.show
include("graph.jl")
include("comp_connexe.jl")

"""Algorithme Kruskal pour trouver l'arbre de recouvrement minimale 
   dans un graphe non orienté""" 

function kruskal(graph::AbstractGraph{T,S}) where {T,S}
    """Création de composantes connexe contenant chacque noeud du graphe"""
    set_comp_connexe = Vector{ComposanteConnexe{T,S}}()
    for node in Nodes(graph)
        push!(set_comp_connexe,ConnectedComponent{T}
        (node.name,[node],[]))
    end
    