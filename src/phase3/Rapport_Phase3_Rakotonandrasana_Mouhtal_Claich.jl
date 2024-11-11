### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ c85637a0-955f-11ef-1fa3-331ecdf30dde
using Markdown

# ╔═╡ 9cdc3542-bf7d-4214-b4f8-ff58eb10f1b7
using InteractiveUtils

# ╔═╡ 553bc20a-931c-4ae3-8793-d438b2b62e49
using Logging

# ╔═╡ f4356908-80a8-4db2-bec2-33e8f43f4fea
md"""
### Mini rapport: Phase 3 du projet
#
"""

# ╔═╡ 0f0f8abb-36f5-4b99-bbab-971e31a8fd80
md"""
```
Auteurs:Ando Rakotonandrasana
		Oussama Mouhtal
		Octave Claich
```
"""

# ╔═╡ ab5cb352-4cfb-4fa7-b58a-e689d46cbdda
md""" Le  code se trouve au lien suivant : """

# ╔═╡ 7f9ebe74-574a-410b-959f-f34ebc4dc04c
md"""
[https://github.com/Sarerakabari/mth6412b-starter-code/tree/phase3/src/phase3](https://github.com/Sarerakabari/mth6412b-starter-code/tree/phase3/src/phase3)
"""

# ╔═╡ 58e87236-ff58-4b87-8e8d-c78cd964b4de
md""" Tous les implementations de cette phase sont inspirées du livre ci-dessous :"""

# ╔═╡ 5c2d39fb-4927-43a2-92e1-a487ce3db296
md"""
 ###### Cormen, Thomas H and Leiserson, Charles E and Rivest, Ronald L and Stein, Clifford. (2022). Introduction to algorithms. MIT press.
"""

# ╔═╡ d80a0141-fa83-4591-9488-a8ed85ddf42a
md""" Le lecteur peut fork le projet et lancer le fichier main.jl pour retrouver les résultats ci-dessous"""

# ╔═╡ 00851568-a078-4d8b-b424-f15aa0c50a39
md"""
##### 1. Implémenter les deux heuristiques d'accélération et répondre à la question sur le rang
"""

# ╔═╡ 62fb07d4-02ad-4ba4-8296-215e69e99d70
md"""Nous avons choisi de réécrire le fichier node\_pointer.jl de la phase 2 en un nouveau fichier node\_pointer\_heuristic.jl, qui utilise les deux heuristiques d'union par le rang et de compression des chemins.
"""

# ╔═╡ c63e7407-8b01-472c-aa2d-c7044beff148
begin
	"""Type abstrait dont d'autres types de noeuds dériveront."""
	abstract type AbstractNode{T} end
	
	"""Type représentant les noeuds d'un graphe.
	
	Exemple:
	
	        noeud = Node("James", [π, exp(1)])
	        noeud = Node("Kirk", "guitar")
	        noeud = Node("Lars", 2)
	
	"""
	mutable struct Node{T} <: AbstractNode{T}
	  name::String
	  data::T
	  # test
	end
end

# ╔═╡ 0872bbca-4bf9-4dbd-8b74-48c080e2b0f7
begin
	"""Type abstrait dont d'autres types d'arêtes dériveront."""
	abstract type AbstractEdge{T,S} end
	
	"""Type représentant les aretes d'un graphe.
	
	Exemple:
	
	        noeud1 = Node("James", 12)
	        noeud2= Node("Kirk",14)
	        
	        edge=Edge("(noeud1, noeud2)",12,noeud1,noeud2)
	
	"""
	mutable struct Edge{T,S} <: AbstractEdge{T,S}
	  name::String
	  data::S
	  node1::Node{T}
	  node2::Node{T}
	 
	end
end

# ╔═╡ 7498eab1-75f9-42ee-8a47-edc08864ffe4
begin
	"""Type abstrait dont d'autres types de graphes dériveront."""
	abstract type AbstractGraph{T,S} end
	
	"""Type representant un graphe comme un ensemble de noeuds.
	
	Exemple :
	
	    n1 = Node("Joe", 3.14)
	    n2 = Node("Steve", exp(1))
	    n3 = Node("Jill", 4.12)
	    e1=Edge("1,2",10,n1,n2)
	    e2=Edge("1,3",100,n1,n2)
	    G = Graph("Test", [n1, n2, n3],[e1,e2])
	    show(G)
	
	
	Attention, tous les noeuds doivent avoir des données de même type.
	"""
	mutable struct Graph{T,S} <: AbstractGraph{T,S}
	  Name::String
	  Nodes::Vector{Node{T}}
	  Edges::Vector{Edge{T,S}}
	end
