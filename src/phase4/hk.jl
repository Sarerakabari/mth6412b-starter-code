include("../phase1/main.jl")
include("../phase3/prim.jl")
include("../phase4/sub_graph.jl")
include("../phase4/degrees.jl")
include("../phase4/weigth_update.jl")
include("weighted_node.jl")
include("fix_tree.jl")
export hk!

"""
L'algorithme hk pour calculer une tournée optimale.
args:

    graph   : Le graphe où l'on veut chercher la tournée optimale
    idx     : L'indice du noeud de départ
    epsilon : Critère d'arret

"""
function hk!(graph::Graph{T,S},idx,epsilon)where {T,S}
    #initialisation des itérations
    k=0
    k_2=0
    # cout du circuit
    W=-Inf
    #initialisation du  1 arbre
    T_k=graph
    # initialisation de la correction des poids
    pi_k=0
    # initialisation de la periode
    periode=floor(Int,(length(graph.Nodes)/2))
    # initialisation du sous gradient
    P_k=Vector{weighted_node{T}}()
    for node in graph.Nodes
    push!(P_k,weighted_node(node))
    end
    n=length(graph.Nodes)
    # initialisation du vecteur sous gradient
    v_k=ones(n)
    # pas initiale 
    tk=1

while tk > epsilon # condition d'arrêt 
    # création du 1 arbre
    T_k,L=one_tree(graph,idx)

    # correction du cout
    W_k=L-2*pi_k
    W=max(W,W_k)

    # calcul des degrées et du sous gradient
    D,V,d_k,v_k=degrees(T_k)

    #mise à jour du pas et de la période 
    if k==periode
        periode=floor(Int,(periode/2))+1
        tk=tk/2
        k=0    

    end
    # mise à jour de la correction sur le poids
    pi_k=pi_k+tk*sum(v_k)
    # mise à jour des poids
    for p_k in P_k
        p_k.priority=p_k.priority+tk*V[findfirst(x->x.node==p_k.node,V)].priority 
    end
    weigth_update!(graph,P_k)
    # mise à jour des itérations
    k=k+1
    k_2+=1
end
# correction de l'arbre pour avoir un circuit 
T_k,W=fix_tree(graph,T_k,graph.Nodes[idx])
#W=W-2*pi_k

return T_k,W
end
