include("../phase1/main.jl")
include("../phase3/kruskal_heuristic.jl")
include("../phase3/prim.jl")


function one_tree(graph::Graph{T,S},idx::Int64)where {T,S}

n=graph.Nodes[idx]
sub_graph_nodes =[graph.Nodes[1:idx-1];graph.Nodes[idx+1:end]]

sub_graph_edges=graph.Edges

A=Vector{Edge{T,S}}()
B=Vector{Edge{T,S}}()

for edge in sub_graph_edges

    
    if (edge.node1!=n) & (edge.node2!=n) 
        push!(A,edge)
    else
        push!(B,edge) 
    end


end
s_g=Graph("k_n",sub_graph_nodes,A)

k_n,W=kruskal(s_g)

sort!(B, by=e -> e.data)

push!(k_n.Nodes,n)

if B[1].node1!=B[2].node2
 push!(k_n.Edges,B[1])

 push!(k_n.Edges,B[2])
else
    push!(k_n.Edges,B[1])

    push!(k_n.Edges,B[3])
end
return k_n,(W+B[1].data+B[2].data)

    
end