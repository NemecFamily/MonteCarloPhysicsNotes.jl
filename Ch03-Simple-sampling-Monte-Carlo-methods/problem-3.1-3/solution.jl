using Distributions
using Random: AbstractRNG, MersenneTwister, default_rng

"""
    f(x::Real)

the function to be integrated.
"""
f(x::Real) = x^10 - 1

"""
    mc_hitormiss(rng::AbstractRNG, N::Int, limits::NTuple{2, Real})

integration function
"""
function mc_hitormiss(f, rng::AbstractRNG, N::Integer, (lb, ub)::NTuple{2, Real})

    hit = 0

    for i = 1:N
        x = rand(rng, Uniform(lb, ub))
        y_guess = rand(rng, Uniform(f(lb), f(ub)))
        y_guess < f(x) && (hit += 1)
    end

    @info "Hit $hit, from $N."

    return (ub-lb) * (f(ub)-f(lb)) * hit / N
end

function mc_hitormiss(f, N::Integer, (lb, ub)::NTuple{2, Real})
    mc_hitormiss(f, default_rng(), N::Integer, (lb, ub)::NTuple{2, Real})
end

function mc_importancesampling(N::Int, limits=[1., 2.])
    """
    integration function
    """
    hit = 0


end

println("Solution of integral: ",
        mc_hitormiss(f, 100000, (1., 2.)))