end

# ╔═╡ 31540efc-7ada-4139-92e8-782c91432cee
"""Type abstrait d'un composant connexe: noeud enfant pointant vers le noeud parent ."""
abstract type Abstractnode_pointer{T} end

# ╔═╡ 25f460b0-4d82-4bc4-8568-c3b2d20828eb
"""Type node_pointer (composant connexe) contenant 4 attributs : son nom (de type String), le noeud enfant (de type Node{T})
qui est le noeud à proprement parler, le noeud parent (de type Node{T}), et son rang (de type Int64)."""
mutable struct node_pointer{T} <: Abstractnode_pointer{T}
	name::String
  	child::Node{T}
  	parent::Node{T}
  	rank::Int64
end

# ╔═╡ 9765dbe4-3d0e-4088-8d48-b8f7f3558c1d
md"""
Nous avons également fait figurer dans le fichier kruskal\_heuristic.jl l'algorithme de Kruskal qui est inchangé mais utilise cette fois la nouvelle version de la structure node_pointer.
"""

# ╔═╡ f4832809-8bce-400f-81ba-a9bd29b4ed73
md"""
Réponses aux questions théoriques sur le rang :
"""

# ╔═╡ bbbc3b5b-614c-4633-a188-6b13c0ebd0bc
md"""
1)Pour un graph de ∣S∣ nœuds, le maximum d'arêtes qui peuvent construire un arbre de recouvrement minimal sans former de cycles est ∣S∣−1 (c'est le nombre maximal d'arêtes dans un arbre de recouvrement minimal). Lorsqu'on utilise l'union par rang, chaque opération d'union augmente le rang d'au plus un nœud, d'ou le rang d'un noeud est toujours inférieur à ∣S∣−1.
"""

# ╔═╡ 044512fe-c103-43a0-aacc-48aa642db2a6
md"""
2)Le rang d'un nœud n'augmente que lorsque deux ensembles de tailles similaires sont fusionnés (de rang égaux). Plus précisément :

Pour qu'un nœud atteigne un rang k, il faut qu'il soit la racine d'un ensemble d'au moins $2^k$ nœuds (car à chaque union avec un ensemble de rang égal, la taille de l'ensemble double potentiellement).

Donc, pour un ensemble de $|S|$ nœuds, le rang maximal est borné par la valeur kk telle que $2^k≤∣S∣$, c'est-à-dire $k≤log⁡_2(∣S∣)$.

Ainsi, le rang maximal d'un nœud est toujours inférieur ou égal à $⌊log⁡2(∣S∣)⌋$.

"""

# ╔═╡ c44cc644-0861-4c5d-bc10-3f81eec681b9
md"""
##### 2. Implémenter l'algorithme de Prim vu au laboratoire
"""

# ╔═╡ 96a22b4a-2339-4e10-a094-dbf726c16b13
md"""
Pour implémenter l'algorithme de Prim, nous avons commencé par créer un fichier node\_priority.jl. L'idée est de pouvoir implémenter une structure node\_priority qui va représenter les noeuds tels qu'ils sont utilisés dans l'algorithme de Prim, i.e. munis d'un parent et d'une priorité notamment.
"""

# ╔═╡ ae2f80da-3fff-46b9-b627-a4d0426071ed
"""Type abstrait d'un node_priority."""
abstract type Abstractnode_priority{T} end

# ╔═╡ c9669e96-19df-43b2-b6d9-8320145717f4
"""Type node_priority contentant 4 attributs : son nom (de type String), le noeud en lui-même (de type Node{T}),
son parent (qui est soit de type Node{T}, soit Nothing), et sa priorité (qui est un nombre)."""
mutable struct node_priority{T} <: Abstractnode_priority{T}
name::String
node::Node{T}
parent::Union{Node{T}, Nothing}
priority::Number
end

# ╔═╡ e7f1431d-23bd-4607-9e26-c06f28b88e50
"""
    parent!(p::node_priority,parent::Node)

Mise à jour du parent d'un élément de type node_priority

# Arguments
- `p::node_priority`: élément de type node_priority dont on va vouloir modifier le parent
- `parent::Node`: noeud qui sera le nouveau parent de la node_priority.
"""
function parent!(p::node_priority,parent::Node)
p.parent = parent
p
end

