### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 6ae59a3a-e9f1-48eb-b8e5-0623192eee18
using Markdown

# ╔═╡ d167e63f-7c8e-47f2-95df-e1e744c1c2fe
using InteractiveUtils

# ╔═╡ 2e6c6027-badd-4e01-b60f-537ada8584df
using Logging

# ╔═╡ 21c42fb7-de12-434c-a803-9c857c2acab4
using Plots

# ╔═╡ 921bdba9-039b-43bc-91d2-ca9ada6d2192
### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 83a09239-1b5f-4a8a-9bfb-bfdb75954057
#using Pkg

# ╔═╡ 589d44c1-2db0-4c57-8e2e-5e948e829266
#Pkg.add("Images")

# ╔═╡ 19af25d4-9b07-4e27-9c4b-3e4d7524ad02
md"""
### Mini rapport: Phase 5 du projet
#
"""

# ╔═╡ 07b05913-0271-4558-8ddb-7c7f6f6bb009
md"""
```
Auteurs:Ando Rakotonandrasana
		Oussama Mouhtal
		Octave Claich
```
"""

# ╔═╡ 5a203496-f9a1-4f63-ada9-974bd0bbacdb
md""" Le  code se trouve au lien suivant: """

# ╔═╡ 2e98cb46-cc46-4ddb-95fb-6dd388b2a397
md"""[https://github.com/Sarerakabari/mth6412b-starter-code/tree/phase4/src/shredder-julia](https://github.com/Sarerakabari/mth6412b-starter-code/tree/phase4/src/shredder-julia)"""

# ╔═╡ 59ab3702-0bc7-4058-8341-57c5690fbd78
md""" Le lecteur peut fork le projet et lancer le fichier main.jl pour retrouver les résultats ci-dessus"""

# ╔═╡ c29b7e8d-e090-41c7-b8ea-52882dc6fda5
md"""
##### 1. Fichier main pour reconstituer les images
"""

# ╔═╡ b3610af2-96a1-4068-8221-fe193aa1affc
md"""
On a essayé d'écrire un fichier main pour générer les images reconstruites à partir des images shuffled et de nos algorithmes rsl et hk. On commence par récupérer le chemin du dossier contenant les instances des fichiers tsp.
Ensuite, on traite chaque instance dans le boucle for, on récupère le filepath et le filename, on crée un graph à partir du filepath à l'aide de la fonction create_graph.
On utilise l'algorithme de rsl à partir du noeud n°1 pour trouvée une tournée minimale et son poids.

Or, notre algorithme rsl fait en sorte que tournee est en fait un graph contenant uniquement les arêtes formant la tournée minimale, c'est là que nous avons un souci. Il faudrait recoder l'entièreté de rsl et hk pour modifier cela sans doute. On propose de prendre les noeuds de tournee pour continuer, mais ce seront sans doute simplement les noeuds du graphe dans l'ordre, donc il n'y aura aucune modification.

On convertit ensuite weight au format convenable pour write_tour, et on se sert de node_ids pour avoir aussi un type convenable pour les noeuds de write_tour.

La fonction write_tour crée un fichier de tournée minimale dans notre dossier, et on utilise reconstruct_picture pour reconstruire une image.
Mais on n'y arrive pas, on a un problème notamment de Out of Bounds à cause du noeud 0 qui est rajouté selon l'énoncé mais supprimé nulle part (pas précisé dans tools).

"""

# ╔═╡ 61a04b84-efc9-44a4-aeb6-d31d897396f7
md"""
```julia
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
	
	        write_tour(filename,node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
	
	        # Nom du fichier d'image d'entrée
	        input_image = "$filename.png"
	    
	        # Nom du fichier d'image reconstruite
	        reconstructed_image = "reconstructed_$filename.png"
	        reconstruct_picture(filename,input_image,reconstructed_image)
	    end
	end
```
"""

# ╔═╡ Cell order:
# ╠═921bdba9-039b-43bc-91d2-ca9ada6d2192
# ╠═83a09239-1b5f-4a8a-9bfb-bfdb75954057
# ╠═589d44c1-2db0-4c57-8e2e-5e948e829266
# ╠═6ae59a3a-e9f1-48eb-b8e5-0623192eee18
# ╠═d167e63f-7c8e-47f2-95df-e1e744c1c2fe
# ╠═2e6c6027-badd-4e01-b60f-537ada8584df
# ╠═21c42fb7-de12-434c-a803-9c857c2acab4
# ╠═19af25d4-9b07-4e27-9c4b-3e4d7524ad02
# ╠═07b05913-0271-4558-8ddb-7c7f6f6bb009
# ╠═5a203496-f9a1-4f63-ada9-974bd0bbacdb
# ╠═2e98cb46-cc46-4ddb-95fb-6dd388b2a397
# ╠═59ab3702-0bc7-4058-8341-57c5690fbd78
# ╠═c29b7e8d-e090-41c7-b8ea-52882dc6fda5
# ╠═b3610af2-96a1-4068-8221-fe193aa1affc
# ╠═61a04b84-efc9-44a4-aeb6-d31d897396f7
