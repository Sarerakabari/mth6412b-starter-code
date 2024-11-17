include("../phase1/main.jl")
include("../phase3/prim.jl")
include("../phase4/sub_graph.jl")
include("../phase4/degrees.jl")
include("../phase4/weigth_update.jl")
include("weighted_node.jl")
include("fix_tree.jl")



function hk(graph::Graph{T,S},idx)where {T,S}

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
    # Initialisation des pourcentage de noeud de degrée 2
    maxz=0
    z=0

while tk>6*1e-1 # condition d'arrêt 
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
    #println(tk)

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
    
    # suivi de performance pour debugger
    #z=(count(x -> x == 0, v_k)/length(v_k))*100
    #if z>=maxz
    #    maxz=z
        #println(maxz)
   #end

end
# correction de l'arbre pour avoir un circuit 
T_k,W=fix_tree(graph,T_k,graph.Nodes[idx])
W=W-2*pi_k

return T_k,W
end
