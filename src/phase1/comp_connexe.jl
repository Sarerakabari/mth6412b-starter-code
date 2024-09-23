import Base.show
include("graph.jl")


"""Type abstrait dont d'autres types d'arret dériveront."""
abstract type Abstractcomp_conx{T} end
"""Type représentant les aretes d'un graphe.

Exemple:

a        noeud1 = Node("James", 12)
        noeud2= Node("Kirk",14)
        
        edge=Edge("(noeud1, noeud2) ",12,noeud1,noeud2)

"""
mutable struct comp_conx{T,S} <: Abstractcomp_conx{T}
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

function change_parent!(comp_conx::Abstractcomp_conx, new_parent::Node{T}) where {T}
    comp_conx.parent=new_paren
  end



