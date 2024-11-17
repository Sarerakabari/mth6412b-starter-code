include("../phase1/main.jl")
include("../phase3/node_priority.jl")
include("../phase3/queue.jl")
include("../phase3/prim.jl")
include("rsl.jl")
include("hk.jl")
include("finetuning.jl")
include("visualise_graph.jl")

list_eps = [1e-1,2*1e-1, 3*1e-1, 4*1e-1, 5*1e-1,6*1e-1,7*1e-1,1e-2,1e-3, 1e-4, 1e-5, 1e-6, 1e-7]

T1,C1,ID1 = finetuning_start_rsl("/Users/mouhtal/Desktop/mth6412b-starter-code-5/instances/stsp/bays29.tsp")
T2,C2,ID2 = finetuning_start_hk("/Users/mouhtal/Desktop/mth6412b-starter-code-5/instances/stsp/bays29.tsp", 6*1e-1)
T3,C3,EPS = finetuning_epsilon_hk("/Users/mouhtal/Desktop/mth6412b-starter-code-5/instances/stsp/bays29.tsp", 2,list_eps)

println(C1)
println(C2)
println(C3)