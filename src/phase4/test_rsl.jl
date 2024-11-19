include("../phase1/main.jl")

using Test


#création des noeuds
n1=Node("A",[4])
n2=Node("B",[4])
n3=Node("C",[4])
n4=Node("D",[4])

#vecteur de noeuds
N=[n1,n2,n3,n4]

#création des arêtes
e1=Edge("AB",1,n1,n2)
e2=Edge("AC",1,n1,n3)
e3=Edge("AD",1,n1,n4)
e4=Edge("BC",11,n2,n3)
e5=Edge("BD",7,n2,n4)
e6=Edge("CD",5,n3,n4)

#vecteur des arêtes
E=[e1,e2,e3,e4,e5,e6]

#Création du graphe complet
G1=Graph("small",N,E)


#Création d'une arbre à partir de N
E1=[e1,e2,e3]

#Création de l'arbre
Tree=Graph("tree",N,E1)


#Tester la fonction parcours_preordre!
visited = Dict(node => false for node in N)
ordre = Node{Vector{Int64}}[]
parcours_preordre!(Tree, n2, visited,ordre)


@test ordre[1] == n2
@test ordre[2] == n1
@test ordre[3] == n3
@test ordre[4] == n4


#Tester la fonction rsl

T,C = rsl(G1,n1)
@test C == 18
T,C = rsl(G1,n2)
@test C == 14
T,C = rsl(G1,n3)
@test C == 14
T,C = rsl(G1,n4)
@test C == 18
