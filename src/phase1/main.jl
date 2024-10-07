

include("read_stsp.jl")
include("node.jl")
include("Edge.jl")
include("graph.jl")
include("../phase2/kruskal.jl")
#Fonction qui construit un graph avec les données stsp

function create_graph(filename::String)
#Création de l' entête
header=read_header(filename)

#Lecture des noeuds
nodes=read_nodes(header,filename)

#Lecture des arêtes et les poids
edges,weights=read_edges(header,filename)

#Initialisation"""
dim=parse(Int, header["DIMENSION"])
nodes_vec=Node{Vector{Float64}}[]
edges_vec=Edge{Vector{Float64}, Float64}[]

#Création du vecteur de noeuds
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

###Création du vecteur des arêtes

for i in eachindex(edges)

 new_edge =Edge(string(edges[i]),parse(Float64,weights[i]),nodes_vec[edges[i][1]],nodes_vec[edges[i][2]])
 push!(edges_vec,new_edge)

end
#création du graph
return graph=Graph(header["NAME"],nodes_vec,edges_vec) 
end





G=create_graph("C:/Users/Ando/Desktop/mth6412b-starter-code/instances/stsp/swiss42.tsp")
A,B=kruskal(G)

println("the minimun spanning tree are composed of:")
for a in A
    show(a)
end
println("the total cost is ",B)
