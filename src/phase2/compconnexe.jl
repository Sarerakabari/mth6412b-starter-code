import Base.show

#include("graph.jl")


#"""Type abstrait dont d'autres types de composantes connexe dériveront."""
#abstract type Abstractcomp_conx{T} end

#mutable struct comp_conx{T} <: Abstractcomp_conx{T}
#  name::String
#  Child::Node{T}
#  Parent::Node{T}
#end

# on présume que tous les composantes d'un graphes dérivant d'Abstractcomp_conx
# posséderont des champs `name` et `child` et `Parent`.

#"""Renvoie le nom de la composante connexe."""
#name(comp_conx::Abstractcomp_conx) = comp_conx.name

#data(comp_conx::Abstractcomp_conx) = comp_conx.parent

#function comp_conx(Node::Node{T}) where {T}
#  name=Node.name  
#  return comp_conx(name,Node,Node)
#end

#function change_parent!(comp_conx::Abstractcomp_conx, new_parent::Node{T}) where {T}
#  comp_conx.parent=new_parent
#end

"""Implémentation d'une structure de données pour les composantes connexes 
    comme des graphes."""
mutable struct ComposanteConnexe{T,S} <: AbstractGraph{T,S}
  name::String
  Nodes::Vector{Node{T}}
  Edges::Vector{Edge{T,S}}
end

"""
Fusionne deux composantes connexes en ajoutant tous les noeuds et les arêtes de `comp_conx2` à `comp_conx1` 
et en ajoutant une arête de fusion `edge_fusion`. 
"""
function fusion_of_two_connected_components!(comp_conx1::ComposanteConnexe{T,S},
  comp_conx2::ComposanteConnexe{T,S}, edge_fusion::Edge{T,S}) where {T,S}

  # Ajout des noeuds de comp_conx2 à comp_conx1
  for node in comp_conx2.nodes
    add_node!(comp_conx1, node)
  end

  # Ajout des arêtes de comp_conx2 à comp_conx1
  for edge in comp_conx2.edges
    add_edge!(comp_conx1, edge)
  end

  # Ajout de l'arête de fusion
  add_edge!(comp_conx1, edge_fusion)

  return comp_conx1
end




