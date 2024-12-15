### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 83a09239-1b5f-4a8a-9bfb-bfdb75954057
using Pkg

# ╔═╡ 589d44c1-2db0-4c57-8e2e-5e948e829266
Pkg.add("Images")

# ╔═╡ 921bdba9-039b-43bc-91d2-ca9ada6d2192
### A Pluto.jl notebook ###
# v0.19.46

using InteractiveUtils

# ╔═╡ 913f4fe8-01ca-4a56-9887-fc872a685cb7
using Markdown


# ╔═╡ 2e6c6027-badd-4e01-b60f-537ada8584df
using Logging

# ╔═╡ 21c42fb7-de12-434c-a803-9c857c2acab4
using Plots

# ╔═╡ 519165a1-bb36-4c07-8ae7-d434b1d43918
using Images

# ╔═╡ 6ae59a3a-e9f1-48eb-b8e5-0623192eee18
# ╠═╡ disabled = true
#=╠═╡
using Markdown
  ╠═╡ =#

# ╔═╡ d167e63f-7c8e-47f2-95df-e1e744c1c2fe
# ╠═╡ disabled = true
#=╠═╡
using InteractiveUtils
  ╠═╡ =#

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
md"""[https://github.com/Sarerakabari/mth6412b-starter-code/tree/phase4/src/phase5](https://github.com/Sarerakabari/mth6412b-starter-code/tree/phase4/src/phase5)"""

# ╔═╡ 59ab3702-0bc7-4058-8341-57c5690fbd78
md""" Le lecteur peut fork le projet et lancer le fichier main.jl pour retrouver les résultats ci-dessus"""

# ╔═╡ c29b7e8d-e090-41c7-b8ea-52882dc6fda5
md"""
##### 1. Code principale
"""

# ╔═╡ b3610af2-96a1-4068-8221-fe193aa1affc
md"""
Les trois fonctions dans le main ont un fonctionnement similaire. Tout d'abord, elles créent un graphe à partir d'un fichier .tsp. Ensuite, elles suppriment le nœud d'indice 1 ainsi que tous les arêtes qui lui sont incidentes, car ces arêtes ont un poids nul. Après cette étape, elles exécutent l'une des méthodes ('rsl', 'hk!', ou finetuning_start_rsl) pour trouver la tournée optimale. Enfin, l'indice du nœud supprimé est réinséré dans la liste pour reconstruire l'image.

"""

# ╔═╡ 61a04b84-efc9-44a4-aeb6-d31d897396f7
md"""
```julia include("../phase1/node.jl")
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




function rsl_reconstruct(tsp_filepath::String,
     shuffled_filepath::String, id::Int)

    graph = create_graph(tsp_filepath)
    # Enlever le premier noeud et toutes les arretes lui incident
    graph.Edges = filter(edge -> edge.node1 != graph.Nodes[1] && edge.node2 != graph.Nodes[1], graph.Edges)
    graph.Nodes = filter(node -> node != graph.Nodes[1], graph.Nodes)

    tournee,weight=rsl(graph, id)
    tournee=tournee.Nodes
    weight=Float32(weight)
    # Ajout de l'indice premier noeud
    node_ids = vcat(1,[parse(Int, node.name) for node in tournee])
    write_tour("finale-rsl.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
    reconstruct_picture("/Users/mouhtal/Desktop/mth6412b-starter-code-6/finale-rsl.tour",shuffled_filepath,"finale-rsl.png", view = true)

end



function hk_reconstruct(tsp_filepath::String,
   shuffled_filepath::String, id::Int)

   graph = create_graph(tsp_filepath)
   # Enlever le premier noeud et toutes les arretes lui incident
   graph.Edges = filter(edge -> edge.node1 != graph.Nodes[1] && edge.node2 != graph.Nodes[1], graph.Edges) 
   graph.Nodes = filter(node -> node != graph.Nodes[1], graph.Nodes)

   tournee,weight=hk!(graph, id, 0.5)
   tournee=tournee.Nodes
   weight=Float32(weight)
   # Ajout de l'indice premier noeud
   node_ids = vcat(1,[parse(Int, node.name) for node in tournee])
   write_tour("finale-hk.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
   reconstruct_picture("/Users/mouhtal/Desktop/mth6412b-starter-code-6/finale-hk.tour",shuffled_filepath,"finale-hk.png", view = true)

end


function finrtuning_rsl_reconstruct(tsp_filepath::String,
    shuffled_filepath::String)

   graph = create_graph(tsp_filepath)
   # Enlever le premier noeud et toutes les arretes lui incident
   graph.Edges = filter(edge -> edge.node1 != graph.Nodes[1] && edge.node2 != graph.Nodes[1], graph.Edges)
   graph.Nodes = filter(node -> node != graph.Nodes[1], graph.Nodes)

   tournee,weight,_=finetuning_start_rsl(graph)
   tournee=tournee.Nodes
   weight=Float32(weight)
   # Ajout de l'indice premier noeud
   node_ids = vcat(1,[parse(Int, node.name) for node in tournee])
   write_tour("finale-tuning.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
   reconstruct_picture("/Users/mouhtal/Desktop/mth6412b-starter-code-6/finale-tuning.tour",shuffled_filepath,"finale-tuning.png", view = true)

end
```
"""

