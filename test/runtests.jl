using STSP,Test

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



G=Graph("small",N,E)
départ=N[1]

A,B=kruskal(G)

C,D=prim(G,départ)

#test sur le constructeur node_pointer

@test comp_c1.name==n1.name

@test comp_c1.child==n1

@test comp_c1.parent==n1

#@test comp_c1.rank==0

#verification si le noeud est son propre parent apres l'utilisation du constructeur node_pointer

#root=find_root(comp_c1,set_comp)

#@test root==comp_c1

#test sur les liasons des composant connexe avec rang

#link!(set_comp[1],set_comp[2],set_comp)

#@test set_comp[1].parent==set_comp[2].child

#@test set_comp[2].rank==1
 
#@test find_root(comp_c1,set_comp)==comp_c2

#Test sur l'exemple du cours

println("the minimun spanning tree are composed of:")
for a in A
    show(a)
end
println("the total cost is ",B)

@test B==37

#Test sur la structure node priority

np_1=node_priority(n1)

@test np_1.name==n1.name

@test np_1.node==n1

@test np_1.parent==nothing

@test np_1.priority==Inf

priority!(np_1,2)

@test np_1.priority==2

#test de paternité

parent!(np_1,n2)

@test np_1.parent==n2

#test sur les node_Queue 

Q=node_Queue{typeof(np_1)}()

#test push
for node in G.Nodes

push!(Q,node_priority(node))

end

@test !is_empty(Q)

# Test pop
priority!(Q.items[3],2)

parent!(Q.items[3],n4)


@test Q.items[3].priority==2
@test Q.items[3].parent==n4

u=Q.items[3]

@test popfirst!(Q)==u


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

T,C = rsl(G1,1)
@test C == 18
T,C = rsl(G1,2)
@test C == 14
T,C = rsl(G1,3)
@test C == 14
T,C = rsl(G1,4)
@test C == 18
# Création des nœuds
n1 = Node("A", [4])
n2 = Node("B", [4])
n3 = Node("C", [4])
n4 = Node("D", [4])

# Vecteur de nœuds
N = [n1, n2, n3, n4]

# Création des arêtes
e1 = Edge("AB", 1, n1, n2)
e2 = Edge("AC", 1, n1, n3)
e3 = Edge("AD", 1, n1, n4)
e4 = Edge("BC", 11, n2, n3)
e5 = Edge("BD", 7, n2, n4)
e6 = Edge("CD", 5, n3, n4)

# Vecteur des arêtes
E = [e1, e2, e3, e4, e5, e6]

# Création du graphe complet
G1 = Graph("small", N, E)

# Création d'une arbre à partir de N
E1 = [e1, e2, e3]

# Création de l'arbre
Tree = Graph("tree", N, E1)

# Tester la fonction `parcours_preordre!`
visited = Dict(node => false for node in N)
ordre = Node{Vector{Int64}}[]
parcours_preordre!(Tree, n2, visited, ordre)

@test ordre[1] == n2
@test ordre[2] == n1
@test ordre[3] == n3
@test ordre[4] == n4

# Tester la fonction `fix_tree`
T, C = fix_tree(G1, Tree, n1)
@test C == 18
T, C = fix_tree(G1, Tree, n2)
@test C == 14
T, C = fix_tree(G1, Tree, n3)
@test C == 14
T, C = fix_tree(G1, Tree, n4)
@test C == 18

# Tester `degrees`
d, v_k, p, v = degrees(G1)
@test length(d) == 4
@test length(v_k) == 4
@test p == [3, 3, 3, 3]
@test v == [1, 1, 1, 1]

# Tester `one_tree`
one_tree_result, weight = one_tree(G1, 1)
@test weight == 14  # Exemple attendu