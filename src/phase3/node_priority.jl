import Base.isless, Base.==
include("../phase1/graph.jl")
"""Type abstrait d'un node_priority."""
abstract type Abstractnode_priority{T} end

"""Type node_priority contentant 4 attributs : son nom (de type String), le noeud en lui-même (de type Node{T}),
son parent (qui est soit de type Node{T}, soit Nothing), et sa priorité (qui est un nombre)."""
mutable struct node_priority{T} <: Abstractnode_priority{T}
name::String
node::Node{T}
parent::Union{Node{T}, Nothing}
priority::Number
end


"""
    node_priority(node::Node{T}) where T

Constructeur du type node_priority. On va initialiser le parent à nothing et la priorité à Inf

# Arguments
- `node::Node{T}`: le noeud sur lequel on se base pour construire l'élément.
"""
function node_priority(node::Node{T}) where T

name=node.name

return node_priority(name,node,nothing,Inf)

end


priority(p::node_priority) = p.priority


"""
    priority!(p::node_priority, priority::Number)

Mise à jour de la priorité d'un élément de type node_priority

# Arguments
- `p::node_priority`: élément de type node_priority dont on va vouloir modifier la priorité
- `priority::Number`: nouvelle valeur de la priorité
"""
function priority!(p::node_priority, priority::Number)
p.priority = max(0, priority)
p
end

"""
    parent!(p::node_priority,parent::Node)

Mise à jour du parent d'un élément de type node_priority

# Arguments
- `p::node_priority`: élément de type node_priority dont on va vouloir modifier le parent
- `parent::Node`: noeud qui sera le nouveau parent de la node_priority.
"""
function parent!(p::node_priority,parent::Node)
p.parent = parent
p
end

"""
    isless(p::node_priority, q::node_priority)

Définition d'une relation d'ordre entre éléments de type node_priority
"""
isless(p::node_priority, q::node_priority) = priority(p) < priority(q)


"""
    ==(p::node_priority, q::node_priority)

Définition d'une relation d'égalité entre éléments de type node_priority
"""
==(p::node_priority, q::node_priority) = priority(p) == priority(q)
