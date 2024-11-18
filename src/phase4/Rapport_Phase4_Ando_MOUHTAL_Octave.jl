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
### Mini rapport: Phase 4 du projet
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
md"""[https://github.com/Sarerakabari/mth6412b-starter-code/tree/phase4/src/phase4](https://github.com/Sarerakabari/mth6412b-starter-code/tree/phase4/src/phase4)"""

# ╔═╡ 063e8297-bc61-4bde-85d0-8f144185c6d3
md""" Le lecteur peut fork le projet et lancer le fichier main.jl pour retrouver les résultats ci-dessus"""

# ╔═╡ b4aac71c-7ec4-41b6-8d85-02b8c3dc742d
md"""
##### 1. Implémentation de l'algorithme rsl
"""

# ╔═╡ d970b71a-1f3f-46c8-93ce-df35125d369a
md"""
La fonction `parcours_preordre!` met à jour le vecteur `ordre` pour qu'il contienne la liste des nœuds du graphe formant un arbre de recouvrement minimal, selon l'ordre de visite utilisé par l'algorithme de Prim, à partir d'un nœud initial `start`.
"""

# ╔═╡ 8c4e3107-ac56-4e2a-a889-b199e7eb8547
md"""
```julia
function parcours_preordre!(graph::Graph{T,S}, start::Node{T},visited::Dict{Node{T}, Bool},ordre::Vector{Node{T}}) where {T,S}
    push!(ordre,start)
    visited[start] = true
    #La boucle for parcour les noeuds voisin comme dans l'algorithme Prim
    for edge_index in findall(x-> x.node1 == start || x.node2 == start, graph.Edges)
        edge=graph.Edges[edge_index]
        voisin = edge.node1 == start ? edge.node2 : edge.node1
        if !visited[voisin]
            parcours_preordre!(graph,voisin,visited,ordre)
        end
    end
end
```
"""

# ╔═╡ 6f34b908-e413-4317-a27d-6c6a8df213be
md"""La fonction `rsl` retourne une tournée approximativement minimale ainsi que le cout de cette dernière. Cette fonction procède en deux phases :  
1. Elle détermine un arbre de recouvrement minimal dans `graph`.  
2. Ensuite, elle effectue un parcours selon l'ordre de visite des nœuds dans l'arbre de recouvrement minimal construit par l'algorithme de Prim. À partir de cet ordre, elle génère la tournée.

"""

# ╔═╡ 16339626-8605-4ac6-985c-49e11a718af6
md"""
```julia
function rsl(graph::Graph{T,S},idx) where {T,S}
    
    # Recherche de l'arbre de recouvrement minimale
    arbre, weight=prim(graph,graph.Nodes[idx])

    # Parcours dans l'ordre de visite de l'arbre
    visited=Dict(node => false for node in graph.Nodes)
    ordre=Node{T}[]

    parcours_preordre!(arbre,graph.Nodes[idx],visited,ordre)
    
    # Pour boucler la tournée
    push!(ordre,graph.Nodes[idx])

    # Création de la tournée à partir du vecteur ordre
    tournée = Edge{T,S}[]
    cout = 0

    for i in 1:length(ordre)-1
        n1, n2 = ordre[i],ordre[i+1]
        edge_index=findfirst(x -> (x.node1 == n1 && x.node2 == n2) || (x.node1 == n2 && x.node2 == n1), graph.Edges)
        edge=graph.Edges[edge_index]
        if edge !== nothing
            push!(tournée,edge)
            cout+=edge.data
        else
            error("Erreur : on n'a pas trouvé d'arête entre $n1 et $n2 dans le graphe.")
        end
    end
    # Suppresion de dernier élément(start), puisqu'il est redondant
    pop!(ordre)
    Tournée=Graph("Tournée",ordre,tournée)
    return Tournée, cout
end

```
"""

# ╔═╡ fd8454ba-cee5-4f25-86c1-3f097d09906b
md"""
##### 2. Test unitaires dans le cas rsl
"""

