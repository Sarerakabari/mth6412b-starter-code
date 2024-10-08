### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 41d11a17-73b7-4da2-999d-a9ceda200969
using Markdown

# ╔═╡ 0829e03c-8bc6-4c0d-b1c2-572dd831cb1a
using InteractiveUtils

# ╔═╡ 9f427156-bc94-4877-80f9-3db6f178f274
using Logging

# ╔═╡ c8cc4922-0f3b-4c3a-b444-8045b67205c8
md"""
### Mini rapport: Phase 2 du projet
#
"""

# ╔═╡ b727f17a-8843-4d23-941b-698c19c5c6c1
md"""
```
Auteurs:Ando Rakotonandrasana
		Oussama Mouhtal
		Octave Claich
```
"""


# ╔═╡ 2f59b97d-e868-46bc-9945-76075015d4cc
md""" Le  code se trouve au lien suivant: """

# ╔═╡ 322e6e27-5af8-49b0-96f4-025bbf2403f4
md"""[https://github.com/Sarerakabari/mth6412b-starter-code/tree/Phase_2/src/phase2](https://github.com/Sarerakabari/mth6412b-starter-code/tree/Phase_2/src/phase2)"""

# ╔═╡ 48b7402e-7cfc-4e5f-87a0-b67bca4eb326
md""" Tous les implementations de cette phase sont inspirées du livre ci-dessous :"""

# ╔═╡ 3d9e6b3c-8179-4759-a862-146fe1872464
md"""
 ###### Cormen, Thomas H and Leiserson, Charles E and Rivest, Ronald L and Stein, Clifford. (2022). Introduction to algorithms. MIT press.
"""

# ╔═╡ 063e8297-bc61-4bde-85d0-8f144185c6d3
md""" Le lecteur peut fork le projet et lancer le fichier main.jl pour retrouver les résultats ci-dessus"""

# ╔═╡ b4aac71c-7ec4-41b6-8d85-02b8c3dc742d
md"""
##### 1. Choisir et implémenter une structure de données pour les composantes connexes d’un graphe
"""

# ╔═╡ d970b71a-1f3f-46c8-93ce-df35125d369a
md"""
Ce code définit une structure de données abstraite pour représenter un pointeur de nœud dans un arbre
Cette structure possède trois champs : `name`, qui est une chaîne de caractères représentant le nom de la structure, 
`child`, qui est un pointeur vers un nœud enfant de type générique `Node{T}`, 
et `parent`, qui pointe vers un nœud parent de type `Node{T}`.
"""

# ╔═╡ 8c4e3107-ac56-4e2a-a889-b199e7eb8547
md"""
```julia
abstract type Abstractnode_pointer{T} end

mutable struct node_pointer{T} <: Abstractnode_pointer{T}
  name::String
  child::Node{T}
  parent::Node{T}
end
```
"""

# ╔═╡ 6f34b908-e413-4317-a27d-6c6a8df213be
md"""Maintenant, on va définir les fonctions qui vont nous servir pour implémenter l'algorithme kruskal. 
La fonction ci-dessous initialise une structure de composant connexe à partir d'un nœud donné dans le graphe, 
en attribuant le nom du nœud et en le reliant à lui-même comme parent et enfant. 
Cela sert à créer des composants connexes individuels."""

# ╔═╡ 16339626-8605-4ac6-985c-49e11a718af6
md"""
```julia
function node_pointer(Node::Node{T}) where {T}
  name=Node.name 
  return node_pointer(name,Node,Node)
end
```
"""

# ╔═╡ fd8454ba-cee5-4f25-86c1-3f097d09906b
md""" la fonction `find_root` trouve la racine d'un composant connexe. 
Une racine est un composant connexe où l'enfant est égal au parent. 
Si un nœud n'est pas une racine, la fonction remonte de parent en parent jusqu'à atteindre la racine. """

# ╔═╡ 4f23d7d2-1718-4b16-976e-8a24660bbd4e
md"""
```julia
function find_root(c::node_pointer{T},C::Vector{node_pointer{T}}) where {T}

  if c.child!=c.parent

     c=find_root(C[findfirst(x->x.name==c.parent.name,C)],C)
     
  end

  return c
end
```
"""