# ╔═╡ b37f56ff-01e3-4e8f-9811-e1b46e028c47
"""
    isless(p::node_priority, q::node_priority)

Définition d'une relation d'ordre entre éléments de type node_priority
"""
isless(p::node_priority, q::node_priority) = priority(p) < priority(q)

# ╔═╡ 2ed59c8a-fb1d-4334-afb6-063688d9219b

"""
    priority!(p::node_priority, priority::Number)

Mise à jour de la priorité d'un élément de type node_priority

# Arguments
- `p::node_priority`: élément de type node_priority dont on va vouloir modifier la priorité
- `priority::Number`: nouvelle valeur de la priorité
"""
function priority!(p::node_priority, priority::Number)
p.priority = max(0, priority)
p
end

# ╔═╡ 6bd39cce-6899-4c70-a8ec-5cdfa1416feb
"""
    ==(p::node_priority, q::node_priority)

Définition d'une relation d'égalité entre éléments de type node_priority
"""
==(p::node_priority, q::node_priority) = priority(p) == priority(q)


# ╔═╡ 20044732-62cf-47f2-8b11-602e97068583
""" 
	find_root(c::node_pointer{T},C::Vector{node_pointer{T}}) where {T}

find_root sert à trouver la racine dans un ensemble de composantes connexes. 
Une racine est déinie par une composante connexe dont l'enfant est lui-même le parent.

# Arguments
- `c::node_pointer{T}`: node_pointer de départ dont on cherche la racine
- `C::Vector{node_pointer{T}}`: vecteurs de composantes connexes parmi lesquelles on va chercher la racine
"""
function find_root(c::node_pointer{T},C::Vector{node_pointer{T}}) where {T}

  if c.child!=c.parent
     c=find_root(C[findfirst(x->x.name==c.parent.name,C)],C)
  end

  return c
end

# ╔═╡ 5255fbd3-d606-404d-a5f8-14f093f5dc11
""" 
	link!(c1::node_pointer{T},c2::node_pointer{T},C::Vector{node_pointer{T}}) where {T}

Liaison de deux composantes connexes dans un ensemble de composantes connexes en utilisant
l'heuristique d'union par le rang. 

# Arguments
- `c1::node_pointer{T}`: premier composant connexe à unir
- `c2::node_pointer{T}`: deuxième composant connexe à unir
- `C::Vector{node_pointer{T}}`: vecteurs de composantes connexes dans lequel vivent c1 et c2
"""
function link!(c1::node_pointer{T},c2::node_pointer{T},C::Vector{node_pointer{T}}) where {T}

  if c1.rank > c2.rank
    C[findfirst(x->x.name==c2.name,C)].parent=c1.child
   else 
    C[findfirst(x->x.name==c1.name,C)].parent=c2.child
     if c1.rank==c2.rank
        C[findfirst(x->x.name==c2.name,C)].rank+=1
     end
    end
  C
end

# ╔═╡ e4a17960-23dc-4350-82d7-f3ba35a36edc
""" 
	unite!(n1::Node{T},n2::Node{T},C::Vector{node_pointer{T}}) where {T}

Liaison en utilisant l'heuristique de compression de chemins.

# Arguments
- `n1::Node{T}`: premier noeud à unir
- `n2::Node{T}`: deuxième noeud à unir
- `C::Vector{node_pointer{T}}`: vecteur de composants connexes dans lequel vivent les deux noeuds considérés.
"""
function unite!(n1::Node{T},n2::Node{T},C::Vector{node_pointer{T}}) where {T}

  link!(find_root(C[findfirst(x->x.name==n1.name,C)],C),find_root(C[findfirst(x->x.name==n2.name,C)],C),C)
  C
end    

# ╔═╡ 911b959a-d86c-49ca-a9c0-9a187755fd07
md"""
Le fichier queue.jl fait ensuite figurer l'implémentation d'une file de priorité. Nous nous sommes aidés du fichier donné dans le cours pour cela.
"""

# ╔═╡ 458e242d-d27d-4a0d-b77d-98f35bba7278
"""Type abstrait de Queue. """
abstract type AbstractQueue{T} end

# ╔═╡ e4cfb9a2-af1e-4e3a-9358-9a12832bc0c5
"""Type représentant une file de priorité avec des éléments node_priority de type T."""
mutable struct node_Queue{T} <: AbstractQueue{T}
items::Vector{node_priority{T}}
end

