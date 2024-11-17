include("../phase1/main.jl")
include("../phase3/kruskal_heuristic.jl")
include("../phase3/prim.jl")

"""Création de 1-arbre pour l'algorithme hk!"""
function one_tree(graph::Graph{T,S},idx::Int64)where {T,S}

#noeud selectionné pour le 1-arbre
    n=graph.Nodes[idx]

    # creation du graphe sans le noeud

    sub_graph_nodes =[graph.Nodes[1:idx-1];graph.Nodes[idx+1:end]]

    sub_graph_edges=graph.Edges

    A=Vector{Edge{T,S}}()
    B=Vector{Edge{T,S}}()

    #retrair des arêtes contentant le noeud

    for edge in sub_graph_edges

    
        if (edge.node1!=n) & (edge.node2!=n) 
        push!(A,edge)
        else
        push!(B,edge) 
     end


    end
    #sous graphe
    s_g=Graph("k_n",sub_graph_nodes,A)
    #prim sur le sous graphe
    k_n,W=prim(s_g,graph.Nodes[idx])
    
    # creation du  1-arbre
    sort!(B, by=e -> e.data)

    push!(k_n.Nodes,n)

    if B[1].node1!=B[2].node2
    push!(k_n.Edges,B[1])

    push!(k_n.Edges,B[2])

    W=W+B[1].data+B[2].data
    else

    push!(k_n.Edges,B[1])

    push!(k_n.Edges,B[3])

    W=W+B[1].data+B[3].data
    end
return k_n,W

    
end