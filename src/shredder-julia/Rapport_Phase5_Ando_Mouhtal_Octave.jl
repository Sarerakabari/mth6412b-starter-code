### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 921bdba9-039b-43bc-91d2-ca9ada6d2192


# ╔═╡ 83a09239-1b5f-4a8a-9bfb-bfdb75954057


# ╔═╡ 589d44c1-2db0-4c57-8e2e-5e948e829266


# ╔═╡ 6ae59a3a-e9f1-48eb-b8e5-0623192eee18


# ╔═╡ d167e63f-7c8e-47f2-95df-e1e744c1c2fe


# ╔═╡ 2e6c6027-badd-4e01-b60f-537ada8584df


# ╔═╡ 21c42fb7-de12-434c-a803-9c857c2acab4


# ╔═╡ 19af25d4-9b07-4e27-9c4b-3e4d7524ad02


# ╔═╡ 07b05913-0271-4558-8ddb-7c7f6f6bb009


# ╔═╡ 5a203496-f9a1-4f63-ada9-974bd0bbacdb


# ╔═╡ 2e98cb46-cc46-4ddb-95fb-6dd388b2a397


# ╔═╡ 59ab3702-0bc7-4058-8341-57c5690fbd78


# ╔═╡ c29b7e8d-e090-41c7-b8ea-52882dc6fda5


# ╔═╡ b3610af2-96a1-4068-8221-fe193aa1affc


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
	
	        write_tour(filename,tournee,weight) # Ecriture du fichier .tour de la tournée correspondante
	
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
