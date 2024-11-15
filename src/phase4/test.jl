include("../phase1/main.jl")
include("../phase3/kruskal_heuristic.jl")
include("../phase3/prim.jl")
include("../phase4/sub_graph.jl")


#création de noeud
n1=Node("A",[4])
n2=Node("B",[4])
n3=Node("C",[4])
n4=Node("D",[4])
n5=Node("E",[4])
n6=Node("F",[4])
n7=Node("G",[4])
n8=Node("H",[4])
n9=Node("I",[4])
#vecteur de noeuds
N=[n1,n2,n3,n4,n5,n6,n7,n8,n9]
#creation de arêtes
e1=Edge("AB",4,n1,n2)
e2=Edge("AH",8,n1,n8)
e3=Edge("BC",8,n2,n3)
e4=Edge("BH",11,n2,n8)
e5=Edge("HI",7,n8,n9)
e6=Edge("HG",1,n8,n7)
e7=Edge("IC",2,n9,n3)
e8=Edge("IG",6,n9,n7)
e9=Edge("CD",7,n3,n4)
e10=Edge("CF",4,n3,n6)
e11=Edge("GF",2,n7,n6)
e12=Edge("DF",14,n4,n6)
e13=Edge("DE",9,n4,n5)
e14=Edge("FE",10,n6,n5)
#vecteur des arête
E=[e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14]

#Création du graphe
G1=Graph("small",N,E)


show(g_1)
