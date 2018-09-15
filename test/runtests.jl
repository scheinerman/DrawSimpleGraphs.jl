using DrawSimpleGraphs, SimpleGraphs
using Test
G = RandomTree(12)
draw(G)
@test 1==1