# ╔═╡ 4f23d7d2-1718-4b16-976e-8a24660bbd4e
md"""
```
Les tests unitaires dans le cas de rsl sont présents dans le fichier test_rsl.jl. Nous avons implémenter les tests unitaires ci-dessous avec un exemple simple.
```
"""


# ╔═╡ c5a3aabd-1786-48fc-ba37-4fac672248cb
md"""
```julia
include("../phase1/main.jl")
include("../phase3/node_priority.jl")
include("../phase3/queue.jl")
include("../phase3/prim.jl")
include("rsl.jl")
include("finetuning.jl")
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
```
"""

# ╔═╡ d50e2d9f-7839-4648-9731-b95d19043c75
md"""
###### Résulat
"""

# ╔═╡ 127a54e2-838f-4ee8-b7db-cfbceec47e48
md"""
```julia
Test Passed
```
"""

# ╔═╡ 9d8d7cfe-a427-4d19-8bed-de8a921dafe2
md"""
##### 3. Ajustement fin des paramètres de la fonction `rsl`.
"""

# ╔═╡ b63df5ba-fe18-4b68-b1b8-cc8aa46f7998
md"""La fonction `rsl` dépend du point de départ. La fonction `finetuning_start_rsl`  ajuste le noeud de départ de te sorte on construit la tournée la plus optimale. """ 

# ╔═╡ 61b100da-3fd6-42d5-9676-fc3ee2d30ca6
md"""
```julia
function finetuning_start_rsl(filename::String)

    G = create_graph(filename)
    n = length(G.Nodes)
    Id = 1
    Tournée, cost = rsl(G,1) 
    for idx in 2:n
        Tournée_old, cost_old = rsl(G,idx)
        if cost_old < cost
            cost = cost_old
            Tournée = Tournée_old
            Id = idx
        end
    end
    return Tournée, cost , Id
end
```
"""

# ╔═╡ b55a2239-968f-48df-a867-933efcb4b86e
md"""
##### 4. Résultats""" 

# ╔═╡ 4c326a3e-fc60-4732-b48f-9fb2146dce6e
md"""Premièrement, introduisons la fonction `main` qui agit comme point d'entrée pour exécuter différentes optimisations sur un graphe donné à partir d'un fichier, en fonction du type de réglage `fin finetuning` demandé. La fonction à deux arguments:
1. `filename`     : Le nom du fichier contenant les données du graphe .tsp
2. `finetunning` : Spécifie le type d'optimisation à effectuer. Les options incluent :
- `start_rsl` : Optimisation du point de départ pour l'algorithme rsl.
- `start_hk` : Optimisation du point de départ pour l'algorithme hk!.
- `epsilon_hk` : Optimisation du critère d'arrêt `epsilon` pour l'algorithme hk!.
- `start_epsilon_hk` : Optimisation conjointe du point de départ et du critère d'arrêt pour hk!.

"""

# ╔═╡ ab9964f8-856e-4fe9-bcab-914bd3102388
md""" 
``` julia
function main(filename::String, finetunning::String)

    if finetunning == "start_rsl"
        T, C, ID =  finetuning_start_rsl(filename)
        println("Le coût de la tournée est : ", C)
        println("La tournée est composée par :")
        show(T)
        visualize_graph(T.Nodes,T.Edges)

    elseif finetunning == "start_hk"
        T, C, ID =  finetuning_start_hk(filename, 1e-1)
        println("Le coût de la tournée est", C)
        println("La tournée est composée par:")
        show(T)
        visualize_graph(T.Nodes,T.Edges)
    elseif finetunning == "epsilon_hk"
        T, C, EPS =  finetuning_epsilon_hk(filename,1,list_eps)
        println("Le coût de la tournée est", C)
        println("La tournée est composée par:")
        show(T)
        visualize_graph(T.Nodes,T.Edges)
    else finetunning == "start_epsilon_hk"
        T, C, ID =  finetuning_start_epsilon_hk(filename,list_eps)
        println("Le coût de la tournée est :  ", C)
        println("La tournée est composée par:")
        show(T)
        visualize_graph(T.Nodes,T.Edges)
    end

end
```
"""

# ╔═╡ 1738d0e6-cab3-4e01-a99c-b490579071f5
md""" Code du programme principale : """

