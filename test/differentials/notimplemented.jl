@testset "NotImplemented" begin
    @testset "NotImplemented" begin
        ni = ChainRulesCore.NotImplemented(
            @__MODULE__, LineNumberNode(@__LINE__, @__FILE__), "error"
        )
        ni2 = ChainRulesCore.NotImplemented(nothing, nothing, nothing)

        # supported operations (for `@scalar_rule`)
        x, y, z = rand(3)
        @test conj(ni) === ni
        @test muladd(ni, y, z) === ni
        @test muladd(ni, Zero(), z) == z
        @test muladd(ni, y, Zero()) === ni
        @test muladd(ni, Zero(), Zero()) == Zero()
        @test muladd(ni, ni2, z) === ni
        @test muladd(ni, ni2, Zero()) === ni
        @test muladd(ni, y, ni2) === ni
        @test muladd(ni, Zero(), ni2) === ni2
        @test muladd(x, ni, z) === ni
        @test muladd(Zero(), ni, z) == z
        @test muladd(x, ni, Zero()) === ni
        @test muladd(Zero(), ni, Zero()) == Zero()
        @test muladd(x, ni, ni2) === ni
        @test muladd(Zero(), ni, ni2) === ni2
        @test ni * rand() === ni
        @test ni * Zero() == Zero()
        @test Zero() * ni == Zero()
        @test dot(ni, Zero()) == Zero()
        @test dot(Zero(), ni) == Zero()
        @test ni .* rand() === ni
        @test broadcastable(ni) isa Ref{typeof(ni)}

        # unsupported operations
        E = ChainRulesCore.NotImplementedException
        @test_throws E extern(ni)
        @test_throws E +ni
        @test_throws E ni + rand()
        @test_throws E ni + Zero()
        @test_throws E ni + DoesNotExist()
        @test_throws E ni + One()
        @test_throws E ni + @thunk(x^2)
        @test_throws E rand() + ni
        @test_throws E Zero() + ni
        @test_throws E DoesNotExist() + ni
        @test_throws E One() + ni
        @test_throws E @thunk(x^2) + ni
        @test_throws E ni + ni2
        @test_throws E -ni
        @test_throws E ni - rand()
        @test_throws E ni - Zero()
        @test_throws E ni - DoesNotExist()
        @test_throws E ni - One()
        @test_throws E ni - @thunk(x^2)
        @test_throws E rand() - ni
        @test_throws E Zero() - ni
        @test_throws E DoesNotExist() - ni
        @test_throws E One() - ni
        @test_throws E @thunk(x^2) - ni
        @test_throws E ni - ni2
        @test_throws E rand() * ni
        @test_throws E DoesNotExist() * ni
        @test_throws E One() * ni
        @test_throws E @thunk(x^2) * ni
        @test_throws E ni * ni2
        @test_throws E dot(ni, rand())
        @test_throws E dot(ni, DoesNotExist())
        @test_throws E dot(ni, One())
        @test_throws E dot(ni, @thunk(x^2))
        @test_throws E dot(rand(), ni)
        @test_throws E dot(DoesNotExist(), ni)
        @test_throws E dot(One(), ni)
        @test_throws E dot(@thunk(x^2), ni)
        @test_throws E dot(ni, ni2)
        @test_throws E ni / rand()
        @test_throws E rand() / ni
        @test_throws E ni / ni2
        @test_throws E zero(ni)
        @test_throws E zero(typeof(ni))
        @test_throws E iterate(ni)
        @test_throws E iterate(ni, nothing)
        @test_throws E adjoint(ni)
        @test_throws E transpose(ni)
        @test_throws E convert(Float64, ni)
    end

    @testset "@not_implemented" begin
        ni = @not_implemented()
        @test ni isa ChainRulesCore.NotImplemented
        @test ni.mod isa Module
        @test ni.source isa LineNumberNode
        @test ni.info === nothing

        ni = @not_implemented("myerror")
        @test ni isa ChainRulesCore.NotImplemented
        @test ni.mod isa Module
        @test ni.source isa LineNumberNode
        @test ni.info == "myerror"
    end

    @testset "NotImplementedException" begin
        ex = ChainRulesCore.NotImplementedException()
        @test ex isa ChainRulesCore.NotImplementedException
        @test ex.mod === nothing
        @test ex.source === nothing
        @test ex.info === nothing

        ni = @not_implemented("not implemented")
        ex = ChainRulesCore.NotImplementedException(ni)
        @test ex isa ChainRulesCore.NotImplementedException
        @test ex.mod === ni.mod
        @test ex.source === ni.source
        @test ex.info === ni.info
    end
end
