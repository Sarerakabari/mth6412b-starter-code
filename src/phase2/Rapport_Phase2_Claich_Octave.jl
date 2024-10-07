### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 41d11a17-73b7-4da2-999d-a9ceda200969
using Markdown

# ╔═╡ 0829e03c-8bc6-4c0d-b1c2-572dd831cb1a
using InteractiveUtils

# ╔═╡ 9f427156-bc94-4877-80f9-3db6f178f274
using Logging

# ╔═╡ c8cc4922-0f3b-4c3a-b444-8045b67205c8
md"""
### Mini rapport: Phase 2 du projet
"""

# ╔═╡ 2f59b97d-e868-46bc-9945-76075015d4cc
md""" Le  code se trouve au lien suivant: """

# ╔═╡ 322e6e27-5af8-49b0-96f4-025bbf2403f4
md"""[https://github.com/oclaich/mth6412b-starter-code/tree/phase2/src/phase1](https://github.com/oclaich/mth6412b-starter-code/tree/phase2/src/phase1)"""

# ╔═╡ 063e8297-bc61-4bde-85d0-8f144185c6d3
md""" Le lecteur peut fork le projet et lancer le fichier main.jl pour retrouver les résultats ci-dessous"""

# ╔═╡ b4aac71c-7ec4-41b6-8d85-02b8c3dc742d
md"""
##### 1. Choisir et implémenter une structure de données pour les composantes connexes d’un graphe
"""

# ╔═╡ 8c4e3107-ac56-4e2a-a889-b199e7eb8547
md"""
```
abstract type AbstractConnexeElement{T} end

mutable struct ConnexeElement{T} <: AbstractConnexeElement{T}
    name::String
    parent::Node{T}
    child::Node{T}
end

abstract type AbstractCompConnexe{T} end

mutable struct CompConnexe{T} <: AbstractCompConnexe{T}
    comp::Vector{ConnexeElement}
end
```
"""

# ╔═╡ 9d8d7cfe-a427-4d19-8bed-de8a921dafe2
md"""
##### 2. Implémenter l'algorithme de Kruskal et le tester sur l'exemple des notes de cours.
"""

# ╔═╡ b63df5ba-fe18-4b68-b1b8-cc8aa46f7998
md"""
```
Fonction pour check si deux noeuds sont dans la même composante connexe.
Elle va renvoyer l'indice de la composante connexe dans laquelle se trouvent les noeuds au sein d'une liste de composantes connexes.

function check_comp_connexe(comp_connexes::CompConnexe{T}[],node1::Node{T},node2::Node{T}) where {T}

Algorithme de Kruskal, qui doit renvoyer uniquement l'ensemble des arêtes et le poids total de l'arbre de recouvrement minimal.

function  kruskal(graph::Graph{T}) where {T}
```
"""

# ╔═╡ 56190668-c0d7-4fd8-8159-2389852c4bfd
md"""
##### 3. Accompagner votre code de tests unitaires.
"""

# ╔═╡ c450bddb-9cf8-46a5-8d68-f153872cf29a
md"""
```
Les tests unitaires sont présents dans le fichier test.jl
```
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
InteractiveUtils = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "348ed7e828d2091a44e211d4df367eb5f2d0eb19"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
"""

# ╔═╡ Cell order:
# ╟─41d11a17-73b7-4da2-999d-a9ceda200969
# ╟─0829e03c-8bc6-4c0d-b1c2-572dd831cb1a
# ╟─9f427156-bc94-4877-80f9-3db6f178f274
# ╟─c8cc4922-0f3b-4c3a-b444-8045b67205c8
# ╟─2f59b97d-e868-46bc-9945-76075015d4cc
# ╟─322e6e27-5af8-49b0-96f4-025bbf2403f4
# ╟─063e8297-bc61-4bde-85d0-8f144185c6d3
# ╟─b4aac71c-7ec4-41b6-8d85-02b8c3dc742d
# ╟─8c4e3107-ac56-4e2a-a889-b199e7eb8547
# ╟─9d8d7cfe-a427-4d19-8bed-de8a921dafe2
# ╟─b63df5ba-fe18-4b68-b1b8-cc8aa46f7998
# ╟─56190668-c0d7-4fd8-8159-2389852c4bfd
# ╟─c450bddb-9cf8-46a5-8d68-f153872cf29a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
