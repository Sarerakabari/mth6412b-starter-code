




# Création du graphe à partir bayg29.tsp

G=create_graph("/Users/mouhtal/Desktop/mth6412b-starter-code-3/instances/stsp/bays29.tsp")

#Test sur le fichier bayg29.tsp

#Kruskal avec heuristique
A,B=kruskal(G)

println("the minimun spanning tree are composed of:")


show(A)

println("the total cost is ",B)


#prim

C,D=prim(G,G.Nodes[1])

println("the minimun spanning tree are composed of:")

show(C)
println("the total cost is ",D)