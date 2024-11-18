module STSP

using Plots

import Base.show

include("phase1/node.jl")
include("phase1/Edge.jl")
include("phase1/graph.jl")
include("phase1/read_stsp.jl")
include("phase1/create_graph.jl")
include("phase2/node_pointer.jl")
include("phase2/kruskal.jl")
include("phase3/node_priority.jl")
include("phase3/queue.jl")
include("phase3/prim.jl")
include("phase4/rsl.jl")
include("phase4/hk.jl")
include("phase4/fix_tree.jl")
include("phase4/degrees.jl")
include("phase4/weighted_node.jl")
include("phase4/weigth_update.jl")
include("phase4/sub_graph.jl")
include("phase4/weigth_update.jl")
include("phase4/finetuning.jl")



end # module STSP
