
import Base.show
include("node.jl")
include("edge.jl")
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
  name::String
  nodes::Vector{Node{T}}
  edges::Vector{Edge{T,S}}
end

"""Ajoute un noeud au graphe."""
function add_node!(graph::Graph{T,S}, node::Node{T}) where {T,S}
  push!(graph.nodes, node)
  graph
end

"""Ajoute un arrete au graphe."""
function add_edge!(graph::Graph{T,S}, edge::Edge{T,S}) where {T,S}
  push!(graph.edges,edge)
  graph
end

# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.

"""Renvoie le nom du graphe."""
Name(graph::AbstractGraph) = graph.Name

"""Renvoie la liste des noeuds du graphe."""
nodes(graph::AbstractGraph) = graph.nodes

"""Renvoie le nombre de noeuds du graphe."""
nb_nodes(graph::AbstractGraph) = length(graph.Nodes)

"""Renvoie la liste des arêtes du graphe."""
edges(graph::AbstractGraph) = graph.edges

<<<<<<< HEAD
"""Renvoie le nombre de arête du graphe."""
nb_edges(graph::AbstractGraph) = length(graph.Edges)
=======
"""Renvoie le nombre de noeuds du graphe."""
nb_edges(graph::AbstractGraph) = length(graph.edges)

>>>>>>> 419a27d35d94b896650795618e207af9fdb571b2

"""Affiche un graphe"""
function show(graph::Graph)
  println("Graph ", Name(graph), " has ", nb_nodes(graph), " nodes and ", nb_edges(graph) ," Edges") 
  println(" Nodes are ") 
<<<<<<< HEAD

  for Node in Nodes(graph)
    show(Node)
=======
  for node in nodes(graph)
    show(node)
>>>>>>> 419a27d35d94b896650795618e207af9fdb571b2
  end
  println(" Edges are ") 
<<<<<<< HEAD


 for Edge in Edges(graph)
   show(Edge)
=======
  for edge in edges(graph)
    show(edge)
>>>>>>> 419a27d35d94b896650795618e207af9fdb571b2
  end
end
