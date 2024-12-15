#include("../phase1/node.jl")
#include("../phase1/Edge.jl")
#include("../phase1/graph.jl")
#include("../phase1/read_stsp.jl")
#include("../phase1/create_graph.jl")
#include("../phase2/node_pointer.jl")
#include("../phase2/kruskal.jl")
#include("../phase3/node_priority.jl")
#include("../phase3/queue.jl")
#include("../phase3/prim.jl")
#include("../phase4/rsl.jl")
#include("../phase4/degrees.jl")
#include("../phase4/weighted_node.jl")
#include("../phase4/weigth_update.jl")
#include("../phase4/sub_graph.jl")
#include("../phase4/fix_tree.jl")
#include("../phase4/hk.jl")
#include("../phase4/finetuning.jl")
#include("bin/tools.jl")

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
    write_tour("finale-rsl.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
    reconstruct_picture("/Users/mouhtal/Desktop/mth6412b-starter-code-6/finale-rsl.tour",shuffled_filepath,"finale-rsl.png", view = true)

end

rsl_reconstruct("/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/tsp/instances/lower-kananaskis-lake.tsp",
"/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/images/shuffled/lower-kananaskis-lake.png",
500)

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
   write_tour("finale-hk.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
   reconstruct_picture("/Users/mouhtal/Desktop/mth6412b-starter-code-6/finale-hk.tour",shuffled_filepath,"finale-hk.png", view = true)

end


hk_reconstruct("/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/tsp/instances/lower-kananaskis-lake.tsp",
"/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/images/shuffled/lower-kananaskis-lake.png",
200)

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
   write_tour("finale-tuning.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
   reconstruct_picture("/Users/mouhtal/Desktop/mth6412b-starter-code-6/finale-tuning.tour",shuffled_filepath,"finale-tuning.png", view = true)

end

finrtuning_rsl_reconstruct("/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/tsp/instances/lower-kananaskis-lake.tsp",
"/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/images/shuffled/lower-kananaskis-lake.png")