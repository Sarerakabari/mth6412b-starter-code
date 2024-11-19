

# Création du graphe à partir bayg29.tsp

G=create_graph("C:/Users/Ando/Desktop/mth6412b-starter-code/instances/stsp/bays29.tsp")

#Test sur le fichier bayg29.tsp
A,B=kruskal(G)

println("the minimun spanning tree are composed of:")
for a in A
    show(a)
end
println("the total cost is ",B)
