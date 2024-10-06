import Base.show
include("graph.jl")
include("comp_connexe.jl")

"""Algorithme Kruskal pour trouver l'arbre de recouvrement minimale 
   dans un graphe non orienté""" 

function kruskal(graph::AbstractGraph{T,S}) where {T,S}
    """Création de composantes connexe contenant chacque noeud du graphe"""
    set_comp_connexe = Vector{ComposanteConnexe{T,S}}()
    for node in nodes(graph)
        push!(set_comp_connexe,ConnectedComponent{T}
        (node.name,[node],[]))
    end

    """Trier  les arretes du graphe dans un ordre croissant"""
    edges_graph = edges(graph)
    sort!(edges_graph, by=e -> e.data)

    for edge in edges_graph
        twocompconx = Vector{ConnectedComponent{T}}()
        for elt in set_comp_connexe
            if node1(edge) in nodes(elt) and node2(edge) in nodes(elt)
                break
            elseif length(twocompconx) == 2
                break
            else
                push!(twocompconx, elt)
            end
        end
        
        if length(twocompconx) == 2

            if nb_nodes(twocompconx[1]) > nb_nodes(twocompconx[2]) 
                fusion_of_two_connected_components!(twocompconx[1], twocompconx[2], edge)
                deleteat!(set_comp_connexe, findall(elt->elt==twocompconx[2], set_comp_connexe))
            else
                fusion_of_two_connected_components!(twocompconx[2], twocompconx[1], edge)
                deleteat!(set_comp_connexe, findall(elt->elt==twocompconx[1], set_comp_connexe))
            end

            if length(set_comp_connexe)
                break
            end
        end
    end
    sort!(set_comp_connexe, by=elt -> nb_nodes(elt), rev = true)
    return Graph("Arbre de recouvrement minimale du graphe " * name(graph), nodes(set_comp_connexe[1]),
                edges(set_comp_connexe[1]))
end