# ╔═╡ 3e2249ce-2411-4ba4-bd18-033689e41ae2
md"""
```julia
main("/Users/mouhtal/Desktop/mth6412b-starter-code-5/instances/stsp/bayg29.tsp", "start_rsl")
```
"""

# ╔═╡ 481cf377-6d0b-42c9-bdec-6ea229805ed0
md"""###### Résulat
"""

# ╔═╡ 63f51ecf-1760-4122-80ce-a0bf6a868b5c
md"""
```julia
Le coût de la tournée est : 2014.0
La tournée est composée par :
Graph Tournée has 29 nodes and 29 Edges
 Nodes are 
Node 17, data: [230.0, 590.0]
Node 22, data: [490.0, 500.0]
Node 14, data: [510.0, 700.0]
Node 18, data: [460.0, 860.0]
Node 15, data: [750.0, 900.0]
Node 4, data: [750.0, 1100.0]
Node 10, data: [710.0, 1310.0]
Node 20, data: [590.0, 1390.0]
Node 2, data: [630.0, 1660.0]
Node 21, data: [830.0, 1770.0]
Node 5, data: [750.0, 2030.0]
Node 9, data: [790.0, 2260.0]
Node 6, data: [1030.0, 2070.0]
Node 12, data: [1170.0, 2300.0]
Node 28, data: [1260.0, 1910.0]
Node 1, data: [1150.0, 1760.0]
Node 24, data: [1260.0, 1500.0]
Node 27, data: [1460.0, 1420.0]
Node 8, data: [1490.0, 1630.0]
Node 16, data: [1280.0, 1200.0]
Node 23, data: [1840.0, 1240.0]
Node 26, data: [490.0, 2130.0]
Node 29, data: [360.0, 1980.0]
Node 3, data: [40.0, 2090.0]
Node 13, data: [970.0, 1340.0]
Node 19, data: [1040.0, 950.0]
Node 25, data: [1280.0, 790.0]
Node 7, data: [1650.0, 650.0]
Node 11, data: [840.0, 550.0]
 Edges are 
Edge (17, 22) bounds 17 and 22,his weight is 47.0
Edge (14, 22) bounds 14 and 22,his weight is 36.0
Edge (14, 18) bounds 14 and 18,his weight is 32.0
Edge (15, 18) bounds 15 and 18,his weight is 56.0
Edge (4, 15) bounds 4 and 15,his weight is 34.0
Edge (4, 10) bounds 4 and 10,his weight is 39.0
Edge (10, 20) bounds 10 and 20,his weight is 25.0
Edge (2, 20) bounds 2 and 20,his weight is 49.0
Edge (2, 21) bounds 2 and 21,his weight is 41.0
Edge (5, 21) bounds 5 and 21,his weight is 50.0
Edge (5, 9) bounds 5 and 9,his weight is 42.0
Edge (6, 9) bounds 6 and 9,his weight is 56.0
Edge (6, 12) bounds 6 and 12,his weight is 46.0
Edge (12, 28) bounds 12 and 28,his weight is 71.0
Edge (1, 28) bounds 1 and 28,his weight is 34.0
Edge (1, 24) bounds 1 and 24,his weight is 52.0
Edge (24, 27) bounds 24 and 27,his weight is 38.0
Edge (8, 27) bounds 8 and 27,his weight is 39.0
Edge (8, 16) bounds 8 and 16,his weight is 84.0
Edge (16, 23) bounds 16 and 23,his weight is 98.0
Edge (23, 26) bounds 23 and 26,his weight is 286.0
Edge (26, 29) bounds 26 and 29,his weight is 36.0
Edge (3, 29) bounds 3 and 29,his weight is 60.0
Edge (3, 13) bounds 3 and 13,his weight is 215.0
Edge (13, 19) bounds 13 and 19,his weight is 71.0
Edge (19, 25) bounds 19 and 25,his weight is 52.0
Edge (7, 25) bounds 7 and 25,his weight is 72.0
Edge (7, 11) bounds 7 and 11,his weight is 147.0
Edge (11, 17) bounds 11 and 17,his weight is 106.0
```
"""

