export finetuning_start_hk, calculate_cost!



""" 
La fonction finetuning_start_rsl permet de déterminer le point de départ optimal 
pour trouver la tournée minimale pour rsl.
"""
function finetuning_start_rsl(filename::String)
"""
args: 
filename     : Pour création du graphe
returns:
Tournée   : La tournée minimale étant donnée le meilleur point de départ
cost      : Le cout de la tournée
Id        : L'indice du meilleur noeud de départ

""" 

    G = create_graph(filename)
    n = length(G.Nodes)
    Id = 1
    Tournée, cost = rsl(G,1) 
    for idx in 2:n
        Tournée_old, cost_old = rsl(G,idx)
        if cost_old < cost
            cost = cost_old
            Tournée = Tournée_old
            Id = idx
        end
    end
    return Tournée, cost , Id
end


"""
Calculate la valeur réel du cout de la tournée retourner par un algorithme, 
spécifiquement pour hk, puisque le cout de l'arbre de l'arbre 1-tree change
au fil des itérations.
"""
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
La fonction finetuning_start_hk permet de déterminer le point de départ optimal 
pour trouver la tournée minimale pour hk!, tout en gardant les autres paramètres fixes.
"""
function finetuning_start_hk(filename::String, epsilon)
"""
args: 
filename     : Pour création du graphe
epsilon  : critère d'arret pour l'algorithme hk
returns:
Tournée   : La tournée minimale étant donnée le meilleur point de départ
cost      : Le cout de la tournée
Id        : L'indice du meilleur noeud de départ

""" 



    # hk! change le graphe en entrée, 
    # pour cela nous créeons le graphe à chacque fois
    G = create_graph(filename)
    n = length(G.Nodes)
    Id = 1
    Tournée, cost = hk!(G,1,epsilon) 
    cost = calculate_cost!(Tournée,filename)
    for idx in 2:n
        G = create_graph(filename)
        Tournée_old, cost_old = hk!(G,idx,epsilon)
        cost_old = calculate_cost!(Tournée_old,filename)
        if cost_old < cost
            cost = cost_old
            Tournée = Tournée_old
            Id = idx
        end
    end
    return Tournée, cost , Id
end


"""
La fonction finetuning_epsilon_hk permet de déterminer le meilleur critère d'arret dans 
list_epsilon  pour trouver la tournée minimale pour hk!, tout en gardant les autres paramètres fixes.
"""
function finetuning_epsilon_hk(filename::String, idx, list_epsilon)


    G = create_graph(filename)
    Tournée, cost = hk!(G,idx,list_epsilon[1])
    cost = calculate_cost!(Tournée,filename)
    eps = list_epsilon[1]
    for k in 2:length(list_epsilon) 
        G = create_graph(filename)
        Tournée_old, cost_old = hk!(G,idx,list_epsilon[k])
        cost_old = calculate_cost!(Tournée_old,filename)
        if cost_old < cost
            cost = cost_old
            Tournée = Tournée_old
            eps = list_epsilon[k]
        end
    end
    return Tournée, cost , eps
end


"""
La fonction finetuning_start_epsilon_hk permet de déterminer la tournée minimale pour hk! 
en focntion du noeud de départ et du critère d'arret,
 tout en gardant les autres paramètres fixes.
"""

function finetuning_start_epsilon_hk(filename::String, list_epsilon)


    G = create_graph(filename)
    n = length(G.Nodes)
    Tournée, cost = hk!(G,1,list_epsilon[1])
    cost = calculate_cost!(Tournée,filename)
    eps = list_epsilon[1]
    Id = 1
    for k in 1:length(list_epsilon) 
        for idx in 1:n
            G = create_graph(filename)
            Tournée_old, cost_old = hk!(G,idx,list_epsilon[k])
            cost_old = calculate_cost!(Tournée_old,filename)
            if cost_old < cost
                cost = cost_old
                Tournée = Tournée_old
                eps = list_epsilon[k]
                Id  = idx 
            end
        end
    end
    return Tournée, cost , eps, Id
end