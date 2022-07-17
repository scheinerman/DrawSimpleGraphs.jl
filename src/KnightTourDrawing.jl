export KnightTourDrawing

"""
`KnightTourDrawing(r,c)` illustrates a Knight's tour of an r-by-c
chessboard. Throws an error if no such tour exists.
"""
function KnightTourDrawing(r::Int = 6, c::Int = 6)
    G = Knight(r, c)
    @info "Searching for a Hamiltonian cycle in a $r-by-$c Knight's move graph"
    @time h = hamiltonian_cycle(G)
    @info "Finished"

    if length(h) == 0
        throw(error("There is no such Knight's move tour"))
    end

    T = eltype(G)
    H = UG{T}()
    for v in G.V
        add!(H, v)
    end

    for k = 1:NV(H)-1
        add!(H, h[k], h[k+1])
    end

    add!(H, h[1], h[end])

    xy = getxy(H)

    for v in H.V
        xy[v] = collect(v)
    end

    embed(H, xy)

    draw(H)

    for a = 0:c
        plot!([0.5, r + 0.5], [a + 0.5, a + 0.5], color = "black", linestyle = :dash)
    end

    for b = 0:r
        plot!([b + 0.5, b + 0.5], [0.5, c + 0.5], color = "black", linestyle = :dash)
    end

    finish()
end
