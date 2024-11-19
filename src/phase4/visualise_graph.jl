using Graphs
using GraphPlot
export visualize_graph
"""Fonction pour afficher les graphes graphiquement"""
function visualize_graph(graph::Graph{T,S}) where {T,S}
    # Associer chaque nœud à un identifiant numérique pour Graphs.jl
    
        fig = plot(legend=false)
      
        # edge positions
        for edge in graph.Edges
          
            plot!([edge.node1.data[1], edge.node2.data[1]], [edge.node1.data[2], edge.node2.data[2]],
                linewidth=1.5, alpha=0.75, color=:red)
          
        end
        x=[]
        y=[]
        #node positions
        for node in graph.Nodes
        push!(x,node.data[1])
        push!(y,node.data[2])
        
        end
        scatter!(x, y)
        fig
    
end