import Base.show
include("../phase1/graph.jl")


"""Type abstrait d'un composant connexe: noeud enfant pointant vers le noeud parent ."""
abstract type Abstractnode_pointer{T} end

mutable struct node_pointer{T} <: Abstractnode_pointer{T}
  name::String
  child::Node{T}
  parent::Node{T}

end

# on présume que tous les noeuds dérivant d'AbstractNode
# posséderont des champs `name` et `data`.

"""Constructeur pour un composant connexe."""
function node_pointer(Node::Node{T}) where {T}
name=Node.name 
return node_pointer(name,Node,Node)
end
""" Unis les composants connexes composés des 2 noeuds des arête d'un graph """
function unite!(n1::Node{T},n2::Node{T},C::Vector{node_pointer{T}}) where {T}

  link!(find_root(C[findfirst(x->x.name==n1.name,C)],C),find_root(C[findfirst(x->x.name==n2.name,C)],C),C)
  C
end    

""" lie 2 composants connexes dans un ensemble """
function link!(c1::node_pointer{T},c2::node_pointer{T},C::Vector{node_pointer{T}}) where {T}

  C[findfirst(x->x.name==c2.name,C)].parent=c1.child
  C
end

""" Trouve la racine du composant connexe """

function find_root(c::node_pointer{T},C::Vector{node_pointer{T}}) where {T}

  if c.child!=c.parent
     c=find_root(C[findfirst(x->x.name==c.parent.name,C)],C)
  end

  return c
end