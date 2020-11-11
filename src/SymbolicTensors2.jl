module SymbolicTensors2
using LinearAlgebra
using SymbolicUtils
using SymbolicUtils: istree, operation, arguments, similarterm

abstract type AbstractNVector end
abstract type AbstractTensor <: AbstractNVector end
struct NVector <: AbstractNVector
    nvec::Array
    idxs::Tuple{Int}
    metric::Array

end

abstract type AbstractContraction end
#struct Contraction <: AbstractContraction
    #A::NVector
    #B::NVector
#end

struct Contraction <: AbstractContraction
    ex :: Expr
end

SymbolicUtils.istree(x::Contraction) = x.ex.head == :call
SymbolicUtils.operation(x::Contraction) = x.ex.args[1]
SymbolicUtils.arguments(x::Contraction) = x.ex.args[2:end]
SymbolicUtils.symtype(x::Contraction) = Real # ?
SymbolicUtils.similarterm(x::Contraction, f, xs) = Contraction(:(I * I))


export Contraction
end