# ╔═╡ 6c298576-3b67-42e8-a3ce-3a11635e99ee
md"""
##### 1. Résulats
"""

# ╔═╡ f537d5c9-8dff-4b09-96f3-437f1dc864e7
load("/Users/mouhtal/Desktop/original/blue-hour-paris.png")

# ╔═╡ 77ecdf5c-0826-4612-8c8a-a505df909450
load("/Users/mouhtal/Desktop/Images_Phase_5/blue-hour-paris-finale.png")

# ╔═╡ d9f9ac63-7f95-48ce-bf94-d373ac1aa174
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-5.png")

# ╔═╡ 3b0d0c22-1e8e-41a3-8a1b-4f9f19b36250
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-2.png")

# ╔═╡ 39fbd867-dd71-4095-a068-aa57b2ad8167
load("/Users/mouhtal/Desktop/original/abstract-light-painting.png")

# ╔═╡ 2dacd6e7-f271-4fe5-b339-56b5233dc460
load("/Users/mouhtal/Desktop/Images_Phase_5/abstract-light-painting-finale.png")

# ╔═╡ dbbe9c3b-6837-4931-8ae4-475c8d4411f4
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-7.png")

# ╔═╡ ee1dc320-36bc-4f3a-88cd-49c4c22f6ba4
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk.png")

# ╔═╡ 3de3b725-1850-41c1-9526-cf28843ed6a6
load("/Users/mouhtal/Desktop/original/alaska-railroad.png")

# ╔═╡ b455b817-e721-4429-a9a2-b72602469ba4
load("/Users/mouhtal/Desktop/Images_Phase_5/alaska-railroad-finale.png")

# ╔═╡ 9b15b108-b970-4118-854d-a75760f5d0b1
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-6.png")

# ╔═╡ 7eb0718c-9334-486a-b490-501237eef89d
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-1.png")

# ╔═╡ d5f692f9-16b3-4baa-bf10-195b4b704ae9
load("/Users/mouhtal/Desktop/original/lower-kananaskis-lake.png")

# ╔═╡ 60e82982-4c47-4482-8f48-8606f72c5b69
load("/Users/mouhtal/Desktop/Images_Phase_5/lower-kananaskis-lake-finale.png")

# ╔═╡ 484954e4-3e4f-410a-8abe-8f9b72a9fbcd
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-4.png")

# ╔═╡ 48228c91-e447-453c-bdc1-11715078b5ca
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-3.png")

# ╔═╡ 827adec8-f093-4c16-8fdb-e5fe827a52d9
load("/Users/mouhtal/Desktop/original/marlet2-radio-board.png")

# ╔═╡ c31332f4-898b-4004-9943-2255e8196bcf
load("/Users/mouhtal/Desktop/Images_Phase_5/marlet2-radio-board-finale.png")

# ╔═╡ e0e8f879-e6cf-4ff1-8b04-954c845a615d
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-3.png")

# ╔═╡ de1dea29-bfbe-431b-850a-ab2991fa6777
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-4.png")

# ╔═╡ 8c416c01-2bd9-4479-9090-b7b83bac6da4
load("/Users/mouhtal/Desktop/original/nikos-cat.png")

# ╔═╡ fbb052f1-372a-41c6-9752-d0120ed1eb99
load("/Users/mouhtal/Desktop/Images_Phase_5/nikos-cat-finale.png")

# ╔═╡ 8e2fbd5e-6de2-4761-9f4d-c560cf135c67
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-2.png")

# ╔═╡ ebc0903e-106c-457e-b8e0-0ceefab5b3ee
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-5.png")

# ╔═╡ 1e546240-8abd-4f5c-9c54-3798fa2e381c
load("/Users/mouhtal/Desktop/original/pizza-food-wallpaper.png")

# ╔═╡ 11f0dd98-21ea-4052-b704-2338e776e0d2
load("/Users/mouhtal/Desktop/Images_Phase_5/pizza-food-wallpaper-finale.png")

# ╔═╡ bc1ea258-afc5-4eaa-b13f-0d71975f3368
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-1.png")

# ╔═╡ b732dd61-0bdf-4df3-99fb-dbec9dbee39f
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-6.png")

# ╔═╡ 3ec30119-c524-4465-8be9-aa0a4936bf61
load("/Users/mouhtal/Desktop/original/the-enchanted-garden.png")

# ╔═╡ ab220787-6e86-44d6-bb4e-867efcb13a87
load("/Users/mouhtal/Desktop/Images_Phase_5/the-enchanted-garden-finale.png")

# ╔═╡ abc780ff-99d0-46fb-a66b-ecbf8b952626
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/the-enchanted-garden-finale-tuning.png")

# ╔═╡ 1140218d-2f55-41e1-be11-12c8cefae66e
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-7.png")