# ╔═╡ 4e014129-c219-4bf6-945c-245b17b05dae
md""" La fonction `link!` relie deux composants connexes en mettant à jour le parent de c 2 
pour qu'il pointe vers l'enfant de c 1, formant ainsi une liaison entre les deux composants. """

# ╔═╡ c5a3aabd-1786-48fc-ba37-4fac672248cb
md"""
```julia
function link!(c1::node_pointer{T},c2::node_pointer{T},C::Vector{node_pointer{T}}) where {T}

  C[findfirst(x->x.name==c2.name,C)].parent=c1.child
  C
end
```
"""

# ╔═╡ 127a54e2-838f-4ee8-b7db-cfbceec47e48
md"""La fonction ci-dessous relie deux racines des nœuds donnés en arguments. """

# ╔═╡ 59e115ff-d1eb-4056-a031-da6ebd4a550c
md"""
```julia
function unite!(n1::Node{T},n2::Node{T},C::Vector{node_pointer{T}}) where {T}

  link!(find_root(C[findfirst(x->x.name==n1.name,C)],C),find_root(C[findfirst(x->x.name==n2.name,C)],C),C)
  C
end  
```
"""

# ╔═╡ 9d8d7cfe-a427-4d19-8bed-de8a921dafe2
md"""
##### 2. Implémenter l'algorithme de Kruskal et le tester sur l'exemple des notes de cours.
"""

# ╔═╡ b63df5ba-fe18-4b68-b1b8-cc8aa46f7998
md"""Après avoir définit tout le matériel, nous implémontons l'algorithme de kruskal 
d'une manière plus compact. La fonction `kruskal` prend en argument un graphe qui doit etre connexe et retourne l'ensemble des aretes composant l'arbre de recouvrement minimale et la somme des poids des arets que nous avons appelé cout totale.""" 

# ╔═╡ 61b100da-3fd6-42d5-9676-fc3ee2d30ca6
md"""
```julia
import Base.show
include("node_pointer.jl")
function kruskal(graph::Graph{T,S}) where {T,S}


    #Création des composantes connexe initiale
    set_comp_connexe = Vector{node_pointer{T}}()
    for node in graph.Nodes
        push!(set_comp_connexe,node_pointer(node))
    end
    
    #Trie  des arretes du graphe dans un ordre croissant
    sort!(graph.Edges, by=e -> e.data)


    #Initilaisation du vecteur des arêtes composant l'arbre de recouvrement minimal
    A=Vector{Edge{T,S}}()
    total_cost=0

    #Selection des arêtes qui fera partie de l'arbre de recouvrement minimal 
    for edge in graph.Edges

        # Trouver la racine de la composante connexe contenant le premier nœud de l'arete
        x=find_root(set_comp_connexe[findfirst(x->x.name==edge.node1.name,set_comp_connexe)],set_comp_connexe)

        # Trouver la racine de la composante connexe contenant le deuxième nœud de l'arete
        y=find_root(set_comp_connexe[findfirst(x->x.name==edge.node2.name,set_comp_connexe)],set_comp_connexe)

        #Si les deux nœuds appartiennent à des composantes connexes différentes (pour éviter les cycles)
        if x!=y
            # Ajouter l'arete à l'ensemble des aretes qui vont constituer l'arbre de recouvrement minimal
            push!(A,edge)
            # liaison des deux composantes connexes
            unite!(edge.node1,edge.node2,set_comp_connexe)  

            # Mettre à jour le coût total de l'arbre de recouvrement minimal
            total_cost+=edge.data
        end   
    end
    return A,total_cost
end
```
"""

# ╔═╡ b55a2239-968f-48df-a867-933efcb4b86e
md"""Testons l'algorithme sur l'exemple du cours.""" 

# ╔═╡ 4c326a3e-fc60-4732-b48f-9fb2146dce6e
md""" Créons alors le graphe montré en cours :"""

# ╔═╡ ab9964f8-856e-4fe9-bcab-914bd3102388
md""" 
``` julia
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
G=Graph("small",N,E)
```
"""

# ╔═╡ d33138a8-4521-4e6c-a14b-a3c9bf6a346b
md"""Algorithme de Kruskal appliqué au graphe du cours qui retourne l'arbre de recouvrement minimal et le coût de cette arbre"""

