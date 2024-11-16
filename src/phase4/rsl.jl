export parcours_preordre!,rsl



"""Parcours en préordre d'une arbre (Parcour dans l'ordre de visite comme Prim)"""
function parcours_preordre!(graph::Graph{T,S}, start::Node{T},visited::Dict{Node{T}, Bool},ordre::Vector{Node{T}}) where {T,S}
    push!(ordre,start)
    visited[start] = true
    #La boucle for parcour les noeuds voisin comme dans l'algorithme Prim
    for edge_index in findall(x-> x.node1 == start || x.node2 == start, graph.Edges)
        edge=graph.Edges[edge_index]
        voisin = edge.node1 == start ? edge.node2 : edge.node1
        if !visited[voisin]
            parcours_preordre!(graph,voisin,visited,ordre)
        end
    end
end

"""L'algorithme rsl pour déterminer une tournée minimale approximative à partie d'un noeud départ choisi"""
function rsl(graph::Graph{T,S},start::Node{T}) where {T,S}

    arbre, weight=prim(graph,start)

    visited=Dict(node => false for node in graph.Nodes)
    ordre=Node{T}[]

    parcours_preordre!(arbre,start,visited,ordre)

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
    pop!(ordre)
    Tournée=Graph("Tournée",ordre,tournée)
    return Tournée, cout
end
