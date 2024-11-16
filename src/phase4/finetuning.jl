export finetuning_start



""" 
La fonction finetuning_start permet de déterminer le point de départ optimal 
pour trouver la tournée minimale, tout en gardant les autres paramètres fixes.
"""
function finetuning_start(solver, graph::Graph{T,S}, steepsize=nothing, stoping=nothing)  where {T,S}
"""
args: 
solver    : solveur pour trouver la tournée qui est soit
         RSL soit HK avec le sous-solveurs de HK est prim
graph     : Un graphe de type Abstractgraph
steepsize : Paramètre pour le pas de la descent pour le solveur HK, 
            on utilise cet argument si solver est HK
returns:
Tournée   : La tournée minimale 
cost      : Le cout de la tournée
nn        : Le meilleur point de départ

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