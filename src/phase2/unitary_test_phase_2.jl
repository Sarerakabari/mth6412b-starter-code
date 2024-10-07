include("node_pointer.jl")
include("kruskal.jl")
using Test
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

#Création de composants connexes et d'un ensemble

comp_c1=node_pointer(n1)

comp_c2=node_pointer(n2)

comp_c3=node_pointer(n3)

comp_c4=node_pointer(n4)

comp_c5=node_pointer(n5)

set_comp=[comp_c1,comp_c2,comp_c3,comp_c4,comp_c5]

#Création du graphe

G=Graph("small",N,E)

# Algorithme de Kruskal appliqué au graphe du cours qui retourne l'arbre de recouvrement minimal et le côut de cette arbre
A,B=kruskal(G)

#test sur le constructeur node_pointer

@test comp_c1.name==n1.name

@test comp_c1.child==n1

@test comp_c1.parent==n1

#verification si le noeud est son propre parent apres l'utilisation du constructeur node_pointer

root=find_root(comp_c1,set_comp)

@test root==comp_c1


#test sur les liasons des composant connexe

link!(set_comp[1],set_comp[2],set_comp)

@test set_comp[2].parent==set_comp[1].child


#test sur les unions des composant connexe à partir de noeud d'une arête


unite!(n1,n5,set_comp)

@test set_comp[5].parent==set_comp[1].child


@test set_comp[1].parent==set_comp[1].child

#Test sur l'exemple du cours

println("the minimun spanning tree are composed of:")
for a in A
    show(a)
end
println("the total cost is ",B)

@test B==37