# ╔═╡ 4bab34c5-b69b-4442-b27d-f5e416446934
"""
    push!(q::AbstractQueue{T}, item::node_priority{T}) where T

Ajoute l'élément item à la file de priorité q

# Arguments
- `q::AbstractQueue{T}`: file de priorité considérée
- `item::node_priority{T}`: élément à ajouter à la file
"""
function push!(q::AbstractQueue{T}, item::node_priority{T}) where T
push!(q.items, item)
q
end

# ╔═╡ d2e4c0e6-6c12-4828-8027-82893eb2561a
"""
    kruskal(graph::Graph{T,S}) where {T,S}

Version de l'algorithme de Kruskal utilisant la nouvelle implémentation de la structure node_pointer, avec les heuristiques utilisées.

# Arguments
- `graph::Graph{T,S}`:  le graph sur lequel on va chercher à construire un arbre de recouvrement minimal.
"""
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
    mst=Graph("MST",G.Nodes,A)
    return  mst,total_cost
end

# ╔═╡ e492b845-0d0b-4110-8706-c2ff8e0fc74e
"""
    popfirst!(q::AbstractQueue{T}) where T

Retire et renvoie l'élément de plus basse priorité

# Arguments
- `q::AbstractQueue{T}`: file de priorité considérée
"""
function popfirst!(q::AbstractQueue{T}) where T

idx = argmin(q.items)

first=q.items[idx]

deleteat!(q.items, idx)

first

end

# ╔═╡ e4c42c07-41aa-4ea3-b6a0-eb131eeb9fee
md"""
Le fichier prim.jl contient l'implémentation de l'algorithme de Prim en utilisant les files de priorités évoquées ci-dessus.
"""

# ╔═╡ 5e2a5f18-da89-49ec-a90e-f7128023c4ab
"""
    prim(graph::Graph{T,S}) where {T,S}

Algorithme de Prim, qui renvoie un vecteur d'arêtes représentant un arbre de recouvrement minimal du graph donné en argument,
et le poids total de cet arbre de recouvrement minimal.

# Arguments
- `graph::Graph{T,S}`: le graph considéré dont on cherche un arbre de recouvrement minimal.
"""
function prim(graph::Graph{T,S}) where {T,S}


    #Création d'une file de priorité vide

    Q=node_Queue{node_priority{T}}()

    #initialisation de la file de priorité 
    for node in graph.Nodes
        push!(Q,node_priority(node))
        
    end
    # Choix arbitraire d'un noeud de priorité ) 
    priority!(Q.items[1],0)
   
    #Initilaisation du vecteur des arêtes composant l'arbre de recouvrement minimal et du cout total
    A=Vector{Edge{T,S}}()
    total_cost=0

    #Selection des arêtes qui fera partie de l'arbre de recouvrement minimal 
    while !is_empty(Q)
        #noeud de priorité maximal
        u=popfirst!(Q)
        
        #voisin du noeud u
        u_neighboor=findall(x->x.node1==u.node||x.node2==u.node,G.Edges)
       
        # initialisation de l'arête legère et son indice
        min_weight=Inf
        idx=nothing


        for i in u_neighboor

            # Voisin de u dans Q
            if G.Edges[i].node1==u.node 
            j=findfirst(x->x.node==G.Edges[i].node2,Q.items)
            else
            j=findfirst(x->x.node==G.Edges[i].node1,Q.items)    
            end
           
            
            if !isnothing(j) 
                
                #mise à jour de priorité de Q
                if G.Edges[i].data < Q.items[j].priority

                   priority!(Q.items[j],G.Edges[i].data)
                   
                   parent!(Q.items[j],u.node)
                    
                end
              
                
            end

        end    

        # ajout de l'arête legère

        if !isnothing(u.parent)
            push!(A,Edge(string(u.parent.name,u.node.name),u.priority,u.parent,u.node))
            total_cost+=u.priority
        end   
    end
    # création de l'arbre de recouvrement minimale 
    mst=Graph("MST",G.Nodes,A)
    
    return mst,total_cost
end

# ╔═╡ 8011f100-2141-4ba7-b5c6-dc17ed4aa7ef
md"""
##### 3. Tester votre implémentation sur l'exemple des notes de cours et diverses instances de TSP symétrique dans vos tests unitaires.
"""