# ╔═╡ 3e2249ce-2411-4ba4-bd18-033689e41ae2
md"""
```julia
A,B=kruskal(G) 

println("the minimun spanning tree are composed of:")
for a in A
    show(a)
end
println("the total cost is ",B)
```
"""

# ╔═╡ 481cf377-6d0b-42c9-bdec-6ea229805ed0
md"""#### Résultat :"""

# ╔═╡ 63f51ecf-1760-4122-80ce-a0bf6a868b5c
md"""
```julia
the minimun spanning tree are composed of:
Edge HG bounds H and G,his weight is 1
Edge IC bounds I and C,his weight is 2
Edge GF bounds G and F,his weight is 2
Edge AB bounds A and B,his weight is 4
Edge CF bounds C and F,his weight is 4
Edge CD bounds C and D,his weight is 7
Edge AH bounds A and H,his weight is 8
Edge DE bounds D and E,his weight is 9
the total cost is 37
```
"""

# ╔═╡ 56190668-c0d7-4fd8-8159-2389852c4bfd
md"""
##### 3. Accompagner votre code de tests unitaires.
"""

# ╔═╡ c450bddb-9cf8-46a5-8d68-f153872cf29a
md"""
```
Les tests unitaires sont présents dans le fichier test.jl. Nous avons implémenter les tests unitaires ci-dessous.
```
"""

# ╔═╡ b15a92ef-c7d1-409c-8d2d-b011ed005de5
md""" 
```julia
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
```
"""

# ╔═╡ c7ad79b3-5ac5-496a-a943-872340fe360f
md"""#### Résultat :"""

# ╔═╡ 1bbf53cc-bb82-43ef-9f48-fbb8ad253b55
md"""
```julia
the minimun spanning tree are composed of:
Edge HG bounds H and G,his weight is 1
Edge IC bounds I and C,his weight is 2
Edge GF bounds G and F,his weight is 2
Edge AB bounds A and B,his weight is 4
Edge CF bounds C and F,his weight is 4
Edge CD bounds C and D,his weight is 7
Edge AH bounds A and H,his weight is 8
Edge DE bounds D and E,his weight is 9
the total cost is 37
Test Passed
```
"""

# ╔═╡ ea296f84-65b8-47c7-8bcf-c5f39055711a
md"""
##### 4. tester votre implémentation sur diverses instances de TSP symétrique dans un programme principal et commenter.
"""

# ╔═╡ 16b10cd0-7969-404e-a226-8af6500bff2a
md""" Code du programme principale : """

# ╔═╡ 1ad3c3ef-7407-473b-a1fc-92e6ac118b63
md"""
```julia
include("../phase1/main.jl")
include("kruskal.jl")




# création du graphe à partir bayg29.tsp

G=create_graph("/Users/mouhtal/Desktop/mth6412b-starter-code-1/instances/stsp/bayg29.tsp")

#Test sur le fichier bayg29.tsp
A,B=kruskal(G)

println("the minimun spanning tree are composed of:")
for a in A
    show(a)
end
println("the total cost is ",B)
```
"""


# ╔═╡ d38a7590-50d9-4730-99f8-10db3be53d13
md""" Test sur le fichier bayg29.tsp"""

# ╔═╡ aff84e04-709b-46e6-bb0e-7ceafb5f8799
md"""
```julia
G=create_graph("/Users/mouhtal/Desktop/mth6412b-starter-code-1/instances/stsp/bayg29.tsp")
A,B=kruskal(G)

println("the minimun spanning tree are composed of:")
for a in A
    show(a)
end
println("the total cost is ",B)
```
"""

# ╔═╡ be38727a-edf3-4272-a0c7-5105cd15abbf
md"""#### Résultat :"""

