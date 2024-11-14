export finetuning_start

""" """
function finetuning_start(solver, graph::Graph{T,S}, steepsize=nothing, stoping=nothing)  where {T,S}
"""
args: 
solver    : solveur pour trouver la tournée qui est soit
         RSL soit HK avec le sous-solveurs de HK est prim
graph     : Un graphe de type Abstractgraph
steepsize : Paramètre pour le pas de la descent pour le solveur HK, 
            on utilise cet argument si solver est HK
returns:

""" 
    list = []
    Tournée, cost = solver(graph,graph.Nodes[1])
    nn = graph.Nodes[1]
    for k in 2:length(graph.Nodes)
        Tournée_old, cost_old = solver(graph,graph.Nodes[k])
        if cost_old < cost
            cost = cost_old
            Tournée = Tournée_old
            nn = graph.Nodes[k]
        end
    end
    return Tournée, cost , nn
end