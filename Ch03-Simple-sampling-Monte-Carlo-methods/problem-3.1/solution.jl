"""
Open questions:
    How to set the seed of the random number generator?
    Could we reformulate the function by creating a 2-dim random array with axis
    1 betwenn limit[1] and limit[2], and axis 2 random array between min and max
    of f(x=[1,2])?

"""
function f(x::Float64)::Float64
    """
    f(x::Float64)::Float64

    Define the function to be integrated
    """
    fx = x^10 - 1
    return fx
end

function mc_hitormiss(N::Int, limits=[1., 2.])
    """
    integration function
    """
    hit = 0
    for i = 1:N
        x = rand()*(limits[2]-limits[1])+limits[1]
        y_guess = rand()*(f(limits[2])-f(limits[1]))+f(limits[1])
        y = f(x)

        if y_guess < y
            hit += 1
        end
    end
    full_area = (limits[2]-limits[1]) * (f(limits[2])-f(limits[1]))

    area = full_area * hit / (N)

    println("Hit ", hit, " from ", N, ".")
    println("Solution of integral: ", area)

    return area
end

mc_hitormiss(100000, [1., 2.])
