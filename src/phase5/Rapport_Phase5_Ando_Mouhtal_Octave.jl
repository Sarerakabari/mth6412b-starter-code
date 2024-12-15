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

# ╔═╡ Cell order:
# ╠═921bdba9-039b-43bc-91d2-ca9ada6d2192
# ╠═913f4fe8-01ca-4a56-9887-fc872a685cb7
# ╠═83a09239-1b5f-4a8a-9bfb-bfdb75954057
# ╠═589d44c1-2db0-4c57-8e2e-5e948e829266
# ╠═6ae59a3a-e9f1-48eb-b8e5-0623192eee18
# ╠═d167e63f-7c8e-47f2-95df-e1e744c1c2fe
# ╠═2e6c6027-badd-4e01-b60f-537ada8584df
# ╠═21c42fb7-de12-434c-a803-9c857c2acab4
# ╟─19af25d4-9b07-4e27-9c4b-3e4d7524ad02
# ╟─07b05913-0271-4558-8ddb-7c7f6f6bb009
# ╟─5a203496-f9a1-4f63-ada9-974bd0bbacdb
# ╟─2e98cb46-cc46-4ddb-95fb-6dd388b2a397
# ╟─59ab3702-0bc7-4058-8341-57c5690fbd78
# ╠═c29b7e8d-e090-41c7-b8ea-52882dc6fda5
# ╠═b3610af2-96a1-4068-8221-fe193aa1affc
# ╟─61a04b84-efc9-44a4-aeb6-d31d897396f7