# ╔═╡ 7a309c85-33b9-4ce1-85de-536cf26eddf9
md"""Le coût de la tournée est de 2014, ce qui est inférieur au double du coût de la tournée minimale réelle, qui est de 1610.
"""

# ╔═╡ 56190668-c0d7-4fd8-8159-2389852c4bfd
md"""
##### 5. Implémentation de l'algorithme hk
"""

# ╔═╡ c450bddb-9cf8-46a5-8d68-f153872cf29a
md"""
D'abord, présentons des structures de données et des fonctions qui vont nous servir pour l'implémentation de l'algorithme hk.
"""

# ╔═╡ c9273814-333e-46a9-b57f-4ace39d5189c
md"""
1. mutable struct weighted_node
   Représente un nœud pondéré avec :
   - Un nom (name).
   - Un nœud associé (node).
   - Une priorité ou un poids (priority).

"""

# ╔═╡ b15a92ef-c7d1-409c-8d2d-b011ed005de5
md""" 
```julia
mutable struct weighted_node{T} <: Abstractweighted_node{T}
    name::String
    node::Node{T}
    priority::Number
end
```
"""

# ╔═╡ c7ad79b3-5ac5-496a-a943-872340fe360f
md"""2. `weighted_node`
   Constructeur pour un objet `weighted_node`. Initialise la priorité d’un nœud à 0.

"""

# ╔═╡ 1bbf53cc-bb82-43ef-9f48-fbb8ad253b55
md"""
```julia
function weighted_node(node::Node{T}) where T

    name=node.name

    return weighted_node(name,node,0)

end
```
"""

# ╔═╡ ea296f84-65b8-47c7-8bcf-c5f39055711a
md"""

3. `priority(p::weighted_node)`:
   Retourne la priorité (ou poids) actuelle d’un nœud pondéré.
"""

# ╔═╡ 1ad3c3ef-7407-473b-a1fc-92e6ac118b63
md"""
```julia
priority(p::weighted_node) = p.priority
```
"""


# ╔═╡ d38a7590-50d9-4730-99f8-10db3be53d13
md"""
4. `priority!(p::weighted_node, priority::Number)`:
   Met à jour la priorité d’un nœud pondéré avec une nouvelle valeur.
"""

# ╔═╡ aff84e04-709b-46e6-bb0e-7ceafb5f8799
md"""
```julia
function priority!(p::weighted_node, priority::Number)
    p.priority =priority
    p
end
```
"""

# ╔═╡ be38727a-edf3-4272-a0c7-5105cd15abbf
md"""5. `weigth_update!(graph::Graph{T,S}, pi_k::Vector{weighted_node{T}})`:
   Met à jour les poids des arêtes dans un graphe en ajoutant les priorités des deux nœuds connectés par chaque arête.
"""

# ╔═╡ 1384e8db-3032-467b-a779-01f48ac66ed6
md"""
```julia
function weigth_update!(graph::Graph{T,S},pi_k::Vector{weighted_node{T}})where {T,S}

    for edge in graph.Edges
        edge.data= edge.data + pi_k[findfirst(x->x.node==edge.node1,pi_k)].priority+pi_k[findfirst(x->x.node==edge.node2,pi_k)].priority
    end
end
```
"""

# ╔═╡ 201f6e55-daf7-4fce-aef5-fb00ad48770d
md"""
6. `one_tree(graph::Graph{T,S}, idx::Int64)`:
   Construit un 1-arbre à partir d’un graphe en :
   - Excluant un nœud donné.
   - Appliquant l’algorithme de Prim sur le sous-graphe résultant.
   - Ajoutant les deux arêtes les plus courtes connectant le nœud exclu.
"""