# ╔═╡ 8a05d45b-2fac-4f8f-ad0d-82bd4abaf067
load("/Users/mouhtal/Desktop/original/tokyo-skytree-aerial.png")

# ╔═╡ c0d2dbbf-630b-4dbd-9908-3806624028b0
load("/Users/mouhtal/Desktop/Images_Phase_5/tokyo-skytree-aerial-finale.png")

# ╔═╡ 7af7a583-292b-4e96-bb86-c65d77a1cbcb
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning.png")

# ╔═╡ a57d9c48-6e78-412f-b1a5-abbf7b160909
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-8.png")

# ╔═╡ Cell order:
# ╠═921bdba9-039b-43bc-91d2-ca9ada6d2192
# ╠═913f4fe8-01ca-4a56-9887-fc872a685cb7
# ╠═83a09239-1b5f-4a8a-9bfb-bfdb75954057
# ╠═589d44c1-2db0-4c57-8e2e-5e948e829266
# ╠═6ae59a3a-e9f1-48eb-b8e5-0623192eee18
# ╠═d167e63f-7c8e-47f2-95df-e1e744c1c2fe
# ╠═2e6c6027-badd-4e01-b60f-537ada8584df
# ╠═21c42fb7-de12-434c-a803-9c857c2acab4
# ╠═519165a1-bb36-4c07-8ae7-d434b1d43918
# ╟─19af25d4-9b07-4e27-9c4b-3e4d7524ad02
# ╟─07b05913-0271-4558-8ddb-7c7f6f6bb009
# ╟─5a203496-f9a1-4f63-ada9-974bd0bbacdb
# ╟─2e98cb46-cc46-4ddb-95fb-6dd388b2a397
# ╟─59ab3702-0bc7-4058-8341-57c5690fbd78
# ╠═c29b7e8d-e090-41c7-b8ea-52882dc6fda5
# ╠═b3610af2-96a1-4068-8221-fe193aa1affc
# ╟─61a04b84-efc9-44a4-aeb6-d31d897396f7
# ╟─6c298576-3b67-42e8-a3ce-3a11635e99ee
# ╠═f537d5c9-8dff-4b09-96f3-437f1dc864e7
# ╠═77ecdf5c-0826-4612-8c8a-a505df909450
# ╠═d9f9ac63-7f95-48ce-bf94-d373ac1aa174
# ╠═3b0d0c22-1e8e-41a3-8a1b-4f9f19b36250
# ╠═39fbd867-dd71-4095-a068-aa57b2ad8167
# ╠═2dacd6e7-f271-4fe5-b339-56b5233dc460
# ╠═dbbe9c3b-6837-4931-8ae4-475c8d4411f4
# ╟─ee1dc320-36bc-4f3a-88cd-49c4c22f6ba4
# ╠═3de3b725-1850-41c1-9526-cf28843ed6a6
# ╠═b455b817-e721-4429-a9a2-b72602469ba4
# ╠═9b15b108-b970-4118-854d-a75760f5d0b1
# ╠═7eb0718c-9334-486a-b490-501237eef89d
# ╠═d5f692f9-16b3-4baa-bf10-195b4b704ae9
# ╠═60e82982-4c47-4482-8f48-8606f72c5b69
# ╠═484954e4-3e4f-410a-8abe-8f9b72a9fbcd
# ╠═48228c91-e447-453c-bdc1-11715078b5ca
# ╠═827adec8-f093-4c16-8fdb-e5fe827a52d9
# ╠═c31332f4-898b-4004-9943-2255e8196bcf
# ╠═e0e8f879-e6cf-4ff1-8b04-954c845a615d
# ╠═de1dea29-bfbe-431b-850a-ab2991fa6777
# ╠═8c416c01-2bd9-4479-9090-b7b83bac6da4
# ╠═fbb052f1-372a-41c6-9752-d0120ed1eb99
# ╠═8e2fbd5e-6de2-4761-9f4d-c560cf135c67
# ╠═ebc0903e-106c-457e-b8e0-0ceefab5b3ee
# ╠═1e546240-8abd-4f5c-9c54-3798fa2e381c
# ╠═11f0dd98-21ea-4052-b704-2338e776e0d2
# ╠═bc1ea258-afc5-4eaa-b13f-0d71975f3368
# ╠═b732dd61-0bdf-4df3-99fb-dbec9dbee39f
# ╠═3ec30119-c524-4465-8be9-aa0a4936bf61
# ╠═ab220787-6e86-44d6-bb4e-867efcb13a87
# ╠═abc780ff-99d0-46fb-a66b-ecbf8b952626
# ╠═1140218d-2f55-41e1-be11-12c8cefae66e
# ╠═8a05d45b-2fac-4f8f-ad0d-82bd4abaf067
# ╠═c0d2dbbf-630b-4dbd-9908-3806624028b0
# ╠═7af7a583-292b-4e96-bb86-c65d77a1cbcb
# ╠═a57d9c48-6e78-412f-b1a5-abbf7b160909