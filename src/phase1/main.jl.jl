
include("read_stsp.jl")
include("node.jl")
include("Edge.jl")
include("graph.jl")

function create_graph(filename::String)

header=read_header(filename)
nodes=read_nodes(header,filename)

edges,weights=read_edges(header,filename)

dim=parse(Int, header["DIMENSION"])
nodes_vec=Node{Vector{Float64}}[]
edges_vec=Edge{Vector{Float64}, Float64}[]
if isnothing(nodes)

 for id in 1:dim
        new_node=Node(string(id),Float64[])
        push!(nodes_vec,new_node)
    end

else
    nodes=sort(nodes, by=first)

 for id in 1:dim
        new_node=Node(string(id),nodes[id])
        push!(nodes_vec,new_node)
    end
end







for i in eachindex(edges)

 new_edge =Edge(string(edges[i]),parse(Float64,weights[i]),nodes_vec[edges[i][1]],nodes_vec[edges[i][2]])
 push!(edges_vec,new_edge)

end

return graph=Graph(header["NAME"],nodes_vec,edges_vec)
end

G=create_graph("C:/Users/Ando/Desktop/mth6412b-starter-code/instances/stsp/gr17.tsp")

show(G)