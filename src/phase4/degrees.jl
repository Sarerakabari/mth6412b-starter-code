include("../phase1/main.jl")
include("../phase3/kruskal_heuristic.jl")
include("../phase3/prim.jl")
include("../phase3/node_priority.jl")

function degrees(graph::Graph{T,S})where {T,S}
    
    d=Vector{node_priority{T}}()
    v_k=Vector{node_priority{T}}()
    #initialisation de la file de priorité 
   

    p=[]
    v=[]
    for node in graph.Nodes
       

        push!(d,node_priority(node))
        push!(v_k,node_priority(node))

        neighboor_nodes=findall(x->x.node1==node||x.node2==node,graph.Edges)
        j=0
        
         A=Vector{Node{T}}()
        for i in neighboor_nodes

            if graph.Edges[i].node1==node
                n=graph.Edges[i].node2
            else
                n=graph.Edges[i].node1
            end

            if !(n in A)
        
                push!(A,n)

                j+=1
            end
            
        end
        j=j
        priority!(d[end],float.(j))
        priority!(v_k[end],float.(j-2))
       
        push!(p,j)
        push!(v,(j-2))


    end
    return d,v_k,p,v
   
end