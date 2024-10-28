include("node_priority.jl")
import Base.popfirst!,Base.push!,Base.isempty,Base.length
abstract type AbstractQueue{T} end
"""Type représentant une file avec des éléments de type T."""
mutable struct node_Queue{T} <: AbstractQueue{T}
items::Vector{node_priority{T}}
end

node_Queue{T}() where T = node_Queue(T[])

"""Ajoute `item` à la fin de la file `s`."""
function push!(q::AbstractQueue{T}, item::node_priority{T}) where T
push!(q.items, item)
q
end

"""Retire et renvoie l'élément ayant la plus haute priorité."""
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
"""Affiche une file."""
function show(q::AbstractQueue{T}) where T
   for item in q.items

    show(item.node)
    println(item.priority)


   end
end