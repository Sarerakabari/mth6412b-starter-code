import Base.show
include("graph.jl")


"""Type abstrait dont d'autres types de composantes connexe dériveront."""
abstract type Abstractcomp_conx{T} end

mutable struct comp_conx{T} <: Abstractcomp_conx{T}
  name::String
  Child::Node{T}
  Parent::Node{T}
end

# on présume que tous les composantes d'un graphes dérivant d'Abstractcomp_conx
# posséderont des champs `name` et `child` et `Parent`.

"""Renvoie le nom de la composante connexe."""
name(comp_conx::Abstractcomp_conx) = comp_conx.name

data(comp_conx::Abstractcomp_conx) = comp_conx.parent

function comp_conx(Node::Node{T}) where {T}
  name=Node.name  
  return comp_conx(name,Node,Node)
end

function change_parent!(comp_conx::Abstractcomp_conx, new_parent::Node{T}) where {T}
  comp_conx.parent=new_parent
end



