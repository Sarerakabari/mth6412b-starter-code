import Base.isless, Base.==
include("../phase1/graph.jl")

abstract type Abstractnode_priority{T} end


mutable struct node_priority{T} <: Abstractnode_priority{T}
name::String
node::Node{T}
parent::Union{Node{T}, Nothing}
priority::Number
end



function node_priority(node::Node{T}) where T

name=node.name

return node_priority(name,node,nothing,Inf)

end


priority(p::node_priority) = p.priority



function priority!(p::node_priority, priority::Number)
p.priority = max(0, priority)
p
end


function parent!(p::node_priority,parent::Node)
p.parent = parent
p
end

isless(p::node_priority, q::node_priority) = priority(p) < priority(q)

==(p::node_priority, q::node_priority) = priority(p) == priority(q)