export rsl

include("../phase3/prim.jl")

function parcours_preordre!(graph::Graph{T,S}, départ::Node{T},visité::Dict{Node{T}, Bool},ordre::Vector{Node{T}}) where {T,S}
    push!(ordre,départ)
    visité[départ] = true

    for edge_index in findall(x-> x.node1 == départ || x.node2 == départ, graph.Edges)
        edge=graph.Edges[edge_index]
        voisin = edge.node1 == départ ? edge.node2 : edge.node1
        if !visité[voisin]
            parcours_preordre!(graph,voisin,visité,ordre)
        end
    end
end

function rsl(graph::Graph{T,S},départ::Node{T}) where {T,S}

    arbre, weight=prim(graph,départ)

    visité=Dict(node => false for node in graph.Nodes)
    ordre=Node{T}[]

    parcours_preordre!(arbre,départ,visité,ordre)

    push!(ordre,départ)

    tournée = Edge{T,S}[]
    cout = 0

    for i in 1:length(ordre)-1
        n1, n2 = ordre[i],ordre[i+1]
        edge_index=findfirst(x -> (x.node1 == n1 && x.node2 == n2) || (x.node1 == n2 && x.node2 == n1), graph.Edges)
        edge=graph.Edges[edge_index]
        if edge !== nothing
            push!(tournée,edge)
            cout+=edge.data
        else
            error("Erreur : on n'a pas trouvé d'arête entre $n1 et $n2 dans le graphe.")
        end
    end

    return ordre, tournée, cout
end
