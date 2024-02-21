module DrawSimpleGraphs

using Plots, SimpleGraphs, SimpleDrawing

import SimpleDrawing: newdraw, finish, draw
export newdraw, finish, draw, draw!, draw_nodes, draw_edges
export draw_labels

function draw_one_edge(a, b, c, d, hue = "black")
    draw_segment(a, b, c, d, color = hue)
end
"""
    draw_edges(G)
Draw the edges of `G`.
"""
function draw_edges(G::UG)
    xy = getxy(G)
    hue = get_line_color(G)
    for ee in elist(G)
        u, v = ee
        draw_one_edge(xy[u][1], xy[u][2], xy[v][1], xy[v][2], hue)
    end
    finish()
end

function draw_one_node(x, y, hue = "black", fill = "white", node_size = 6)
    draw_point(
        x,
        y,
        markerstrokecolor = hue,
        markercolor = fill,
        marker = node_size,
        markerstrokewidth = 1,
    )
end

"""
    draw_nodes(G)
Draw the vertices of `G`.
"""
function draw_nodes(G::UG)
    hue = get_line_color(G)
    node_size = get_vertex_size(G)
    xy = getxy(G)
    for v in vlist(G)
        x, y = xy[v]
        fill = get_vertex_color(G, v)
        draw_one_node(x, y, hue, fill, node_size)
    end
    finish()
end

"""
    draw(G)
    
Draws `G` in its current embedding.
(If `G` does not have an embedding, then it is given a circular
embedding.)

Optional second argument, `clear_first`. If set to `false` the drawing
window is not erased before drawing the graph. 
"""
function SimpleDrawing.draw(G::UG, clear_first::Bool = true)
    ensure_embed(G)
    if clear_first
        newdraw()
    end
    draw_edges(G)
    draw_nodes(G)
    finish()
end

"""
    SimpleDrawing.draw!(G::UG)

Draw the graph `G` but do not erase the screen first. Equivalent 
to `draw(G,false)`.
"""
SimpleDrawing.draw!(G::UG) = draw(G, false)



function draw_labels(G::UG, fontsize = 8)
    ensure_embed(G)
    xy = getxy(G)
    for v in G.V
        x, y = xy[v]
        annotate!((x, y, string(v), fontsize))
    end
    finish()
end


include("KnightTourDrawing.jl")

end  # end of module DrawSimpleGraphs
