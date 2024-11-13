export Edge
export name,data,node1,node2,show

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

# on présume que tous les noeuds dérivant d'AbstractNode
# posséderont des champs `name` et `data`.

"""Renvoie le nom de l'arêtes."""
name(edge::AbstractEdge) = edge.name

"""Renvoie les données contenues dans l'arête."""
data(edge::AbstractEdge) = edge.data

"""Renvoie le noeud1 de l'arêtes."""
node1(edge::AbstractEdge) = edge.node1

"""Renvoie le noeud2 de l'arêtes."""
node2(edge::AbstractEdge) = edge.node2

"""Affiche un arete."""
function show(edge::AbstractEdge)
  println("Edge ", name(edge), " bounds ",node1(edge).name, " and " ,node2(edge).name,",his weight is ",data(edge))
end
