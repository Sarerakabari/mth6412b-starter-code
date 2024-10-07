using Test

#include("graph.jl")
#include("comp_connexe.jl")
#include("node.jl")
#include("Edge.jl")
"""Test question 2"""
nodea = Node("a", nothing)
nodeb = Node("b", nothing)
nodec = Node("c", nothing)
noded = Node("d", nothing)
nodee = Node("e", nothing)
nodef = Node("f", nothing)
nodeg = Node("g", nothing)
nodeh = Node("h", nothing)
nodei = Node("i", nothing)


edgegh = Edge("nothing",1,nodeg,nodeh)
edgefg = Edge("nothing",2,nodef,nodeg)
edgeci = Edge("nothing",2,nodec,nodei)
edgeab = Edge("nothing",4,nodea,nodeb)
edgecf = Edge("nothing",4,nodec,nodef)
edgegi = Edge("nothing",6,nodeg,nodei)
edgecd = Edge("nothing",7,nodec,noded)
edgehi = Edge("nothing",7,nodeh,nodei)
edgebc = Edge("nothing",8,nodeb,nodec)
edgeah = Edge("nothing",8,nodea,nodeh)
edgede = Edge("nothing",9,noded,nodee)
edgeef = Edge("nothing",10,nodee,nodef)
edgebh = Edge("nothing",11,nodeb,nodeh)
edgedf = Edge("nothing",14,noded,nodef)

GraphClass = Graph("example", [nodea, nodeb, nodec, noded, nodee, nodef, nodeg, nodeh,
nodei], [edgegh, edgefg, edgeci, edgeab, edgecf, edgegi, edgecd, edgehi, edgebc, edgeah, edgede,
edgeef, edgebh, edgedf])


show(GraphClass)
println()
mst = kruskal(GraphClass)
println()
show(mst)
println()

