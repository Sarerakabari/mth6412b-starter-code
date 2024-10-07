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

# ╔═╡ 2f59b97d-e868-46bc-9945-76075015d4cc
md""" Le  code se trouve au lien suivant: """

# ╔═╡ 322e6e27-5af8-49b0-96f4-025bbf2403f4
md"""[https://github.com/Sarerakabari/mth6412b-starter-code/tree/Phase_2/src/phase2](https://github.com/Sarerakabari/mth6412b-starter-code/tree/Phase_2/src/phase2)"""

# ╔═╡ 063e8297-bc61-4bde-85d0-8f144185c6d3
md""" Le lecteur peut fork le projet et lancer le fichier main.jl pour retrouver les résultats ci-dessous"""

# ╔═╡ b4aac71c-7ec4-41b6-8d85-02b8c3dc742d
md"""
##### 1. Choisir et implémenter une structure de données pour les composantes connexes d’un graphe
"""

# ╔═╡ d970b71a-1f3f-46c8-93ce-df35125d369a
md"""
Implementation proposée d'une structure composante connexe : noeud qui pointe le parent"""

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
md"""Constructeur pour un composant connexe.Un noeud est son propre parent"""

# ╔═╡ 16339626-8605-4ac6-985c-49e11a718af6
md"""
```julia
function node_pointer(Node::Node{T}) where {T}
name=Node.name 
return node_pointer(name,Node,Node)
end
```
"""

# ╔═╡ 549070f3-187c-42f9-b89e-bd992a1538ea
md""" Méthode pour unir des composants connexes composés des 2 noeuds d'un arête d'un graph """

# ╔═╡ 3af3a294-b0d8-49f0-bbd0-9d13172df39c
md"""
```julia
function link!(c1::node_pointer{T},c2::node_pointer{T},C::Vector{node_pointer{T}}) where {T}

  C[findfirst(x->x.name==c2.name,C)].parent=c1.child
  C
end
```
"""


# ╔═╡ fd8454ba-cee5-4f25-86c1-3f097d09906b
md"""  Méthode pour trouver la racine du composant connexe """

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


# ╔═╡ 9d8d7cfe-a427-4d19-8bed-de8a921dafe2
md"""
##### 2. Implémenter l'algorithme de Kruskal et le tester sur l'exemple des notes de cours.
"""

# ╔═╡ b63df5ba-fe18-4b68-b1b8-cc8aa46f7998
md"""Algorithme Kruskal pour trouver l'arbre de recouvrement minimale 
   dans un graphe non orienté""" 

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


        x=find_root(set_comp_connexe[findfirst(x->x.name==edge.node1.name,set_comp_connexe)],set_comp_connexe)
       
        y=find_root(set_comp_connexe[findfirst(x->x.name==edge.node2.name,set_comp_connexe)],set_comp_connexe)
        if x!=y
            push!(A,edge)
            unite!(edge.node1,edge.node2,set_comp_connexe)  
            total_cost+=edge.data
        end   
    end
    return A,total_cost
end
```
"""

# ╔═╡ b55a2239-968f-48df-a867-933efcb4b86e
md"""Testons sur l'exemple du cours.""" 

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
Les tests unitaires sont présents dans le unitary_test_phase_2.jl
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
include("read_stsp.jl")
include("node.jl")
include("Edge.jl")
include("graph.jl")
include("../phase2/kruskal.jl")
#Fonction qui construit un graph avec les données stsp

function create_graph(filename::String)
#Création de l' entête
header=read_header(filename)

#Lecture des noeuds
nodes=read_nodes(header,filename)

#Lecture des arêtes et les poids
edges,weights=read_edges(header,filename)

#Initialisation
dim=parse(Int, header["DIMENSION"])
nodes_vec=Node{Vector{Float64}}[]
edges_vec=Edge{Vector{Float64}, Float64}[]

#Création du vecteur de noeuds
if isnothing(nodes)

 for id in 1:dim
        new_node=Node(string(id),Float64[])
        push!(nodes_vec,new_node)
    end

else
    nodes=sort(nodes, by=first)



 for id in 1:dim
        new_node=Node(string(id),nodes[id])
        push!(nodes_vec,new_node)
    end
end

###Création du vecteur des arêtes

for i in eachindex(edges)

 new_edge =Edge(string(edges[i]),parse(Float64,weights[i]),nodes_vec[edges[i][1]],nodes_vec[edges[i][2]])
 push!(edges_vec,new_edge)

end
#création du graph
return graph=Graph(header["NAME"],nodes_vec,edges_vec) 
end




#du graphe à partir bayg29.tsp

G=create_graph("C:/Users/Ando/Desktop/mth6412b-starter-code/instances/stsp/bays29.tsp")

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
G=create_graph("C:/Users/Ando/Desktop/mth6412b-starter-code/instances/stsp/bayg29.tsp")
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
G=create_graph("C:/Users/Ando/Desktop/mth6412b-starter-code/instances/stsp/bays29.tsp")
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

julia_version = "1.10.4"
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
# ╟─2f59b97d-e868-46bc-9945-76075015d4cc
# ╟─322e6e27-5af8-49b0-96f4-025bbf2403f4
# ╟─063e8297-bc61-4bde-85d0-8f144185c6d3
# ╟─b4aac71c-7ec4-41b6-8d85-02b8c3dc742d
# ╟─d970b71a-1f3f-46c8-93ce-df35125d369a
# ╟─8c4e3107-ac56-4e2a-a889-b199e7eb8547
# ╟─6f34b908-e413-4317-a27d-6c6a8df213be
# ╟─16339626-8605-4ac6-985c-49e11a718af6
# ╠═549070f3-187c-42f9-b89e-bd992a1538ea
# ╟─3af3a294-b0d8-49f0-bbd0-9d13172df39c
# ╟─fd8454ba-cee5-4f25-86c1-3f097d09906b
# ╟─4f23d7d2-1718-4b16-976e-8a24660bbd4e
# ╟─9d8d7cfe-a427-4d19-8bed-de8a921dafe2
# ╟─b63df5ba-fe18-4b68-b1b8-cc8aa46f7998
# ╟─61b100da-3fd6-42d5-9676-fc3ee2d30ca6
# ╟─b55a2239-968f-48df-a867-933efcb4b86e
# ╠═4c326a3e-fc60-4732-b48f-9fb2146dce6e
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
# ╠═16b10cd0-7969-404e-a226-8af6500bff2a
# ╟─1ad3c3ef-7407-473b-a1fc-92e6ac118b63
# ╟─d38a7590-50d9-4730-99f8-10db3be53d13
# ╟─aff84e04-709b-46e6-bb0e-7ceafb5f8799
# ╟─be38727a-edf3-4272-a0c7-5105cd15abbf
# ╟─1384e8db-3032-467b-a779-01f48ac66ed6
# ╟─201f6e55-daf7-4fce-aef5-fb00ad48770d
# ╟─77714937-68a7-4a05-9f35-2eb508069506
# ╟─1ee8ce73-1d27-4232-871d-e18e40f2e806
# ╟─5e7e90e8-1088-4c75-9474-d51a7327e1df
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
