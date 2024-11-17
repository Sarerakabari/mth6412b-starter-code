include("../phase1/main.jl")
include("../phase3/kruskal_heuristic.jl")
include("../phase3/prim.jl")
include("weighted_node.jl")

"""calcul de degrees de chaque noeud et le sous gradient"""
function degrees(graph::Graph{T,S})where {T,S}
    # initialisation degrees des noeud
    d=Vector{weighted_node{T}}()
    p=[]
    # initialisation sous-gradient
    v_k=Vector{weighted_node{T}}()
    v=[]
   

    
    
    for node in graph.Nodes
       
        #initialisation de poids d'un noeud

        push!(d,weighted_node(node))
        push!(v_k,weighted_node(node))

        # voisins connecté à ce nouvelle
        neighboor_nodes=findall(x->x.node1==node||x.node2==node,graph.Edges)
         j=0
        # vecteur de noeud contentant les voisins

         A=Vector{Node{T}}()

        # compatge des voisins
        for i in neighboor_nodes

            if graph.Edges[i].node1==node
                n=graph.Edges[i].node2
            else
                n=graph.Edges[i].node1
            end

            if !(n in A)
        
                push!(A,n)

                j+=1
            end
            
        end
        # mise à jour du poids
        priority!(d[end],float.(j))

        # mise à jour du sous gradient
        priority!(v_k[end],float.(j-2))

        # mise à jour du vecteur degrées
        push!(p,j)
        # mise à jour du vecteur sous gradient
        push!(v,(j-2))


    end
    return d,v_k,p,v
   
end