# ╔═╡ 77714937-68a7-4a05-9f35-2eb508069506
md"""
```julia
function one_tree(graph::Graph{T,S},idx::Int64)where {T,S}
    #noeud selectionné pour le 1-arbre
    n=graph.Nodes[idx]
    # creation du graphe sans le noeud
    sub_graph_nodes =[graph.Nodes[1:idx-1];graph.Nodes[idx+1:end]]
    sub_graph_edges=graph.Edges
    A=Vector{Edge{T,S}}()
    B=Vector{Edge{T,S}}()
    #retrair des arêtes contentant le noeud
    for edge in sub_graph_edges
        if (edge.node1!=n) & (edge.node2!=n) 
            push!(A,edge)
        else
            push!(B,edge) 
        end
    end
    #sous graphe
    s_g=Graph("k_n",sub_graph_nodes,A)
    #prim sur le sous graphe
    k_n,W=prim(s_g,graph.Nodes[idx])
    # creation du  1-arbre
    sort!(B, by=e -> e.data)
    push!(k_n.Nodes,n)
    if B[1].node1!=B[2].node2
        push!(k_n.Edges,B[1])
        push!(k_n.Edges,B[2])
        W=W+B[1].data+B[2].data
    else
        push!(k_n.Edges,B[1])
        push!(k_n.Edges,B[3])
        W=W+B[1].data+B[3].data
    end
return k_n,W
```
"""

# ╔═╡ 1ee8ce73-1d27-4232-871d-e18e40f2e806
md"""
7. `fix_tree(graph::Graph{T,S}, arbre::Graph{T,S}, start::Node{T})`:
   Corrige un 1-arbre en le transformant en un circuit hamiltonien. Cela inclut :
   - Un parcours en pré-ordre des nœuds.
   - La construction d'une tournée et le calcul de son coût total.
"""

# ╔═╡ 5e7e90e8-1088-4c75-9474-d51a7327e1df
md"""
```julia
function fix_tree(graph::Graph{T,S},arbre::Graph{T,S},start::Node{T}) where {T,S}

    

    visited=Dict(node => false for node in graph.Nodes)
    ordre=Node{T}[]

    parcours_preordre!(arbre,start,visited,ordre)
    # Pour boucler la tournée
    push!(ordre,start)

    tournée = Edge{T,S}[]
    cout = 0

    for i in 1:length(ordre)-1
        n1, n2 = ordre[i],ordre[i+1]
        edge_index=findfirst(x -> (x.node1 == n1 && x.node2 == n2) || (x.node1 == n2 && x.node2 == n1), graph.Edges)
        edge=graph.Edges[edge_index]
        if edge !== nothing
            push!(tournée,edge)
            cout+=edge.data
        else
            error("Erreur : on n'a pas trouvé d'arête entre $n1 et $n2 dans le graphe.")
        end
    end
    # Suppresion de dernier élément(start), puisqu'il est redondant
    pop!(ordre)
    Tournée=Graph("Tournée",ordre,tournée)
    return Tournée, cout
end
```
"""

# ╔═╡ f4fcf415-bd09-4493-82fd-7d9c054dbf60
md"""
8. `degrees(graph::Graph{T,S})`:
   Calcule :
   - Les degrés de chaque nœud.
   - Les sous-gradients associés.
   Retourne des structures de données pour les pondérations et sous-gradients.
"""

# ╔═╡ a5d12422-a0d9-4741-963c-a38450c347d7
md"""
```julia
function degrees(graph::Graph{T,S})where {T,S}
    # initialisation degrees des noeud
    d=Vector{weighted_node{T}}()
    p=[]
    # initialisation sous-gradient
    v_k=Vector{weighted_node{T}}()
    v=[]
    for node in graph.Nodes
        #initialisation de poids d'un noeud
        push!(d,weighted_node(node))
        push!(v_k,weighted_node(node))
        # voisins connecté à ce nouvelle
        neighboor_nodes=findall(x->x.node1==node||x.node2==node,graph.Edges)
        j=0
        # vecteur de noeud contentant les voisins
        A=Vector{Node{T}}()
        # compatge des voisins
        for i in neighboor_nodes
            if graph.Edges[i].node1==node
                n=graph.Edges[i].node2
            else
                n=graph.Edges[i].node1
            end
            if !(n in A)
                push!(A,n)
                j+=1
            end  
        end
        # mise à jour du poids
        priority!(d[end],float.(j))
        # mise à jour du sous gradient
        priority!(v_k[end],float.(j-2))
        # mise à jour du vecteur degrées
        push!(p,j)
        # mise à jour du vecteur sous gradient
        push!(v,(j-2))


    end
    return d,v_k,p,v
   
end
```
"""

