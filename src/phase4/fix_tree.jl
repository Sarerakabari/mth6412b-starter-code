include("rsl.jl")

"""Création de la tournée minimale en utilsant un parcours en préordre"""
function fix_tree(graph::Graph{T,S},arbre::Graph{T,S},start::Node{T}) where {T,S}

    

    visited=Dict(node => false for node in graph.Nodes)
    ordre=Node{T}[]

    parcours_preordre!(arbre,start,visited,ordre)
    # Pour boucler la tournée
    push!(ordre,start)

    tournée = Edge{T,S}[]
    cout = 0

    for i in 1:length(ordre)-1
        n1, n2 = ordre[i],ordre[i+1]
        edge_index=findfirst(x -> (x.node1 == n1 && x.node2 == n2) || (x.node1 == n2 && x.node2 == n1), graph.Edges)
        edge=graph.Edges[edge_index]
        if edge !== nothing
            push!(tournée,edge)
            cout+=edge.data
        else
            error("Erreur : on n'a pas trouvé d'arête entre $n1 et $n2 dans le graphe.")
        end
    end
    # Suppresion de dernier élément(start), puisqu'il est redondant
    pop!(ordre)
    Tournée=Graph("Tournée",ordre,tournée)
    return Tournée, cout
end