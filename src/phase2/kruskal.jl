import Base.show
<<<<<<< HEAD
include("node_pointer.jl")
=======
#include("graph.jl")
include("compconnexe.jl")
>>>>>>> 419a27d35d94b896650795618e207af9fdb571b2

"""Algorithme Kruskal pour trouver l'arbre de recouvrement minimale 
   dans un graphe non orienté""" 

<<<<<<< HEAD
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
=======
function kruskal(graph::AbstractGraph{T,S}) where {T,S}
    """Création de composantes connexe contenant chacque noeud du graphe"""
    set_comp_connexe = Vector{ComposanteConnexe{T,S}}()
    for node in nodes(graph)
        push!(set_comp_connexe,ConnectedComponent{T},
        (node.name,[node],[]))
    end

    """Trier  les arretes du graphe dans un ordre croissant"""
    edges_graph = edges(graph)
    sort!(edges_graph, by=e -> e.data)

    for edge in edges_graph
        twocompconx = Vector{ConnectedComponent{T}}()
        for elt in set_comp_connexe
            if node1(edge) in nodes(elt) 
                if node2(edge) in nodes(elt)
                    break
                end
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
    return Graph("Arbre de recouvrement minimale du graphe " * name(graph), nodes(set_comp_connexe),
                edges(set_comp_connexe))
end


>>>>>>> 419a27d35d94b896650795618e207af9fdb571b2
