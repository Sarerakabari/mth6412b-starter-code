include("../phase1/main.jl")
include("../phase3/node_priority.jl")
include("../phase3/queue.jl")
include("../phase3/prim.jl")
include("rsl.jl")
include("hk.jl")
include("finetuning.jl")
include("visualise_graph.jl")

list_eps = [1e-1,2*1e-1, 3*1e-1, 4*1e-1, 5*1e-1,6*1e-1,7*1e-1, 8*1e-1, 9*1e-1,1e-2,1e-3, 1e-4, 1e-5, 1e-6, 1e-7]


""" Afiichage des résultats """
function main(filename::String, finetunning::String)

    if finetunning == "start_rsl"
        T, C, ID =  finetuning_start_rsl(filename)
        println("Le coût de la tournée est : ", C)
        println("La tournée est composée par :")
        show(T)
        visualize_graph(T.Nodes,T.Edges)

    elseif finetunning == "start_hk"
        T, C, ID =  finetuning_start_hk(filename, 1e-1)
        println("Le coût de la tournée est :  ", C)
        println("La tournée est composée par:")
        show(T)
        visualize_graph(T.Nodes,T.Edges)
    elseif finetunning == "epsilon_hk"
        T, C, EPS =  finetuning_epsilon_hk(filename,1,list_eps)
        println("Le coût de la tournée est :  ", C)
        println("La tournée est composée par:")
        show(T)
        visualize_graph(T.Nodes,T.Edges)
    else finetunning == "start_epsilon_hk"
        T, C, ID =  finetuning_start_epsilon_hk(filename,list_eps)
        println("Le coût de la tournée est :  ", C)
        println("La tournée est composée par:")
        show(T)
        visualize_graph(T.Nodes,T.Edges)
    end

end


main("/Users/mouhtal/Desktop/mth6412b-starter-code-5/instances/stsp/bayg29.tsp", "start_hk")