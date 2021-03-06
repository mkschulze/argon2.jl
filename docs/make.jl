using argon2
using Documenter

DocMeta.setdocmeta!(argon2, :DocTestSetup, :(using argon2); recursive=true)

makedocs(;
    modules=[argon2],
    authors="M. Schulze",
    repo="https://github.com/mkschulze/argon2.jl/blob/{commit}{path}#{line}",
    sitename="argon2.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://mkschulze.github.io/argon2.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/mkschulze/argon2.jl",
)
