include("../phase1/main.jl")
include("../phase3/node_priority.jl")
include("../phase3/queue.jl")
include("../phase3/prim.jl")
include("rsl.jl")
include("finetuning.jl")


#création des noeuds
n1=Node("A",[4])
n2=Node("B",[4])
n3=Node("C",[4])
n4=Node("D",[4])

#vecteur de noeuds
N=[n1,n2,n3,n4]

#création des arêtes
e1=Edge("AB",4,n1,n2)
e2=Edge("AC",8,n1,n3)
e3=Edge("AD",8,n1,n4)
e4=Edge("BC",11,n2,n3)
e5=Edge("BD",7,n2,n4)
e6=Edge("CD",1,n3,n4)

#vecteur des arêtes
E=[e1,e2,e3,e4,e5,e6]

#Création du graphe complet
G1=Graph("small",N,E)

@test 