# ╔═╡ 1384e8db-3032-467b-a779-01f48ac66ed6
md"""
```julia
the minimun spanning tree are composed of:
Edge (10, 20) bounds 10 and 20,his weight is 25.0
Edge (14, 18) bounds 14 and 18,his weight is 32.0
Edge (1, 28) bounds 1 and 28,his weight is 34.0  
Edge (4, 15) bounds 4 and 15,his weight is 34.0  
Edge (14, 22) bounds 14 and 22,his weight is 36.0
Edge (26, 29) bounds 26 and 29,his weight is 36.0
Edge (24, 27) bounds 24 and 27,his weight is 38.0
Edge (4, 10) bounds 4 and 10,his weight is 39.0  
Edge (8, 27) bounds 8 and 27,his weight is 39.0  
Edge (2, 21) bounds 2 and 21,his weight is 41.0  
Edge (5, 9) bounds 5 and 9,his weight is 42.0    
Edge (6, 12) bounds 6 and 12,his weight is 46.0  
Edge (17, 22) bounds 17 and 22,his weight is 47.0
Edge (16, 27) bounds 16 and 27,his weight is 48.0
Edge (2, 20) bounds 2 and 20,his weight is 49.0  
Edge (15, 19) bounds 15 and 19,his weight is 49.0
Edge (5, 21) bounds 5 and 21,his weight is 50.0  
Edge (5, 6) bounds 5 and 6,his weight is 51.0    
Edge (5, 26) bounds 5 and 26,his weight is 51.0  
Edge (10, 13) bounds 10 and 13,his weight is 51.0
Edge (1, 24) bounds 1 and 24,his weight is 52.0  
Edge (6, 28) bounds 6 and 28,his weight is 52.0  
Edge (19, 25) bounds 19 and 25,his weight is 52.0
Edge (15, 18) bounds 15 and 18,his weight is 56.0
Edge (3, 29) bounds 3 and 29,his weight is 60.0  
Edge (11, 22) bounds 11 and 22,his weight is 63.0
Edge (7, 25) bounds 7 and 25,his weight is 72.0  
Edge (23, 27) bounds 23 and 27,his weight is 74.0
the total cost is 1319.0
```
"""

# ╔═╡ 201f6e55-daf7-4fce-aef5-fb00ad48770d
md""" Test sur le fichier bays29.tsp"""

# ╔═╡ 77714937-68a7-4a05-9f35-2eb508069506
md"""
```julia
G=create_graph("/Users/mouhtal/Desktop/mth6412b-starter-code-1/instances/stsp/bays29.tsp")
A,B=kruskal(G)

println("the minimun spanning tree are composed of:")
for a in A
    show(a)
end
println("the total cost is ",B)
```
"""

# ╔═╡ 1ee8ce73-1d27-4232-871d-e18e40f2e806
md"""#### Résultat :"""

# ╔═╡ 5e7e90e8-1088-4c75-9474-d51a7327e1df
md"""
```
the minimun spanning tree are composed of:
Edge (10, 20) bounds 10 and 20,his weight is 28.0
Edge (14, 18) bounds 14 and 18,his weight is 35.0
Edge (4, 15) bounds 4 and 15,his weight is 38.0
Edge (26, 29) bounds 26 and 29,his weight is 39.0
Edge (24, 27) bounds 24 and 27,his weight is 41.0
Edge (2, 21) bounds 2 and 21,his weight is 42.0
Edge (4, 10) bounds 4 and 10,his weight is 42.0
Edge (8, 27) bounds 8 and 27,his weight is 43.0
Edge (14, 22) bounds 14 and 22,his weight is 44.0
Edge (1, 28) bounds 1 and 28,his weight is 45.0
Edge (5, 9) bounds 5 and 9,his weight is 46.0
Edge (6, 12) bounds 6 and 12,his weight is 55.0
Edge (16, 27) bounds 16 and 27,his weight is 55.0
Edge (15, 18) bounds 15 and 18,his weight is 56.0
Edge (15, 19) bounds 15 and 19,his weight is 56.0
Edge (5, 26) bounds 5 and 26,his weight is 57.0
Edge (10, 13) bounds 10 and 13,his weight is 57.0
Edge (14, 17) bounds 14 and 17,his weight is 59.0
Edge (6, 28) bounds 6 and 28,his weight is 60.0
Edge (5, 6) bounds 5 and 6,his weight is 61.0
Edge (1, 21) bounds 1 and 21,his weight is 65.0
Edge (16, 19) bounds 16 and 19,his weight is 66.0
Edge (1, 24) bounds 1 and 24,his weight is 67.0
Edge (19, 25) bounds 19 and 25,his weight is 69.0
Edge (3, 29) bounds 3 and 29,his weight is 77.0
Edge (11, 15) bounds 11 and 15,his weight is 79.0
Edge (23, 27) bounds 23 and 27,his weight is 80.0
Edge (7, 25) bounds 7 and 25,his weight is 95.0
the total cost is 1557.0
```
"""

