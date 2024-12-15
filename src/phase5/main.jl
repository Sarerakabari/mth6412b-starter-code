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


#graph=create_graph("/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/shredder-julia/tsp/instances/blue-hour-paris.tsp")
#tournee,weight=rsl(graph,190) # Utilisation de l'algorithme rsl pour trouver une tournée minimale
tournee,weight,_=finetuning_start_rsl("/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/shredder-julia/tsp/instances/blue-hour-paris.tsp")
tournee=tournee.Nodes
weight=Float32(weight)
node_ids = vcat(1,[parse(Int, node.name) for node in tournee])
write_tour("blue-paris-after.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante

# Nom du fichier d'image d'entrée
#tour_filename = "/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/shredder-julia/tsp/tours/blue-hour-paris.tour"
tour_filename = "/Users/mouhtal/Desktop/mth6412b-starter-code-6/blue-paris-after.tour"
reconstruct_picture(tour_filename,"/Users/mouhtal/Desktop/mth6412b-starter-code-6/src/shredder-julia/images/shuffled/blue-hour-paris.png","blue-paris-finale.png", view = true)