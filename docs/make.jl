using Documenter, MonteCarloPhysicsNotes


makedocs(
    sitename = "MonteCarloPhysicsNotes.jl",
    modules = [MonteCarloPhysicsNotes],
    pages = [
        "Home" => "index.md"
    ],
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    )
)

deploydocs(repo = "github.com/NemecFamily/MonteCarloPhysicsNotes.jl.git")
