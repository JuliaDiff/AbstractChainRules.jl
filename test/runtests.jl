# TODO: more tests!
using Test
using ChainRulesCore
using LinearAlgebra: Diagonal
using ChainRulesCore: extern, accumulate, accumulate!, store!,
    Composite, @scalar_rule,
    Zero, One, DoesNotExist, Thunk
using Base.Broadcast: broadcastable

@testset "ChainRulesCore" begin
    @testset "differentials" begin
        include("differentials/zero.jl")
        include("differentials/does_not_exist.jl")
        include("differentials/one.jl")
        include("differentials/thunks.jl")
        include("differentials/composite.jl")
    end

    include("rules.jl")
end
