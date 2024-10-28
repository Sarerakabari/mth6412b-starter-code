import Base.show
include("node_pointer_heuristic.jl")

"""Algorithme Kruskal pour trouver l'arbre de recouvrement minimale 
   dans un graphe non orienté""" 

function kruskal(graph::Graph{T,S}) where {T,S}


    #Création des composantes connexe initiale
    set_comp_connexe = Vector{node_pointer{T}}()
    for node in graph.Nodes
        push!(set_comp_connexe,node_pointer(node))
    end
    
    #Trie  des arretes du graphe dans un ordre croissant
    sort!(graph.Edges, by=e -> e.data)


    #Initilaisation du vecteur des arêtes composant l'arbre de recouvrement minimal
    A=Vector{Edge{T,S}}()
    total_cost=0

    #Selection des arêtes qui fera partie de l'arbre de recouvrement minimal 
    for edge in graph.Edges

        # Trouver la racine de la composante connexe contenant le premier nœud de l'arete
        x=find_root(set_comp_connexe[findfirst(x->x.name==edge.node1.name,set_comp_connexe)],set_comp_connexe)

        # Trouver la racine de la composante connexe contenant le deuxième nœud de l'arete
        y=find_root(set_comp_connexe[findfirst(x->x.name==edge.node2.name,set_comp_connexe)],set_comp_connexe)

        #Si les deux nœuds appartiennent à des composantes connexes différentes (pour éviter les cycles)
        if x!=y
            # Ajouter l'arete à l'ensemble des aretes qui vont constituer l'arbre de recouvrement minimal
            push!(A,edge)
            # liaison des deux composantes connexes
            unite!(edge.node1,edge.node2,set_comp_connexe)  

            # Mettre à jour le coût total de l'arbre de recouvrement minimal
            total_cost+=edge.data
        end   
    end
    mst=Graph("MST",G.Nodes,A)
    return  mst,total_cost
end