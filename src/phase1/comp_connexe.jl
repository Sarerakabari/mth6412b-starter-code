import Base.show
include("graph.jl")


"""Type abstrait dont d'autres types d'arret dériveront."""
abstract type Abstractcomp_conx{T} end

mutable struct comp_conx{T} <: Abstractcomp_conx{T}
  name::String
  Child::Node{T}
  Parent::Node{T}
end

# on présume que tous les noeuds dérivant d'AbstractNode
# posséderont des champs `name` et `data`.

"""Renvoie le nom du noeud."""
name(comp_conx::Abstractcomp_conx) = comp_conx.name

"""Renvoie les données contenues dans le noeud."""
data(comp_conx::Abstractcomp_conx) = comp_conx.parent

function comp_conx(Node::Node{T}) where {T}
name=Node.name  
return comp_conx(name,Node,Node)
end

function change_parent!(comp_conx::Abstractcomp_conx, new_parent::Node{T}) where {T}
    comp_conx.parent=new_parent
end