# ╔═╡ 1af51dff-d647-41a6-aa32-a84a35e3b054
md"""9. `hk!(graph::Graph{T,S}, idx, epsilon)`:
   Implémente la métode itérative hk pour trouver la tournée optimale :
   - Générant des 1-arbres (via `one_tree`).
   - Corrigeant les poids du graphe (via `weigth_update!`).
   - Ajustant les sous-gradients et les priorités des nœuds.
   - Convertissant le 1-arbre final en un circuit (via `fix_tree`).
   - Arrêtant les itérations lorsque la précision `epsilon` est atteinte.
"""

# ╔═╡ ce87222b-1a28-4696-a784-7c72d5274a19
md"""
```julia
function hk!(graph::Graph{T,S},idx,epsilon)where {T,S}
    #initialisation des itérations
    k=0
    k_2=0
    # cout du circuit
    W=-Inf
    #initialisation du  1 arbre
    T_k=graph
    # initialisation de la correction des poids
    pi_k=0
    # initialisation de la periode
    periode=floor(Int,(length(graph.Nodes)/2))
    # initialisation du sous gradient
    P_k=Vector{weighted_node{T}}()
    for node in graph.Nodes
    push!(P_k,weighted_node(node))
    end
    n=length(graph.Nodes)
    # initialisation du vecteur sous gradient
    v_k=ones(n)
    # pas initiale 
    tk=1

while tk > epsilon # condition d'arrêt 
    # création du 1 arbre
    T_k,L=one_tree(graph,idx)

    # correction du cout
    W_k=L-2*pi_k
    W=max(W,W_k)

    # calcul des degrées et du sous gradient
    D,V,d_k,v_k=degrees(T_k)

    #mise à jour du pas et de la période 
    if k==periode
        periode=floor(Int,(periode/2))+1
        tk=tk/2
        k=0    

    end
    # mise à jour de la correction sur le poids
    pi_k=pi_k+tk*sum(v_k)
    # mise à jour des poids
    for p_k in P_k
        p_k.priority=p_k.priority+tk*V[findfirst(x->x.node==p_k.node,V)].priority 
    end
    weigth_update!(graph,P_k)
    # mise à jour des itérations
    k=k+1
    k_2+=1
end
# correction de l'arbre pour avoir un circuit 
T_k,W=fix_tree(graph,T_k,graph.Nodes[idx])
#W=W-2*pi_k

return T_k,W
end

```
"""

# ╔═╡ 551fad28-88c3-4bbf-8caf-43b03da0af4d
md"""
##### 6. Test unitaires dans le cas hk
"""

# ╔═╡ a35c7014-558e-459b-ace8-d2fce92f75cd


# ╔═╡ d98814aa-3e8d-4ff0-9331-597834bda3e4
md"""
##### 7. Ajustement fin des paramètres de la fonction `hk`
"""

# ╔═╡ 9407504e-e6c8-4c67-a2ae-be38660c261f
md"""La fonction `hk!` dépend du point de départ et du critère d'arret, c'est pour cela on va introduire les trois fonctions suvantes :""" 

# ╔═╡ 3bc3f0ca-79f1-4ea1-857e-f41af555d46d
md"""
1. La fonction intérmédiaire `calculate_cost!` qui calcule le coût réel d'une tournée donné dans un graphe en se basant sur les poids originaux des arêtes.
"""

# ╔═╡ 52ad7565-310e-4878-9026-e145b645ce53
md"""
```julia
function calculate_cost!(graph::Graph{T,S},filename::String) where {T,S}
    G = create_graph(filename)
    cost = 0
    for edge in graph.Edges
        edge_index=findfirst(x -> (x.node1.name == edge.node1.name && x.node2.name == edge.node2.name) || (x.node1.name == edge.node2.name && x.node2.name == edge.node1.name), G.Edges)
        edge.data = G.Edges[edge_index].data
        cost = cost + edge.data
    end
    cost
end
```
"""

