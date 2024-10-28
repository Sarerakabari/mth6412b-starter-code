import Base.show
include("../phase1/graph.jl")


"""Type abstrait d'un composant connexe: noeud enfant pointant vers le noeud parent ."""
abstract type Abstractnode_pointer{T} end

"""Type node_pointer (composant connexe) contenant 4 attributs : son nom (de type String), le noeud enfant (de type Node{T})
qui est le noeud à proprement parler, le noeud parent (de type Node{T}), et son rang (de type Int64)."""
mutable struct node_pointer{T} <: Abstractnode_pointer{T}
  name::String
  child::Node{T}
  parent::Node{T}
  rank::Int64
end

"""Constructeur d'une composante connexe à partir d'un noeud"""
function node_pointer(Node::Node{T}) where {T}
  name=Node.name 
  return node_pointer(name,Node,Node,0)
end

""" find_root sert à trouver la racine dans un ensemble de composantes connexes. 
Une racine est déinie par une composante connexe dont l'enfant est lui-même le parent. """

function find_root(c::node_pointer{T},C::Vector{node_pointer{T}}) where {T}

  if c.child!=c.parent
     c=find_root(C[findfirst(x->x.name==c.parent.name,C)],C)
  end

  return c
end


""" Liaison de deux composantes connexes dans un ensemble de composantes connexes en utilisant
l'heuristique d'union par le rang. """
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



""" Liaison en utilisant l'heuristique de compression de chemins."""
function unite!(n1::Node{T},n2::Node{T},C::Vector{node_pointer{T}}) where {T}

  link!(find_root(C[findfirst(x->x.name==n1.name,C)],C),find_root(C[findfirst(x->x.name==n2.name,C)],C),C)
  C
end    