# ╔═╡ c5426a02-687d-4d17-bab9-56000eadcb31
md"""
Les tests unitaires sont présents dans le fichier test.jl. On a à nouveau utilisé les noeuds, arêtes et graph de l'exemple des notes de cours (comme dans la phase précédente).
Les tests effectués sur l'algorithme de Kruskal figurent encore dans le fichier test.jl (pour vérifier qu'en ajoutant les nouvelles heuristiques, il fonctionne toujours), et s'ajoutent maintenant des tests effectués pour vérifier que l'algorithme de Prim fonctionne correctement.
On commence par des tests pour vérifier que les types node_priority et queue sont correctement implémentés, puis on applique l'algorithme de Prim et on vérifie que cela donne bien la valeur recherchée.
"""

# ╔═╡ 5dac4b6e-d3d6-42d0-b29b-7120b52dbe07
md"""
Le fichier main.jl lance les algorithmes de Kruskal et de Prim pour un instance de TSP fournie.
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
# ╟─c85637a0-955f-11ef-1fa3-331ecdf30dde
# ╟─9cdc3542-bf7d-4214-b4f8-ff58eb10f1b7
# ╟─553bc20a-931c-4ae3-8793-d438b2b62e49
# ╟─f4356908-80a8-4db2-bec2-33e8f43f4fea
# ╟─0f0f8abb-36f5-4b99-bbab-971e31a8fd80
# ╟─ab5cb352-4cfb-4fa7-b58a-e689d46cbdda
# ╟─7f9ebe74-574a-410b-959f-f34ebc4dc04c
# ╟─58e87236-ff58-4b87-8e8d-c78cd964b4de
# ╟─5c2d39fb-4927-43a2-92e1-a487ce3db296
# ╟─d80a0141-fa83-4591-9488-a8ed85ddf42a
# ╟─00851568-a078-4d8b-b424-f15aa0c50a39
# ╟─62fb07d4-02ad-4ba4-8296-215e69e99d70
# ╟─c63e7407-8b01-472c-aa2d-c7044beff148
# ╟─0872bbca-4bf9-4dbd-8b74-48c080e2b0f7
# ╟─7498eab1-75f9-42ee-8a47-edc08864ffe4
# ╟─31540efc-7ada-4139-92e8-782c91432cee
# ╟─25f460b0-4d82-4bc4-8568-c3b2d20828eb
# ╟─20044732-62cf-47f2-8b11-602e97068583
# ╟─5255fbd3-d606-404d-a5f8-14f093f5dc11
# ╟─e4a17960-23dc-4350-82d7-f3ba35a36edc
# ╟─9765dbe4-3d0e-4088-8d48-b8f7f3558c1d
# ╟─d2e4c0e6-6c12-4828-8027-82893eb2561a
# ╟─f4832809-8bce-400f-81ba-a9bd29b4ed73
# ╟─bbbc3b5b-614c-4633-a188-6b13c0ebd0bc
# ╟─044512fe-c103-43a0-aacc-48aa642db2a6
# ╟─c44cc644-0861-4c5d-bc10-3f81eec681b9
# ╟─96a22b4a-2339-4e10-a094-dbf726c16b13
# ╟─ae2f80da-3fff-46b9-b627-a4d0426071ed
# ╟─c9669e96-19df-43b2-b6d9-8320145717f4
# ╟─2ed59c8a-fb1d-4334-afb6-063688d9219b
# ╟─e7f1431d-23bd-4607-9e26-c06f28b88e50
# ╟─b37f56ff-01e3-4e8f-9811-e1b46e028c47
# ╟─6bd39cce-6899-4c70-a8ec-5cdfa1416feb
# ╟─911b959a-d86c-49ca-a9c0-9a187755fd07
# ╟─458e242d-d27d-4a0d-b77d-98f35bba7278
# ╟─e4cfb9a2-af1e-4e3a-9358-9a12832bc0c5
# ╟─4bab34c5-b69b-4442-b27d-f5e416446934
# ╟─e492b845-0d0b-4110-8706-c2ff8e0fc74e
# ╟─e4c42c07-41aa-4ea3-b6a0-eb131eeb9fee
# ╟─5e2a5f18-da89-49ec-a90e-f7128023c4ab
# ╟─8011f100-2141-4ba7-b5c6-dc17ed4aa7ef
# ╟─c5426a02-687d-4d17-bab9-56000eadcb31
# ╟─5dac4b6e-d3d6-42d0-b29b-7120b52dbe07
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
