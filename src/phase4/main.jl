include("../phase1/main.jl")
include("../phase3/node_priority.jl")
include("../phase3/queue.jl")
include("../phase3/prim.jl")
include("rsl.jl")
include("finetuning.jl")
include("visualise_graph.jl")


# Création du graphe à partir bayg29.tsp
G=create_graph("/Users/mouhtal/Desktop/mth6412b-starter-code-3/instances/stsp/bays29.tsp")

   
T,C,noeud = finetuning_start(rsl, G)
visualize_graph(T.Nodes, T.Edges)
