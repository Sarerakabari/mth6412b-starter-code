import Base.show
include("node_pointer.jl")

"""Algorithme Kruskal pour trouver l'arbre de recouvrement minimale 
   dans un graphe non orienté""" 

function kruskal(graph::Graph{T,S}) where {T,S}


    """Création de composantes connexe contenant chacque noeud du graphe"""
    set_comp_connexe = Vector{node_pointer{T}}()
    for node in graph.Nodes
        push!(set_comp_connexe,node_pointer(node))
    end
    
    """Trier  les arretes du graphe dans un ordre croissant"""
    sort!(graph.Edges, by=e -> e.data)


    A=Vector{Edge{T,S}}()
    total_cost=0

    """ Selection des arêtes qui fera partie de l'arbre de recouvrement minimal """
    for edge in graph.Edges


        x=find_root(set_comp_connexe[findfirst(x->x.name==edge.node1.name,set_comp_connexe)],set_comp_connexe)
       
        y=find_root(set_comp_connexe[findfirst(x->x.name==edge.node2.name,set_comp_connexe)],set_comp_connexe)
        if x!=y
            push!(A,edge)
            unite!(edge.node1,edge.node2,set_comp_connexe)  
            total_cost+=edge.data
        end   
    end
    return A,total_cost
end