# ╔═╡ d6b2309b-6226-4615-81c9-ddb2ff0f91e6
md"""
2. `finetuning_start_hk` : Détermine le meilleur nœud de départ pour l'algorithme `hk!` en fixant un critère d'arrêt donné.
"""

# ╔═╡ 8c10d4ae-274c-4002-b0d7-b24687d02ea1
md"""
```julia
function finetuning_start_hk(filename::String, epsilon) 



    # hk! change le graphe en entrée, 
    # pour cela nous créeons le graphe à chacque fois
    G = create_graph(filename)
    n = length(G.Nodes)
    Id = 1
    Tournée, cost = hk!(G,1,epsilon) 
    cost = calculate_cost!(Tournée,filename)
    for idx in 2:n
        G = create_graph(filename)
        Tournée_old, cost_old = hk!(G,idx,epsilon)
        cost_old = calculate_cost!(Tournée_old,filename)
        if cost_old < cost
            cost = cost_old
            Tournée = Tournée_old
            Id = idx
        end
    end
    return Tournée, cost , Id
end
```
"""

# ╔═╡ 56855b17-968c-4b59-8458-741075577a72
md"""
3. `finetuning_epsilon_hk` : Détermine le meilleur critère d'arrêt `epsilon` parmi `list_epsilon` pour l'algorithme `hk!`, en fixant le nœud de départ dont l'indice est `idx`.
"""

# ╔═╡ 366584af-f2ba-4773-a095-44fb6f90ee49
md"""
```julia
function finetuning_epsilon_hk(filename::String, idx, list_epsilon)


    G = create_graph(filename)
    Tournée, cost = hk!(G,idx,list_epsilon[1])
    cost = calculate_cost!(Tournée,filename)
    eps = list_epsilon[1]
    for k in 2:length(list_epsilon) 
        G = create_graph(filename)
        Tournée_old, cost_old = hk!(G,idx,list_epsilon[k])
        cost_old = calculate_cost!(Tournée_old,filename)
        if cost_old < cost
            cost = cost_old
            Tournée = Tournée_old
            eps = list_epsilon[k]
        end
    end
    return Tournée, cost , eps
end
```
"""

# ╔═╡ bf7647d9-a946-4271-b80b-6672a1a89778
md"""
4. `finetuning_start_epsilon_hk` : Explore tous les nœuds de départ et tous les critères d'arrêt pour déterminer la meilleure combinaison pour l'algorithme `hk!`.
"""

# ╔═╡ 5adfea69-3dae-4744-9d59-491ae1ce8db5
md"""
```julia
function finetuning_start_epsilon_hk(filename::String, list_epsilon)


    G = create_graph(filename)
    n = length(G.Nodes)
    Tournée, cost = hk!(G,1,list_epsilon[1])
    cost = calculate_cost!(Tournée,filename)
    eps = list_epsilon[1]
    Id = 1
    for k in 1:length(list_epsilon) 
        for idx in 1:n
            G = create_graph(filename)
            Tournée_old, cost_old = hk!(G,idx,list_epsilon[k])
            cost_old = calculate_cost!(Tournée_old,filename)
            if cost_old < cost
                cost = cost_old
                Tournée = Tournée_old
                eps = list_epsilon[k]
                Id  = idx 
            end
        end
    end
    return Tournée, cost , eps, Id
end
```
"""

# ╔═╡ 279b74b5-8d3f-4676-a1c4-a89f84e2830c
md"""
##### 8. Résultats""" 

# ╔═╡ 488aacc1-a3fb-4960-8014-830736925ee8
md"""Pour afficher les résultats, nous allons utiliser la fonction `main`, déjà introduite, pour afficher les résultats. Nous allons utiliser trois fichiers `.tsp` pour tester les trois fonctions d'ajustement.
""" 

# ╔═╡ 70a7948c-95c2-4bac-9f25-1f3411e4ed9a
md"""
```julia
main("/Users/mouhtal/Desktop/mth6412b-starter-code-5/instances/stsp/bayg29.tsp", "start_rsl")
```
"""

