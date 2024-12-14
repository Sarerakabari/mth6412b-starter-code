# Chemin du dossier contenant les fichiers .tsp
tsp_folder = joinpath(dirname(@__FILE__), "tsp", "instances")

# Lire chaque fichier .tsp dans le dossier
for file in readdir(tsp_folder)
    if endswith(file, ".tsp")
        filepath = joinpath(tsp_folder, file)
        filename = splitext(basename(filepath))[1]

        header=read_header(filepath)
        nodes=read_nodes(header,filepath)  # On récupère les noeuds du tsp
        edges=read_edges(header,filepath) # On récupère les arêtes du tsp
        graph=Graph(filename,nodes,edges) # Création du graph correspondant au tsp

        tournee,weight=rsl(graph,1) # Utilisation de l'algorithme rsl pour trouver une tournée minimale

        write_tour(filename,tournee,weight) # Ecriture du fichier .tour de la tournée correspondante

        # Nom du fichier d'image d'entrée
        input_image = "$filename.png"
    
        # Nom du fichier d'image reconstruite
        reconstructed_image = "reconstructed_$filename.png"
        reconstruct_picture(filename,input_image,reconstructed_image)
    end
end