# ╔═╡ f4fcf415-bd09-4493-82fd-7d9c054dbf60
md""" Test sur le fichier swiss42.tsp"""

# ╔═╡ a5d12422-a0d9-4741-963c-a38450c347d7
md"""
```julia
#du graphe à partir bayg29.tsp

G=create_graph("/Users/mouhtal/Desktop/mth6412b-starter-code-1/instances/stsp/swiss42.tsp")

#Test sur le fichier bayg29.tsp
A,B=kruskal(G)

println("the minimun spanning tree are composed of:")
for a in A
    show(a)
end
println("the total cost is ",B)
```
"""

# ╔═╡ 1af51dff-d647-41a6-aa32-a84a35e3b054
md"""#### Résultat :"""

# ╔═╡ ce87222b-1a28-4696-a784-7c72d5274a19
md"""
```
the minimun spanning tree are composed of:
Edge (3, 28) bounds 3 and 28,his weight is 4.0
Edge (15, 17) bounds 15 and 17,his weight is 8.0
Edge (3, 4) bounds 3 and 4,his weight is 11.0
Edge (4, 5) bounds 4 and 5,his weight is 11.0
Edge (15, 16) bounds 15 and 16,his weight is 11.0
Edge (12, 13) bounds 12 and 13,his weight is 14.0
Edge (1, 2) bounds 1 and 2,his weight is 15.0
Edge (6, 27) bounds 6 and 27,his weight is 15.0
Edge (3, 29) bounds 3 and 29,his weight is 18.0
Edge (2, 7) bounds 2 and 7,his weight is 19.0
Edge (24, 42) bounds 24 and 42,his weight is 19.0
Edge (5, 7) bounds 5 and 7,his weight is 20.0
Edge (18, 32) bounds 18 and 32,his weight is 21.0
Edge (30, 31) bounds 30 and 31,his weight is 21.0
Edge (11, 26) bounds 11 and 26,his weight is 22.0
Edge (16, 38) bounds 16 and 38,his weight is 22.0
Edge (6, 7) bounds 6 and 7,his weight is 23.0
Edge (19, 27) bounds 19 and 27,his weight is 23.0
Edge (21, 35) bounds 21 and 35,his weight is 23.0
Edge (21, 34) bounds 21 and 34,his weight is 24.0
Edge (14, 20) bounds 14 and 20,his weight is 25.0
Edge (13, 19) bounds 13 and 19,his weight is 26.0
Edge (22, 40) bounds 22 and 40,his weight is 26.0
Edge (10, 24) bounds 10 and 24,his weight is 27.0
Edge (29, 30) bounds 29 and 30,his weight is 27.0
Edge (9, 10) bounds 9 and 10,his weight is 28.0
Edge (12, 26) bounds 12 and 26,his weight is 28.0
Edge (9, 11) bounds 9 and 11,his weight is 29.0
Edge (22, 41) bounds 22 and 41,his weight is 30.0
Edge (2, 8) bounds 2 and 8,his weight is 32.0
Edge (18, 38) bounds 18 and 38,his weight is 33.0
Edge (6, 20) bounds 6 and 20,his weight is 34.0
Edge (15, 20) bounds 15 and 20,his weight is 35.0
Edge (23, 39) bounds 23 and 39,his weight is 36.0
Edge (1, 33) bounds 1 and 33,his weight is 37.0
Edge (23, 40) bounds 23 and 40,his weight is 39.0
Edge (36, 37) bounds 36 and 37,his weight is 39.0
Edge (10, 40) bounds 10 and 40,his weight is 46.0
Edge (25, 41) bounds 25 and 41,his weight is 49.0
Edge (33, 35) bounds 33 and 35,his weight is 49.0
Edge (32, 36) bounds 32 and 36,his weight is 60.0
the total cost is 1079.0
```
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
InteractiveUtils = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "348ed7e828d2091a44e211d4df367eb5f2d0eb19"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
"""

