
include("read_stsp.jl")
include("node.jl")
include("Edge.jl")
include("graph.jl")

function create_graph(filename::String)

header=read_header(filename)
nodes=read_nodes(header,filename)

edges,weights=read_edges(header,filename)

nodes=sort(nodes, by=first)

nodes_vec=Node{Vector{Float64}}[]
edges_vec=Edge{Vector{Float64}, Float64}[]
for id in keys(nodes)
    new_node=Node(string(id),nodes[id])
    push!(nodes_vec,new_node)
end



for i in eachindex(edges)

 new_edge =Edge(string(edges[i]),parse(Float64,weights[i]),nodes_vec[edges[i][1]],nodes_vec[edges[i][2]])
 push!(edges_vec,new_edge)

end

return graph=Graph(header["NAME"],nodes_vec,edges_vec)
end