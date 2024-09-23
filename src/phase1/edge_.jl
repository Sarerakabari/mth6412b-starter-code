import Base.show
include("node.jl")

"""Type abstrait dont d'autres types d'arret dériveront."""
abstract type AbstractEdge{T,S} end
"""Type représentant les aretes d'un graphe.

Exemple:

a        noeud1 = Node("James", 12)
        noeud2= Node("Kirk",14)
        
        edge=Edge("(noeud1, noeud2) ",12,noeud1,noeud2)

"""
mutable struct Edge{T,S} <: AbstractEdge{T,S}
  name::String
  data::S
  node1::Node{T}
  node2::Node{T}
 
end

# on présume que tous les noeuds dérivant d'AbstractNode
# posséderont des champs `name` et `data`.

"""Renvoie le nom du noeud."""
name(edge::AbstractEdge) = edge.name

"""Renvoie les données contenues dans le noeud."""
data(edge::AbstractEdge) = edge.data

"""Renvoie les données contenues dans le noeud 1."""
node1(edge::AbstractEdge) = edge.node1

"""Renvoie les données contenues dans le noeud 2."""
node2(edge::AbstractEdge) = edge.node2

"""Affiche un arete."""
function show(edge::AbstractEdge)
  println("Edge ", name(edge), " bounds ",node1(edge).name, " and " ,node2(edge).name)
end