using Base.Broadcast: broadcastable
using BenchmarkTools
using ChainRulesCore
using LinearAlgebra: Diagonal, dot
using FiniteDifferences
using Test

@testset "ChainRulesCore" begin
    @testset "differentials" begin
        include("differentials/abstract_zero.jl")
        include("differentials/one.jl")
        include("differentials/thunks.jl")
        include("differentials/composite.jl")
    end

    include("ruleset_loading.jl")
    include("rules.jl")
    include("rule_definition_tools.jl")


    @testset "demos" begin
        include("demos/forwarddiffzero.jl")
        include("demos/reversediffzero.jl")
    end
end
