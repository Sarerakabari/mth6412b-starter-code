include("../phase1/graph.jl")
"""Type abstrait d'un weighted_node."""
abstract type Abstractweighted_node{T} end

"""Type weighted_node contentant 4 attributs : son nom (de type String), le noeud en lui-même (de type Node{T})
 et son poids (qui est un nombre)."""
mutable struct weighted_node{T} <: Abstractweighted_node{T}
name::String
node::Node{T}
priority::Number
end


"""
    weighted_node(node::Node{T}) where T

Constructeur du type node_priority. On va initialiser  le poids à zero

# Arguments
- `node::Node{T}`: le noeud sur lequel on se base pour construire l'élément.
"""
function weighted_node(node::Node{T}) where T

name=node.name

return weighted_node(name,node,0)

end


priority(p::weighted_node) = p.priority


"""
    priority!(p::node_priority, priority::Number)

Mise à jour du poids d'un élément de type weighted_node

# Arguments
- `p::weighted_node`: élément de type node_priority dont on va vouloir modifier la priorité
- `priority::Number`: nouvelle valeur de la priorité
"""
function priority!(p::weighted_node, priority::Number)
p.priority =priority
p
end




