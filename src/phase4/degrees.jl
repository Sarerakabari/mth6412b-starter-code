include("../phase1/main.jl")
include("../phase3/kruskal_heuristic.jl")
include("../phase3/prim.jl")


function degrees(graph::Graph{T,S})where {T,S}
    i=0
    d=node_Queue{node_priority{T}}()

    #initialisation de la file de priorité 
    for node in graph.Nodes
        i+1

        push!(d,node_priority(node))
        

        neighboor_node=findall(x->x.node1==node||x.node2==node,graph.Edges)

        A=Vector{Node{T}}()

        



    end
   
end