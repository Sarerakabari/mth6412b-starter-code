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
```julia 
include("bin/tools.jl")

using STSP


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
    write_tour("newimages/finale-rsl.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
    reconstruct_picture("newimages/finale-rsl.tour",shuffled_filepath,"newimages/finale-rsl.png", view = true)

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
   println(weight)
   # Ajout de l'indice premier noeud
   node_ids = vcat(1,[parse(Int, node.name) for node in tournee])
   write_tour("newimages/finale-hk.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
   reconstruct_picture("newimages/finale-hk.tour",shuffled_filepath,"newimages/finale-hk.png", view = true)

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
   println(weight)

   # Ajout de l'indice premier noeud
   node_ids = vcat(1,[parse(Int, node.name) for node in tournee])
   write_tour("newimages/finale-tuning.tour",node_ids,weight) # Ecriture du fichier .tour de la tournée correspondante
   reconstruct_picture("newimages/finale-tuning.tour",shuffled_filepath,"newimages/finale-tuning.png", view = true)

end
```
"""

# ╔═╡ 6c298576-3b67-42e8-a3ce-3a11635e99ee
md"""
##### 1. Résulats
"""

# ╔═╡ 6037f6ce-f661-4460-b6bc-8413767fb697
md"""
Les résultats seront présentés dans l'ordre suivant : à chaque étape, nous afficherons l'image originale suivie de l'image reconstruite à l'aide de RSL, avec un nœud arbitraire précisé à chaque fois. Ensuite, nous présenterons l'image reconstruite par RSL (fine_tunning par rapport au point de départ), mais cette fois avec une version mise à l'échelle de l'algorithme RSL. Enfin,  nous afficherons l'image reconstruite avec HK, en utilisant un nœud spécifique et un $\epsilon$ fixé à $0.5$. Ce choix d'un $\epsilon$ relativement grand est justifié par le temps d'exécution important de l'algorithme.
"""

# ╔═╡ dd53c867-5d7e-4ab6-92b6-959ff7735a15
md"""
##### 1. Image Originale
"""

# ╔═╡ f537d5c9-8dff-4b09-96f3-437f1dc864e7
load("/Users/mouhtal/Desktop/original/blue-hour-paris.png")

# ╔═╡ 49781e04-ceec-4279-95a8-98643c3ec8ec
md"""
##### 2. Image reconstruite avec RSL en utilisant le nœud d'indice 200 comme point de départ. Le coût de la tournée associé à cette image est de 4 087 840.
"""

# ╔═╡ 77ecdf5c-0826-4612-8c8a-a505df909450
load("/Users/mouhtal/Desktop/Images_Phase_5/finale-rsl.png")

# ╔═╡ 1b0137c3-0db1-4fec-869f-cd5fc4fe1aca
md"""
##### 3. Image reconstruite avec RSL mis à l'échelle. Le coût de la tournée associé à cette image est de 4 055 188.
"""

# ╔═╡ d9f9ac63-7f95-48ce-bf94-d373ac1aa174
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning.png")

# ╔═╡ 548df163-c328-4c27-a87b-e6edfe61d944
md"""
##### 4. Image reconstruite avec hk en utilisant le nœud d'indice 200 comme point de départ. Le coût de la tournée associé à cette image est de 4 107 094.
"""

# ╔═╡ 3b0d0c22-1e8e-41a3-8a1b-4f9f19b36250
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk.png")

# ╔═╡ 2dacd5a1-1699-4529-b463-2da65d019ff0
md"""
##### 1. Image Originale
"""

# ╔═╡ 39fbd867-dd71-4095-a068-aa57b2ad8167
load("/Users/mouhtal/Desktop/original/abstract-light-painting.png")

# ╔═╡ 3aee7c91-9019-4e6e-b646-1c36badf0f00
md"""
##### 2. Image reconstruite avec RSL en utilisant le nœud d'indice 20 comme point de départ. Le coût de la tournée associé à cette image est de 12 438 810.
"""

# ╔═╡ 2dacd6e7-f271-4fe5-b339-56b5233dc460
load("/Users/mouhtal/Desktop/Images_Phase_5/finale-rsl-1.png")

# ╔═╡ cf74df7d-fc8a-488b-94c9-6e747f047dab
md"""
##### 3. Image reconstruite avec RSL mis à l'échelle. Le coût de la tournée associé à cette image est de 12 400 608.
"""

# ╔═╡ dbbe9c3b-6837-4931-8ae4-475c8d4411f4
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-1.png")

# ╔═╡ c2fdf96e-2c65-4d15-af2b-50571d926062
md"""
##### 4. Image reconstruite avec hk en utilisant le nœud d'indice 20 comme point de départ. Le coût de la tournée associé à cette image est de 12 542 324.
"""

# ╔═╡ ee1dc320-36bc-4f3a-88cd-49c4c22f6ba4
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-1.png")

# ╔═╡ f614c369-cb24-4f17-ab95-f82ffc7ec763
md"""
##### 1. Image Originale
"""

# ╔═╡ 3de3b725-1850-41c1-9526-cf28843ed6a6
load("/Users/mouhtal/Desktop/original/alaska-railroad.png")

# ╔═╡ 3de52925-502f-422e-b2ed-59c4d92286fd
md"""
##### 2. Image reconstruite avec RSL en utilisant le nœud d'indice 140 comme point de départ. Le coût de la tournée associé à cette image est de 7 862 204.
"""

# ╔═╡ b455b817-e721-4429-a9a2-b72602469ba4
load("/Users/mouhtal/Desktop/Images_Phase_5/finale-rsl-2.png")

# ╔═╡ 2c4400f8-40a7-42ac-b571-800f81398b08
md"""
##### 3. Image reconstruite avec RSL mis à l'échelle. Le coût de la tournée associé à cette image est de 7 803 332.
"""

# ╔═╡ 9b15b108-b970-4118-854d-a75760f5d0b1
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-2.png")

# ╔═╡ 94d73b98-1b50-49ad-aa24-61d9ad20c66d
md"""
##### 4. Image reconstruite avec hk en utilisant le nœud d'indice 140 comme point de départ. Le coût de la tournée associé à cette image est de 7 944 258.
"""

# ╔═╡ 7eb0718c-9334-486a-b490-501237eef89d
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-2.png")

# ╔═╡ b0155e8c-2cf7-4704-894a-a5baa8d60e70
md"""
##### 1. Image Originale
"""

# ╔═╡ d5f692f9-16b3-4baa-bf10-195b4b704ae9
load("/Users/mouhtal/Desktop/original/lower-kananaskis-lake.png")

# ╔═╡ 60996139-f3d3-4c25-a37a-585549d83ea9
md"""
##### 2. Image reconstruite avec RSL en utilisant le nœud d'indice 500 comme point de départ. Le coût de la tournée associé à cette image est de 4 310 694.
"""

# ╔═╡ 60e82982-4c47-4482-8f48-8606f72c5b69
load("/Users/mouhtal/Desktop/Images_Phase_5/finale-rsl-3.png")

# ╔═╡ 19ccf5cc-79db-4fc7-a587-66cfdc5ca133
md"""
##### 3. Image reconstruite avec RSL mis à l'échelle. Le coût de la tournée associé à cette image est de 4 305 324.
"""

# ╔═╡ 484954e4-3e4f-410a-8abe-8f9b72a9fbcd
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-3.png")

# ╔═╡ 6ad74bef-221f-42d6-a444-d75383c50593
md"""
##### 4. Image reconstruite avec hk en utilisant le nœud d'indice 200 comme point de départ. Le coût de la tournée associé à cette image est de 4 372 930.
"""

# ╔═╡ 48228c91-e447-453c-bdc1-11715078b5ca
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-3.png")

# ╔═╡ 0e1aee8f-d6e6-47d4-8384-9261698b1dab
md"""
##### 1. Image Originale
"""

# ╔═╡ 827adec8-f093-4c16-8fdb-e5fe827a52d9
load("/Users/mouhtal/Desktop/original/marlet2-radio-board.png")

# ╔═╡ 74b12b0a-394b-452f-9515-ffeaf867ba8b
md"""
##### 2. Image reconstruite avec RSL en utilisant le nœud d'indice 500 comme point de départ. Le coût de la tournée associé à cette image est de 9 113 210.
"""

# ╔═╡ c31332f4-898b-4004-9943-2255e8196bcf
load("/Users/mouhtal/Desktop/Images_Phase_5/finale-rsl-4.png")

# ╔═╡ a8d91b05-8e56-44f7-bb08-88d3ce18c805
md"""
##### 3. Image reconstruite avec RSL mis à l'échelle. Le coût de la tournée associé à cette image est de 9 012 248.
"""

# ╔═╡ e0e8f879-e6cf-4ff1-8b04-954c845a615d
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-4.png")

# ╔═╡ abed41da-870e-441d-83e5-2a080b7f749a
md"""
##### 4. Image reconstruite avec hk en utilisant le nœud d'indice 500 comme point de départ. Le coût de la tournée associé à cette image est de 9 324 126.
"""

# ╔═╡ de1dea29-bfbe-431b-850a-ab2991fa6777
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-4.png")

# ╔═╡ 6dd35600-1e1f-49e3-ab6e-0e409a91eb05
md"""
##### 1. Image Originale
"""

# ╔═╡ 8c416c01-2bd9-4479-9090-b7b83bac6da4
load("/Users/mouhtal/Desktop/original/nikos-cat.png")

# ╔═╡ fb502e10-92b1-4a75-9116-eabf322a907d
md"""
##### 2. Image reconstruite avec RSL en utilisant le nœud d'indice 500 comme point de départ. Le coût de la tournée associé à cette image est de 3 162 480.
"""

# ╔═╡ fbb052f1-372a-41c6-9752-d0120ed1eb99
load("/Users/mouhtal/Desktop/Images_Phase_5/finale-rsl-5.png")

# ╔═╡ e761a5d1-5138-4f0d-8f5a-5ae0a445314e
md"""
##### 3. Image reconstruite avec RSL mis à l'échelle. Le coût de la tournée associé à cette image est de 3 128 226.
"""

# ╔═╡ 8e2fbd5e-6de2-4761-9f4d-c560cf135c67
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-5.png")

# ╔═╡ 5529f09b-f463-4f60-b8ec-2e962816bc95
md"""
##### 4. Image reconstruite avec hk en utilisant le nœud d'indice 500 comme point de départ. Le coût de la tournée associé à cette image est de 3 205 228.
"""

# ╔═╡ ebc0903e-106c-457e-b8e0-0ceefab5b3ee
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-5.png")

# ╔═╡ 17c97c11-4956-4954-90b2-3ae578bf7464
md"""
##### 1. Image Originale
"""

# ╔═╡ 1e546240-8abd-4f5c-9c54-3798fa2e381c
load("/Users/mouhtal/Desktop/original/pizza-food-wallpaper.png")

# ╔═╡ aba6f647-138b-46e6-bdf4-3966ccacc273
md"""
##### 2. Image reconstruite avec RSL en utilisant le nœud d'indice 240 comme point de départ. Le coût de la tournée associé à cette image est de 5 212 072.
"""

# ╔═╡ 11f0dd98-21ea-4052-b704-2338e776e0d2
load("/Users/mouhtal/Desktop/Images_Phase_5/finale-rsl-6.png")

# ╔═╡ f80f164d-6098-4ecf-919f-df95fff515e5
md"""
##### 3. Image reconstruite avec RSL mis à l'échelle. Le coût de la tournée associé à cette image est de 5 132 292.
"""

# ╔═╡ bc1ea258-afc5-4eaa-b13f-0d71975f3368
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-6.png")

# ╔═╡ d6a81f7a-92f4-4ba2-a4f9-b899b54ebce3
md"""
##### 4. Image reconstruite avec hk en utilisant le nœud d'indice 240 comme point de départ. Le coût de la tournée associé à cette image est de 5 288 812.
"""

# ╔═╡ b732dd61-0bdf-4df3-99fb-dbec9dbee39f
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-6.png")

# ╔═╡ 4ce0dcb5-9d5d-4350-a91d-d2f97da3da9e
md"""
##### 1. Image Originale
"""

# ╔═╡ 3ec30119-c524-4465-8be9-aa0a4936bf61
load("/Users/mouhtal/Desktop/original/the-enchanted-garden.png")

# ╔═╡ 4950c5e8-36d3-4e00-926f-5c5edec324d1
md"""
##### 2. Image reconstruite avec RSL en utilisant le nœud d'indice 120 comme point de départ. Le coût de la tournée associé à cette image est de 20 059 414.
"""

# ╔═╡ ab220787-6e86-44d6-bb4e-867efcb13a87
load("/Users/mouhtal/Desktop/Images_Phase_5/finale-rsl-7.png")

# ╔═╡ f0434fd2-1c61-4f84-81f5-f8d94484bbf9
md"""
##### 3. Image reconstruite avec RSL mis à l'échelle. Le coût de la tournée associé à cette image est de 20 024 766.
"""

# ╔═╡ abc780ff-99d0-46fb-a66b-ecbf8b952626
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-7.png")

# ╔═╡ db0a55fd-3a9e-4dc5-89eb-dd51cda18634
md"""
##### 4. Image reconstruite avec hk en utilisant le nœud d'indice 120 comme point de départ. Le coût de la tournée associé à cette image est de 20 082 482.
"""

# ╔═╡ 1140218d-2f55-41e1-be11-12c8cefae66e
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-7.png")

# ╔═╡ f3f6136a-c549-4654-805a-886c0748eff7
md"""
##### 1. Image Originale
"""

# ╔═╡ 8a05d45b-2fac-4f8f-ad0d-82bd4abaf067
load("/Users/mouhtal/Desktop/original/tokyo-skytree-aerial.png")

# ╔═╡ b247bae8-7a3a-461d-8e0d-c16665dc3f23
md"""
##### 2. Image reconstruite avec RSL en utilisant le nœud d'indice 120 comme point de départ. Le coût de la tournée associé à cette image est de 13 701 406.
"""

# ╔═╡ c0d2dbbf-630b-4dbd-9908-3806624028b0
load("/Users/mouhtal/Desktop/Images_Phase_5/finale-rsl-8.png")

# ╔═╡ 002e4f43-3f91-4793-91cb-31de3dd010b1
md"""
##### 3. Image reconstruite avec RSL mis à l'échelle. Le coût de la tournée associé à cette image est de 13 678 236.
"""

# ╔═╡ 7af7a583-292b-4e96-bb86-c65d77a1cbcb
load("/Users/mouhtal/Desktop/Images_phase_5_rsl/finale-tuning-8.png")

# ╔═╡ c8c7ef4f-1682-4a83-8225-69b49489ddd1
md"""
##### 4. Image reconstruite avec hk en utilisant le nœud d'indice 120 comme point de départ. Le coût de la tournée associé à cette image est de 13 687 112.
"""

# ╔═╡ a57d9c48-6e78-412f-b1a5-abbf7b160909
load("/Users/mouhtal/Desktop/Images_Phase_5_hk/finale-hk-8.png")

# ╔═╡ 0d6f2186-be56-46a3-a8e6-c7bab394899a
md"""
##### 1. Conclusions
"""

# ╔═╡ f9fa852b-6f58-4c14-8cb7-632c146e540e
md"""
On remarque que l'algorithme RSL, mis à l'échelle, produit toujours les meilleurs résultats et, dans la plupart des cas, génère l'image exacte. Par ailleurs, l'algorithme HK produit des images proches des images originales, mais reste le solveur donnant les résultats les moins satisfaisants. Cela peut être justifié par le choix non optimal des paramètres dont il dépend (choix fixé de $\epsilon = 0.5$). Un tel ajustement (fine-tuning) nécessite beaucoup de temps pour être exécuté.
"""

# ╔═╡ Cell order:
# ╟─921bdba9-039b-43bc-91d2-ca9ada6d2192
# ╟─913f4fe8-01ca-4a56-9887-fc872a685cb7
# ╟─83a09239-1b5f-4a8a-9bfb-bfdb75954057
# ╟─589d44c1-2db0-4c57-8e2e-5e948e829266
# ╟─6ae59a3a-e9f1-48eb-b8e5-0623192eee18
# ╟─d167e63f-7c8e-47f2-95df-e1e744c1c2fe
# ╟─2e6c6027-badd-4e01-b60f-537ada8584df
# ╟─21c42fb7-de12-434c-a803-9c857c2acab4
# ╟─519165a1-bb36-4c07-8ae7-d434b1d43918
# ╟─19af25d4-9b07-4e27-9c4b-3e4d7524ad02
# ╟─07b05913-0271-4558-8ddb-7c7f6f6bb009
# ╟─5a203496-f9a1-4f63-ada9-974bd0bbacdb
# ╟─2e98cb46-cc46-4ddb-95fb-6dd388b2a397
# ╟─59ab3702-0bc7-4058-8341-57c5690fbd78
# ╟─c29b7e8d-e090-41c7-b8ea-52882dc6fda5
# ╟─b3610af2-96a1-4068-8221-fe193aa1affc
# ╟─61a04b84-efc9-44a4-aeb6-d31d897396f7
# ╟─6c298576-3b67-42e8-a3ce-3a11635e99ee
# ╟─6037f6ce-f661-4460-b6bc-8413767fb697
# ╟─dd53c867-5d7e-4ab6-92b6-959ff7735a15
# ╟─f537d5c9-8dff-4b09-96f3-437f1dc864e7
# ╟─49781e04-ceec-4279-95a8-98643c3ec8ec
# ╟─77ecdf5c-0826-4612-8c8a-a505df909450
# ╟─1b0137c3-0db1-4fec-869f-cd5fc4fe1aca
# ╟─d9f9ac63-7f95-48ce-bf94-d373ac1aa174
# ╟─548df163-c328-4c27-a87b-e6edfe61d944
# ╟─3b0d0c22-1e8e-41a3-8a1b-4f9f19b36250
# ╟─2dacd5a1-1699-4529-b463-2da65d019ff0
# ╟─39fbd867-dd71-4095-a068-aa57b2ad8167
# ╟─3aee7c91-9019-4e6e-b646-1c36badf0f00
# ╟─2dacd6e7-f271-4fe5-b339-56b5233dc460
# ╟─cf74df7d-fc8a-488b-94c9-6e747f047dab
# ╟─dbbe9c3b-6837-4931-8ae4-475c8d4411f4
# ╟─c2fdf96e-2c65-4d15-af2b-50571d926062
# ╟─ee1dc320-36bc-4f3a-88cd-49c4c22f6ba4
# ╟─f614c369-cb24-4f17-ab95-f82ffc7ec763
# ╟─3de3b725-1850-41c1-9526-cf28843ed6a6
# ╟─3de52925-502f-422e-b2ed-59c4d92286fd
# ╟─b455b817-e721-4429-a9a2-b72602469ba4
# ╟─2c4400f8-40a7-42ac-b571-800f81398b08
# ╟─9b15b108-b970-4118-854d-a75760f5d0b1
# ╟─94d73b98-1b50-49ad-aa24-61d9ad20c66d
# ╟─7eb0718c-9334-486a-b490-501237eef89d
# ╟─b0155e8c-2cf7-4704-894a-a5baa8d60e70
# ╟─d5f692f9-16b3-4baa-bf10-195b4b704ae9
# ╟─60996139-f3d3-4c25-a37a-585549d83ea9
# ╟─60e82982-4c47-4482-8f48-8606f72c5b69
# ╟─19ccf5cc-79db-4fc7-a587-66cfdc5ca133
# ╟─484954e4-3e4f-410a-8abe-8f9b72a9fbcd
# ╟─6ad74bef-221f-42d6-a444-d75383c50593
# ╟─48228c91-e447-453c-bdc1-11715078b5ca
# ╟─0e1aee8f-d6e6-47d4-8384-9261698b1dab
# ╟─827adec8-f093-4c16-8fdb-e5fe827a52d9
# ╟─74b12b0a-394b-452f-9515-ffeaf867ba8b
# ╟─c31332f4-898b-4004-9943-2255e8196bcf
# ╟─a8d91b05-8e56-44f7-bb08-88d3ce18c805
# ╟─e0e8f879-e6cf-4ff1-8b04-954c845a615d
# ╟─abed41da-870e-441d-83e5-2a080b7f749a
# ╟─de1dea29-bfbe-431b-850a-ab2991fa6777
# ╟─6dd35600-1e1f-49e3-ab6e-0e409a91eb05
# ╟─8c416c01-2bd9-4479-9090-b7b83bac6da4
# ╟─fb502e10-92b1-4a75-9116-eabf322a907d
# ╟─fbb052f1-372a-41c6-9752-d0120ed1eb99
# ╟─e761a5d1-5138-4f0d-8f5a-5ae0a445314e
# ╟─8e2fbd5e-6de2-4761-9f4d-c560cf135c67
# ╟─5529f09b-f463-4f60-b8ec-2e962816bc95
# ╟─ebc0903e-106c-457e-b8e0-0ceefab5b3ee
# ╟─17c97c11-4956-4954-90b2-3ae578bf7464
# ╟─1e546240-8abd-4f5c-9c54-3798fa2e381c
# ╟─aba6f647-138b-46e6-bdf4-3966ccacc273
# ╟─11f0dd98-21ea-4052-b704-2338e776e0d2
# ╟─f80f164d-6098-4ecf-919f-df95fff515e5
# ╟─bc1ea258-afc5-4eaa-b13f-0d71975f3368
# ╟─d6a81f7a-92f4-4ba2-a4f9-b899b54ebce3
# ╟─b732dd61-0bdf-4df3-99fb-dbec9dbee39f
# ╟─4ce0dcb5-9d5d-4350-a91d-d2f97da3da9e
# ╟─3ec30119-c524-4465-8be9-aa0a4936bf61
# ╟─4950c5e8-36d3-4e00-926f-5c5edec324d1
# ╟─ab220787-6e86-44d6-bb4e-867efcb13a87
# ╟─f0434fd2-1c61-4f84-81f5-f8d94484bbf9
# ╟─abc780ff-99d0-46fb-a66b-ecbf8b952626
# ╟─db0a55fd-3a9e-4dc5-89eb-dd51cda18634
# ╟─1140218d-2f55-41e1-be11-12c8cefae66e
# ╟─f3f6136a-c549-4654-805a-886c0748eff7
# ╟─8a05d45b-2fac-4f8f-ad0d-82bd4abaf067
# ╟─b247bae8-7a3a-461d-8e0d-c16665dc3f23
# ╟─c0d2dbbf-630b-4dbd-9908-3806624028b0
# ╟─002e4f43-3f91-4793-91cb-31de3dd010b1
# ╟─7af7a583-292b-4e96-bb86-c65d77a1cbcb
# ╟─c8c7ef4f-1682-4a83-8225-69b49489ddd1
# ╟─a57d9c48-6e78-412f-b1a5-abbf7b160909
# ╟─0d6f2186-be56-46a3-a8e6-c7bab394899a
# ╟─f9fa852b-6f58-4c14-8cb7-632c146e540e