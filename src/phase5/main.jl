include("bin/tools.jl")

using STSP


"""Reconstruire les images à l'aide de rsl
args:

    tsp_filepath   : Le chemin vers le fichier .tsp 
    shuffled_filepath     : Le chemin vers l'image mélangé .png
    id : L'indice du noeud de départ dans rsl
"""
function rsl_reconstruct(tsp_filepath::String,
     shuffled_filepath::String, id::Int)

    graph = create_graph(tsp_filepath)
    # Enlever le premier noeud et toutes les arretes lui incident
    graph.Edges = filter(edge -> edge.node1 != graph.Nodes[1] && edge.node2 != graph.Nodes[1], graph.Edges)
    graph.Nodes = filter(node -> node != graph.Nodes[1], graph.Nodes)

    tournee,weight=rsl(graph, id)
    tournee=tournee.Nodes
    weight=Float32(weight)
    println(weight)

    # Ajout de l'indice premier noeud
    node_ids = vcat(1,[parse(Int, node.name) for node in tournee])
    write_tour("newimages/finale-rsl.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
    reconstruct_picture("newimages/finale-rsl.tour",shuffled_filepath,"newimages/finale-rsl.png", view = true)

end

rsl_reconstruct("tsp/instances/tokyo-skytree-aerial.tsp",
"images/shuffled/tokyo-skytree-aerial.png",
120)

"""Reconstruire les images à l'aide de hk
args:

    tsp_filepath   : Le chemin vers le fichier .tsp 
    shuffled_filepath     : Le chemin vers l'image mélangé .png
    id : L'indice du noeud de départ dans hk!
"""
function hk_reconstruct(tsp_filepath::String,
   shuffled_filepath::String, id::Int)

   graph = create_graph(tsp_filepath)
   # Enlever le premier noeud et toutes les arretes lui incident
   graph.Edges = filter(edge -> edge.node1 != graph.Nodes[1] && edge.node2 != graph.Nodes[1], graph.Edges) 
   graph.Nodes = filter(node -> node != graph.Nodes[1], graph.Nodes)

   tournee,weight=hk!(graph, id, 0.5)
   tournee=tournee.Nodes
   weight=Float32(weight)
   println(weight)
   # Ajout de l'indice premier noeud
   node_ids = vcat(1,[parse(Int, node.name) for node in tournee])
   write_tour("newimages/finale-hk.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
   reconstruct_picture("newimages/finale-hk.tour",shuffled_filepath,"newimages/finale-hk.png", view = true)

end


hk_reconstruct("tsp/instances/tokyo-skytree-aerial.tsp",
"images/shuffled/tokyo-skytree-aerial.png",
120)

"""Reconstruire les images à l'aide de rsl mis à l'échelle
args:

    tsp_filepath   : Le chemin vers le fichier .tsp 
    shuffled_filepath     : Le chemin vers l'image mélangé .png
"""
function finrtuning_rsl_reconstruct(tsp_filepath::String,
    shuffled_filepath::String)

   graph = create_graph(tsp_filepath)
   # Enlever le premier noeud et toutes les arretes lui incident
   graph.Edges = filter(edge -> edge.node1 != graph.Nodes[1] && edge.node2 != graph.Nodes[1], graph.Edges)
   graph.Nodes = filter(node -> node != graph.Nodes[1], graph.Nodes)

   tournee,weight,_=finetuning_start_rsl(graph)
   tournee=tournee.Nodes
   weight=Float32(weight)
   println(weight)

   # Ajout de l'indice premier noeud
   node_ids = vcat(1,[parse(Int, node.name) for node in tournee])
   write_tour("newimages/finale-tuning.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
   reconstruct_picture("newimages/finale-tuning.tour",shuffled_filepath,"newimages/finale-tuning.png", view = true)

end

finrtuning_rsl_reconstruct("tsp/instances/tokyo-skytree-aerial.tsp",
"images/shuffled/tokyo-skytree-aerial.png")