using Random: default_rng
using Random
using Distributions


"""
    hit_miss(f, [rng=GLOBAL_RNG], (lbx, ubx), (lby, uby), N::Integer)

integrate function `f` with the 'hit or miss' method, sampling from the rectangle
bounded by `lbx`, `ubx`, `lby`, and `uby` `N` times using optional rng `rng`.
"""
function hit_miss(f, rng::AbstractRNG, (lbx, ubx), (lby, uby), N::Integer)
    N ≥ 1 || throw(ArgumentError("number of samples ($N) must be ≥ 1"))

    Nhits = 0
    for i in 1:N
        x = rand(rng, Uniform(lbx, ubx))
        y = rand(rng, Uniform(lby, uby))
        y < f(x) && (Nhits += 1)
    end
    return Nhits / N * (ubx - lbx) * (uby - lby)
end

hit_miss(f, (lbx, ubx), (lby, uby), N::Integer) =
    hit_miss(f, default_rng(), (lbx, ubx), (lby, uby), N)

"""
    importance(f, [rng=GLOBAL_RNG], (lbx, ubx), d::UnivariateDistribution, N::Integer)

integrate function `f` with the importance sampling method between `lbx` and `ubx`, sampling
from distribution `d` `N` times using optional rng `rng`.
"""
function importance(f, rng::AbstractRNG, (lbx, ubx), d::UnivariateDistribution, N::Integer)
    N ≥ 1 || throw(ArgumentError("number of samples ($N) must be ≥ 1"))

    return N \ sum(1:N) do i
        x = rand(rng, d)
        f(x) / pdf(d, x)
    end
end

importance(f, (lbx, ubx), d::UnivariateDistribution, N::Integer) =
    importance(f, default_rng(), (lbx, ubx), d, N)
