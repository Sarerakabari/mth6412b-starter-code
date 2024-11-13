import Base.popfirst!,Base.push!,Base.isempty,Base.length

export node_Queue
export push!,popfirst!,is_empty,length,show

"""Type abstrait de Queue """
abstract type AbstractQueue{T} end
"""Type représentant une file de priorité avec des éléments node_priority de type T."""
mutable struct node_Queue{T} <: AbstractQueue{T}
items::Vector{node_priority{T}}
end

node_Queue{T}() where T = node_Queue(T[])
"""
    push!(q::AbstractQueue{T}, item::node_priority{T}) where T

Ajoute l'élément item à la file de priorité q

# Arguments
- `q::AbstractQueue{T}`: file de priorité considérée
- `item::node_priority{T}`: élément à ajouter à la file
"""
function push!(q::AbstractQueue{T}, item::node_priority{T}) where T
push!(q.items, item)
q
end

"""
    popfirst!(q::AbstractQueue{T}) where T

Retire et renvoie l'élément de plus basse priorité

# Arguments
- `q::AbstractQueue{T}`: file de priorité considérée
"""
function popfirst!(q::AbstractQueue{T}) where T

idx = argmin(q.items)

first=q.items[idx]

deleteat!(q.items, idx)

first

end

"""Indique si la file est vide."""
is_empty(q::AbstractQueue) = length(q.items) == 0
"""Donne le nombre d'éléments sur la file."""
length(q::AbstractQueue) = length(q.items)
"""
    show(q::AbstractQueue{T}) where T

Affiche une file de priorité.

# Arguments
- `q::AbstractQueue{T}`: file de priorité considérée
"""
function show(q::AbstractQueue{T}) where T
   for item in q.items

    show(item.node)
    println(item.priority)


   end
end
