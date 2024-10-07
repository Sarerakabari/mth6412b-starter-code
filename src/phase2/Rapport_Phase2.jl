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


# ╔═╡ 56190668-c0d7-4fd8-8159-2389852c4bfd
md"""
##### 3. Accompagner votre code de tests unitaires.
"""

# ╔═╡ c450bddb-9cf8-46a5-8d68-f153872cf29a
md"""
```
Les tests unitaires sont présents dans le fichier test.jl
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
# ╠═63f51ecf-1760-4122-80ce-a0bf6a868b5c
# ╟─56190668-c0d7-4fd8-8159-2389852c4bfd
# ╟─c450bddb-9cf8-46a5-8d68-f153872cf29a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
