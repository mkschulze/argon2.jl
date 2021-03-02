using Clang
using Clang_jll # `pkg> activate Clang`

# LIBCLANG_HEADERS are those headers to be wrapped.
const LIBCLANG_INCLUDE = joinpath(dirname(Clang_jll.libclang_path), "..", "include", "clang-c") |> normpath
const LIBCLANG_HEADERS = [joinpath(LIBCLANG_INCLUDE, header) for header in readdir(LIBCLANG_INCLUDE) if endswith(header, ".h")]

wc = init(; headers = LIBCLANG_HEADERS,
            output_file = joinpath(@__DIR__, "libclang_api.jl"),
            common_file = joinpath(@__DIR__, "libclang_common.jl"),
            clang_includes = vcat(LIBCLANG_INCLUDE, CLANG_INCLUDE),
            clang_args = ["-I", joinpath(LIBCLANG_INCLUDE, "..")],
            header_wrapped = (root, current)->root == current,
            header_library = x->"libclang",
            clang_diagnostics = true,
            )

run(wc)

#=

julia> using Clang

julia> using Clang.LibClang.Clang_jll

julia> # LIBCLANG_HEADERS are those headers to be wrapped.
       const LIBCLANG_INCLUDE = joinpath(dirname(Clang_jll.libclang_path), "..", "include", "clang-c") |> normpath
"/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c"

julia> const LIBCLANG_HEADERS = [joinpath(LIBCLANG_INCLUDE, header) for header in readdir(LIBCLANG_INCLUDE) if endswith(header, ".h")]
7-element Array{String,1}:
 "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/BuildSystem.h"
 "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/CXCompilationDatabase.h"
 "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/CXErrorCode.h"
 "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/CXString.h"
 "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/Documentation.h"
 "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/Index.h"
 "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/Platform.h"

julia> wc = init(; headers = LIBCLANG_HEADERS,
                   output_file = joinpath(@__DIR__, "libclang_api.jl"),
                   common_file = joinpath(@__DIR__, "libclang_common.jl"),
                   clang_includes = vcat(LIBCLANG_INCLUDE, CLANG_INCLUDE),
                   clang_args = ["-I", joinpath(LIBCLANG_INCLUDE, "..")],
                   header_wrapped = (root, current)->root == current,
                   header_library = x->"libclang",
                   clang_diagnostics = true,
                   )
WrapContext(Index(Ptr{Nothing} @0x00007ffcb984a780, 0, 1), ["/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/BuildSystem.h", "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/CXCompilationDatabase.h", "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/CXErrorCode.h", "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/CXString.h", "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/Documentation.h", "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/Index.h", "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/Platform.h"], "/Users/ulzee/dev/argon2/libclang_api.jl", "/Users/ulzee/dev/argon2/libclang_common.jl", ["/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c", "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/lib/clang/9.0.1/include"], ["-I", "/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/.."], var"#5#7"(), var"#6#8"(), Clang.var"#44#55"{String,String}("", "/Users/ulzee/dev/argon2/libclang_api.jl"), Clang.var"#50#61"(), OrderedCollections.OrderedDict{Symbol,ExprUnit}(), DataStructures.DefaultOrderedDict{String,Array{Any,N} where N,Clang.var"#45#56"}(), Clang.InternalOptions(true, false), Clang.var"#51#62"())

julia> run(wc)
/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/../clang-c/Index.h:19:10: fatal error: 'time.h' file not found
/Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/Index.h:19:10: fatal error: 'time.h' file not found
[ Info: wrapping header: /Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/BuildSystem.h ...
[ Info: writing /Users/ulzee/dev/argon2/libclang_api.jl
[ Info: wrapping header: /Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/CXCompilationDatabase.h ...
[ Info: writing /Users/ulzee/dev/argon2/libclang_api.jl
[ Info: wrapping header: /Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/CXErrorCode.h ...
[ Info: writing /Users/ulzee/dev/argon2/libclang_api.jl
[ Info: wrapping header: /Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/CXString.h ...
[ Info: writing /Users/ulzee/dev/argon2/libclang_api.jl
[ Info: wrapping header: /Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/Documentation.h ...
[ Info: writing /Users/ulzee/dev/argon2/libclang_api.jl
[ Info: wrapping header: /Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/Index.h ...
[ Info: writing /Users/ulzee/dev/argon2/libclang_api.jl
[ Info: wrapping header: /Users/ulzee/.julia/artifacts/74b247b0f53ce91c334e5a1c16a7d5d871cf8d79/include/clang-c/Platform.h ...
[ Info: writing /Users/ulzee/dev/argon2/libclang_api.jl

julia> using Clang: find_std_headers

julia> for header in find_std_headers()
           push!(clang_args, "-I"*header)
       end
ERROR: UndefVarError: clang_args not defined
Stacktrace:
 [1] top-level scope at ./REPL[13]:2

 =#