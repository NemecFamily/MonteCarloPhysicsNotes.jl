using Random: default_rng
using Random
using Distributions

_checkN(n) = n ≥ 1 || throw(ArgumentError("number of samples ($N) must be ≥ 1"))

"""
    hit_miss(f, [rng=GLOBAL_RNG], (lbx, ubx), (lby, uby), N::Integer)

integrate function `f` with the 'hit or miss' method, sampling from the rectangle
bounded by `lbx`, `ubx`, `lby`, and `uby` `N` times using optional rng `rng`.
"""
function hit_miss(f, rng::AbstractRNG, (lbx, ubx), (lby, uby), N::Integer)
    _checkN(N)
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
    _checkN(N)
    return N \ sum(1:N) do i
        x = rand(rng, d)
        f(x) / pdf(d, x)
    end
end

importance(f, (lbx, ubx), d::UnivariateDistribution, N::Integer) =
    importance(f, default_rng(), (lbx, ubx), d, N)


## Solutions ##

f(x) = x^10 - 1
g(x) = 11 \ x^11 - x
a = 1.0; b = 2.0

N = 10_000_000

println("Integrating x^10 - 1 from 1 to 2")
@show g(b) - g(a)
@show hit_miss(  f, (a, b),               (0, f(b)), N)
@show importance(f, (a, b), TriangularDist(a, b, b), N)

println()

h(x) = sqrt(1 - x^2)
c = 0; d = 1

println("Estimating pi")
@show Float64(π)
@show 4 * hit_miss(  h, (c, d),                  (0, 1), N)
@show 4 * importance(h, (c, d), TriangularDist(c, d, c), N)