# ╔═╡ 5132072b-15e4-47a1-885a-82fdbc41c740
md"""
```julia
main("/Users/mouhtal/Desktop/mth6412b-starter-code-5/instances/stsp/bayg29.tsp", "start_rsl")
```
"""

# ╔═╡ 8c234e56-24fb-40e7-8a75-7d90be1a9f77
md"""
```julia
main("/Users/mouhtal/Desktop/mth6412b-starter-code-5/instances/stsp/bayg29.tsp", "start_rsl")
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
# ╟─063e8297-bc61-4bde-85d0-8f144185c6d3
# ╟─b4aac71c-7ec4-41b6-8d85-02b8c3dc742d
# ╟─d970b71a-1f3f-46c8-93ce-df35125d369a
# ╟─8c4e3107-ac56-4e2a-a889-b199e7eb8547
# ╟─6f34b908-e413-4317-a27d-6c6a8df213be
# ╟─16339626-8605-4ac6-985c-49e11a718af6
# ╟─fd8454ba-cee5-4f25-86c1-3f097d09906b
# ╟─4f23d7d2-1718-4b16-976e-8a24660bbd4e
# ╟─c5a3aabd-1786-48fc-ba37-4fac672248cb
# ╟─d50e2d9f-7839-4648-9731-b95d19043c75
# ╟─127a54e2-838f-4ee8-b7db-cfbceec47e48
# ╠═9d8d7cfe-a427-4d19-8bed-de8a921dafe2
# ╟─b63df5ba-fe18-4b68-b1b8-cc8aa46f7998
# ╟─61b100da-3fd6-42d5-9676-fc3ee2d30ca6
# ╟─b55a2239-968f-48df-a867-933efcb4b86e
# ╟─4c326a3e-fc60-4732-b48f-9fb2146dce6e
# ╟─ab9964f8-856e-4fe9-bcab-914bd3102388
# ╟─1738d0e6-cab3-4e01-a99c-b490579071f5
# ╟─3e2249ce-2411-4ba4-bd18-033689e41ae2
# ╟─481cf377-6d0b-42c9-bdec-6ea229805ed0
# ╟─63f51ecf-1760-4122-80ce-a0bf6a868b5c
# ╟─7a309c85-33b9-4ce1-85de-536cf26eddf9
# ╟─56190668-c0d7-4fd8-8159-2389852c4bfd
# ╟─c450bddb-9cf8-46a5-8d68-f153872cf29a
# ╟─c9273814-333e-46a9-b57f-4ace39d5189c
# ╟─b15a92ef-c7d1-409c-8d2d-b011ed005de5
# ╟─c7ad79b3-5ac5-496a-a943-872340fe360f
# ╟─1bbf53cc-bb82-43ef-9f48-fbb8ad253b55
# ╟─ea296f84-65b8-47c7-8bcf-c5f39055711a
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
# ╟─551fad28-88c3-4bbf-8caf-43b03da0af4d
# ╠═a35c7014-558e-459b-ace8-d2fce92f75cd
# ╟─d98814aa-3e8d-4ff0-9331-597834bda3e4
# ╟─9407504e-e6c8-4c67-a2ae-be38660c261f
# ╟─3bc3f0ca-79f1-4ea1-857e-f41af555d46d
# ╟─52ad7565-310e-4878-9026-e145b645ce53
# ╟─d6b2309b-6226-4615-81c9-ddb2ff0f91e6
# ╟─8c10d4ae-274c-4002-b0d7-b24687d02ea1
# ╟─56855b17-968c-4b59-8458-741075577a72
# ╟─366584af-f2ba-4773-a095-44fb6f90ee49
# ╟─bf7647d9-a946-4271-b80b-6672a1a89778
# ╟─5adfea69-3dae-4744-9d59-491ae1ce8db5
# ╟─279b74b5-8d3f-4676-a1c4-a89f84e2830c
# ╠═488aacc1-a3fb-4960-8014-830736925ee8
# ╟─70a7948c-95c2-4bac-9f25-1f3411e4ed9a
# ╟─5132072b-15e4-47a1-885a-82fdbc41c740
# ╟─8c234e56-24fb-40e7-8a75-7d90be1a9f77
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002