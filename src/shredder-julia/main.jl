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

# Chemin du dossier contenant les fichiers .tsp
tsp_folder = joinpath(dirname(@__FILE__), "tsp", "instances")

# Lire chaque fichier .tsp dans le dossier
for file in readdir(tsp_folder)
    if endswith(file, ".tsp")
        filepath = joinpath(tsp_folder, file)
        filename = splitext(basename(filepath))[1]

        graph=create_graph(filepath)

        tournee,weight=rsl(graph,1) # Utilisation de l'algorithme rsl pour trouver une tournée minimale
        tournee=tournee.Nodes
        weight=Float32(weight)
        node_ids = [parse(Int, node.name) for node in tournee]

        write_tour(filename,tournee,weight) # Ecriture du fichier .tour de la tournée correspondante

        # Nom du fichier d'image d'entrée
        input_image = "$filename.png"
    
        # Nom du fichier d'image reconstruite
        reconstructed_image = "reconstructed_$filename.png"
        reconstruct_picture(filename,input_image,reconstructed_image)
    end
end