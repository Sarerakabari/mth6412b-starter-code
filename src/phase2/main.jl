
include("../phase1/main.jl")
include("kruskal.jl")




# Création du graphe à partir bayg29.tsp

G=create_graph("/Users/mouhtal/Desktop/mth6412b-starter-code-1/instances/stsp/bayg29.tsp")

#Test sur le fichier bayg29.tsp
A,B=kruskal(G)

println("the minimun spanning tree are composed of:")
for a in A
    show(a)
end
println("the total cost is ",B)
