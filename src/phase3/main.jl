
include("../phase1/main.jl")
include("kruskal_heuristic.jl")
include("prim.jl")



# Création du graphe à partir bayg29.tsp

G=create_graph("../../instances/stsp/bays29.tsp")

#Test sur le fichier bayg29.tsp

#Kruskal avec heuristique
A,B=kruskal(G)

println("the minimun spanning tree are composed of:")
for a in A
    show(a)
end

println("the total cost is ",B)


#prim

C,D=prim(G)

show(C)
println("the total cost is ",D)