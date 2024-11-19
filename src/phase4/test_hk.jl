


using Test


# Création des nœuds
n1 = Node("A", [4])
n2 = Node("B", [4])
n3 = Node("C", [4])
n4 = Node("D", [4])

# Vecteur de nœuds
N = [n1, n2, n3, n4]

# Création des arêtes
e1 = Edge("AB", 1, n1, n2)
e2 = Edge("AC", 1, n1, n3)
e3 = Edge("AD", 1, n1, n4)
e4 = Edge("BC", 11, n2, n3)
e5 = Edge("BD", 7, n2, n4)
e6 = Edge("CD", 5, n3, n4)

# Vecteur des arêtes
E = [e1, e2, e3, e4, e5, e6]

# Création du graphe complet
G1 = Graph("small", N, E)

# Création d'une arbre à partir de N
E1 = [e1, e2, e3]

# Création de l'arbre
Tree = Graph("tree", N, E1)

# Tester la fonction `parcours_preordre!`
visited = Dict(node => false for node in N)
ordre = Node{Vector{Int64}}[]
parcours_preordre!(Tree, n2, visited, ordre)

@test ordre[1] == n2
@test ordre[2] == n1
@test ordre[3] == n3
@test ordre[4] == n4

# Tester la fonction `fix_tree`
T, C = fix_tree(G1, Tree, n1)
@test C == 18
T, C = fix_tree(G1, Tree, n2)
@test C == 14
T, C = fix_tree(G1, Tree, n3)
@test C == 14
T, C = fix_tree(G1, Tree, n4)
@test C == 18

# Tester `degrees`
d, v_k, p, v = degrees(G1)
@test length(d) == 4
@test length(v_k) == 4
@test p == [3, 3, 3, 3]
@test v == [1, 1, 1, 1]

# Tester `one_tree`
one_tree_result, weight = one_tree(G1, 1)
@test weight == 14  # Exemple attendu
