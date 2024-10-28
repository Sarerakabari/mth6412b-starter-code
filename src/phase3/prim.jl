import Base.show
include("node_priority.jl")
include("queue.jl")

"""Algorithme prim pour trouver l'arbre de recouvrement minimale 
   dans un graphe non orienté""" 

function prim(graph::Graph{T,S}) where {T,S}


    #Création d'une file de priorité vide

    Q=node_Queue{node_priority{T}}()

    #initialisation de la file de priorité 
    for node in graph.Nodes
        push!(Q,node_priority(node))
        
    end
    # Choix arbitraire d'un noeud de priorité ) 
    priority!(Q.items[1],0)
   
    #Initilaisation du vecteur des arêtes composant l'arbre de recouvrement minimal et du cout total
    A=Vector{Edge{T,S}}()
    total_cost=0

    #Selection des arêtes qui fera partie de l'arbre de recouvrement minimal 
    while !is_empty(Q)
        #noeud de priorité maximal
        u=popfirst!(Q)
        
        #voisin du noeud u
        u_neighboor=findall(x->x.node1==u.node||x.node2==u.node,G.Edges)
       
        # initialisation de l'arête legère et son indice
        min_weight=Inf
        idx=nothing


        for i in u_neighboor

            # Voisin de u dans Q
            if G.Edges[i].node1==u.node 
            j=findfirst(x->x.node==G.Edges[i].node2,Q.items)
            else
            j=findfirst(x->x.node==G.Edges[i].node1,Q.items)    
            end
           
            
            if !isnothing(j) 
                
                #mise à jour de priorité de Q
                if G.Edges[i].data < Q.items[j].priority

                   priority!(Q.items[j],G.Edges[i].data)
                   
                   parent!(Q.items[j],u.node)
                    
                end
              
                
            end

        end    

        # ajout de l'arête legère

        if !isnothing(u.parent)
            push!(A,Edge(string(u.parent.name,u.node.name),u.priority,u.parent,u.node))
            total_cost+=u.priority
        end   
    end
    # création de l'arbre de recouvrement minimale 
    mst=Graph("MST",G.Nodes,A)
    
    return mst,total_cost
end