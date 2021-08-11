using SimpleGraphs, DrawSimpleGraphs

"""
    dodec_with_ham_cycle()
Create a drawing of the dodecahedron graph with black vertices, a red Hamiltonian
cycle, and a blue perfect matching.
"""
function dodec_with_ham_cycle()
    G = Dodecahedron()
    n = NV(G)

    # Create a 2nd graph that is a Hamiltonian cycle of G
    hc = hamiltonian_cycle(G)
    H = IntGraph()
    for i = 1:n-1
        add!(H, hc[i], hc[i+1])
    end
    add!(H, hc[1], hc[end])

    xy = getxy(G)
    embed(H, xy)

    set_line_color(G,:blue)
    set_line_color(H,:red)

    newdraw()       # ensure a blank canvas
    draw_edges(G)
    draw_edges(H)
    set_line_color(H,:black)
    set_vertex_color(H,:black)
    draw_nodes(H)
end
