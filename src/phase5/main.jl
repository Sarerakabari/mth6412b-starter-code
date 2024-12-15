include("../phase1/node.jl")
include("../phase1/Edge.jl")
include("../phase1/graph.jl")
include("../phase1/read_stsp.jl")
include("../phase1/create_graph.jl")
include("../phase2/node_pointer.jl")
include("../phase2/kruskal.jl")
include("../phase3/node_priority.jl")
include("../phase3/queue.jl")
include("../phase3/prim.jl")
include("../phase4/rsl.jl")
include("../phase4/degrees.jl")
include("../phase4/weighted_node.jl")
include("../phase4/weigth_update.jl")
include("../phase4/sub_graph.jl")
include("../phase4/fix_tree.jl")
include("../phase4/hk.jl")
include("../phase4/finetuning.jl")
include("bin/tools.jl")




function rsl_reconstruct(tsp_filepath::String, tour_filepath::String,
     shuffled_filepath::String, id::Int)

    graph = create_graph(tsp_filepath)
    graph.Edges = filter(edge -> edge.node1 != graph.Nodes[1] && edge.node2 != graph.Nodes[1], graph.Edges)
    graph.Nodes = filter(node -> node != graph.Nodes[1], graph.Nodes)

    tournee,weight=rsl(graph, id)
    tournee=tournee.Nodes
    weight=Float32(weight)
    node_ids = vcat(1,[parse(Int, node.name) for node in tournee])
    write_tour("finale-rsl.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
    reconstruct_picture("/Users/mouhtal/Desktop/mth6412b-starter-code-6/finale-rsl.tour",shuffled_filepath,"finale-rsl.png", view = true)

end

#rsl_reconstruct("/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/tsp/instances/abstract-light-painting.tsp",
#"/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/tsp/tours/abstract-light-painting.tour",
#"/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/images/shuffled/abstract-light-painting.png",
#20)


function hk_reconstruct(tsp_filepath::String, tour_filepath::String,
   shuffled_filepath::String, id::Int)

   graph = create_graph(tsp_filepath)
   graph.Edges = filter(edge -> edge.node1 != graph.Nodes[1] && edge.node2 != graph.Nodes[1], graph.Edges) 
   graph.Nodes = filter(node -> node != graph.Nodes[1], graph.Nodes)

   tournee,weight=hk!(graph, id, 0.5)
   tournee=tournee.Nodes
   weight=Float32(weight)
   node_ids = vcat(1,[parse(Int, node.name) for node in tournee])
   write_tour("finale-hk.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
   reconstruct_picture("/Users/mouhtal/Desktop/mth6412b-starter-code-6/finale-hk.tour",shuffled_filepath,"finale-hk.png", view = true)

end


hk_reconstruct("/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/tsp/instances/tokyo-skytree-aerial.tsp",
"/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/tsp/tours/tokyo-skytree-aerial.tour",
"/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/images/shuffled/tokyo-skytree-aerial.png",
120)


function finrtuning_rsl_reconstruct(tsp_filepath::String, tour_filepath::String,
    shuffled_filepath::String)

   graph = create_graph(tsp_filepath)
   graph.Edges = filter(edge -> edge.node1 != graph.Nodes[1] && edge.node2 != graph.Nodes[1], graph.Edges)
   graph.Nodes = filter(node -> node != graph.Nodes[1], graph.Nodes)

   tournee,weight,_=finetuning_start_rsl(graph)
   tournee=tournee.Nodes
   weight=Float32(weight)
   node_ids = vcat(1,[parse(Int, node.name) for node in tournee])
   write_tour("finale-tuning.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
   reconstruct_picture("/Users/mouhtal/Desktop/mth6412b-starter-code-6/finale-tuning.tour",shuffled_filepath,"finale-tuning.png", view = true)

end

#finrtuning_rsl_reconstruct("/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/tsp/instances/abstract-light-painting.tsp",
#"/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/tsp/tours/abstract-light-painting.tour",
#"/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/phase5/images/shuffled/abstract-light-painting.png")