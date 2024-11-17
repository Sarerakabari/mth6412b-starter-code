export finetuning_start





function calculate_cost!(graph::Graph{T,S},filename::String) where {T,S}
    G = create_graph(filename)
    cost = 0
    for edge in graph.Edges
        edge_index=findfirst(x -> (x.node1.name == edge.node1.name && x.node2.name == edge.node2.name) || (x.node1.name == edge.node2.name && x.node2.name == edge.node1.name), G.Edges)
        edge.data = G.Edges[edge_index].data
        cost = cost + edge.data
    end
    cost
end

""" 
La fonction finetuning_start permet de déterminer le point de départ optimal 
pour trouver la tournée minimale, tout en gardant les autres paramètres fixes.
"""
function finetuning_start(solver, filename::String)
"""
args: 
solver    : solveur pour trouver la tournée qui est soit
         RSL soit HK avec le sous-solveurs de HK est prim
filename     : Pour création du graphe

returns:
Tournée   : La tournée minimale 
cost      : Le cout de la tournée
nn        : Le meilleur point de départ

""" 



    # solver change le graphe en entrée, pour cela nous créeons le graphe à chacque fois
    G = create_graph(filename)
    n = length(G.Nodes)
    nn = G.Nodes[1]
    Tournée, cost = solver(G,1) 
    cost = calculate_cost!(Tournée,filename)
    for idx in 2:n
        G = create_graph(filename)
        Tournée_old, cost_old = solver(G,idx)
        cost_old = calculate_cost!(Tournée_old,filename)
        if cost_old < cost
            cost = cost_old
            Tournée = Tournée_old
            nn = G.Nodes[idx]
        end
    end
    return Tournée, cost , nn
end