# ╔═╡ Cell order:
# ╟─41d11a17-73b7-4da2-999d-a9ceda200969
# ╟─0829e03c-8bc6-4c0d-b1c2-572dd831cb1a
# ╟─9f427156-bc94-4877-80f9-3db6f178f274
# ╟─c8cc4922-0f3b-4c3a-b444-8045b67205c8
# ╟─b727f17a-8843-4d23-941b-698c19c5c6c1
# ╟─2f59b97d-e868-46bc-9945-76075015d4cc
# ╟─322e6e27-5af8-49b0-96f4-025bbf2403f4
# ╟─48b7402e-7cfc-4e5f-87a0-b67bca4eb326
# ╟─3d9e6b3c-8179-4759-a862-146fe1872464
# ╟─063e8297-bc61-4bde-85d0-8f144185c6d3
# ╟─b4aac71c-7ec4-41b6-8d85-02b8c3dc742d
# ╟─d970b71a-1f3f-46c8-93ce-df35125d369a
# ╟─8c4e3107-ac56-4e2a-a889-b199e7eb8547
# ╟─6f34b908-e413-4317-a27d-6c6a8df213be
# ╟─16339626-8605-4ac6-985c-49e11a718af6
# ╠═fd8454ba-cee5-4f25-86c1-3f097d09906b
# ╟─4f23d7d2-1718-4b16-976e-8a24660bbd4e
# ╠═4e014129-c219-4bf6-945c-245b17b05dae
# ╟─c5a3aabd-1786-48fc-ba37-4fac672248cb
# ╠═127a54e2-838f-4ee8-b7db-cfbceec47e48
# ╟─59e115ff-d1eb-4056-a031-da6ebd4a550c
# ╟─9d8d7cfe-a427-4d19-8bed-de8a921dafe2
# ╠═b63df5ba-fe18-4b68-b1b8-cc8aa46f7998
# ╟─61b100da-3fd6-42d5-9676-fc3ee2d30ca6
# ╟─b55a2239-968f-48df-a867-933efcb4b86e
# ╟─4c326a3e-fc60-4732-b48f-9fb2146dce6e
# ╟─ab9964f8-856e-4fe9-bcab-914bd3102388
# ╟─d33138a8-4521-4e6c-a14b-a3c9bf6a346b
# ╟─3e2249ce-2411-4ba4-bd18-033689e41ae2
# ╟─481cf377-6d0b-42c9-bdec-6ea229805ed0
# ╟─63f51ecf-1760-4122-80ce-a0bf6a868b5c
# ╟─56190668-c0d7-4fd8-8159-2389852c4bfd
# ╟─c450bddb-9cf8-46a5-8d68-f153872cf29a
# ╟─b15a92ef-c7d1-409c-8d2d-b011ed005de5
# ╟─c7ad79b3-5ac5-496a-a943-872340fe360f
# ╟─1bbf53cc-bb82-43ef-9f48-fbb8ad253b55
# ╟─ea296f84-65b8-47c7-8bcf-c5f39055711a
# ╟─16b10cd0-7969-404e-a226-8af6500bff2a
# ╟─1ad3c3ef-7407-473b-a1fc-92e6ac118b63
# ╟─d38a7590-50d9-4730-99f8-10db3be53d13
# ╟─aff84e04-709b-46e6-bb0e-7ceafb5f8799
# ╟─be38727a-edf3-4272-a0c7-5105cd15abbf
# ╟─1384e8db-3032-467b-a779-01f48ac66ed6
# ╟─201f6e55-daf7-4fce-aef5-fb00ad48770d
# ╟─77714937-68a7-4a05-9f35-2eb508069506
# ╟─1ee8ce73-1d27-4232-871d-e18e40f2e806
# ╟─5e7e90e8-1088-4c75-9474-d51a7327e1df
# ╟─f4fcf415-bd09-4493-82fd-7d9c054dbf60
# ╟─a5d12422-a0d9-4741-963c-a38450c347d7
# ╟─1af51dff-d647-41a6-aa32-a84a35e3b054
# ╟─ce87222b-1a28-4696-a784-7c72d5274a19
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
