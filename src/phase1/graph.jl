import Base.show
include("node.jl")
include("Edge.jl")
"""Type abstrait dont d'autres types de graphes dériveront."""
abstract type AbstractGraph{T,S} end

"""Type representant un graphe comme un ensemble de noeuds.

Exemple :

    n1 = Node("Joe", 3.14)
    n2 = Node("Steve", exp(1))
    n3 = Node("Jill", 4.12)
    G = Graph("Ick", [node1, node2, node3],)

Attention, tous les noeuds doivent avoir des données de même type.
"""
mutable struct Graph{T,S} <: AbstractGraph{T,S}
  Name::String
  Nodes::Vector{Node{T}}
  Edges::Vector{Edge{T,S}}
end

"""Ajoute un noeud au graphe."""
function add_node!(graph::Graph{T,S}, node::Node{T}) where {T,S}
  push!(graph.Nodes, node)
  graph
end

"""Ajoute un arrete au graphe."""
function add_edge!(graph::Graph{T,S}, edge::Edge{T,S}) where {T,S}
  push!(graph.Edges,edge)
  graph
end

# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.

"""Renvoie le nom du graphe."""
name(graph::AbstractGraph) = graph.name

"""Renvoie la liste des noeuds du graphe."""
Nodes(graph::AbstractGraph) = graph.Nodes

"""Renvoie le nombre de noeuds du graphe."""
nb_nodes(graph::AbstractGraph) = length(graph.nodes)

"""Renvoie la liste des arêtes du graphe."""
Edges(graph::AbstractGraph) = graph.Edges

"""Renvoie le nombre de noeuds du graphe."""
nb_edges(graph::AbstractGraph) = length(graph.Edges)


"""Affiche un graphe"""
function show(graph::Graph)
  println("Graph ", name(graph), " has ", nb_nodes(graph), " nodes and ", nb_edges(graph) ," Edge") 
  println(" Nodes are ") 

  for Node in Nodes(graph)
    show(node)
  end

  println(" Edges are ") 


  for Edge in Edges(graph)
    show(edge)
  end
end
