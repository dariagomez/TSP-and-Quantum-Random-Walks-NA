using LinearAlgebra, Plots
#=
Quantum Random Walks for nPoints, on a line.
=#
function buildLaplacian(nPoints)
    L = 2*diagm(ones(nPoints))
    L += -1*diagm(1=> ones(nPoints - 1))
    L += -1*diagm(-1=> ones(nPoints - 1))
    L[1,end] = -1
    L[end,1] = -1
    return L
end #function


function getUnitary(t, Laplacian)
    L = Laplacian
    U = exp(-1im*t*L)
    return U
end

function basis(k,nPoints)
    v = zeros(nPoints)
    v[k] = 1
    return v
end

function getProbability(initialPosition, finalPosition, Laplacian, tempo)
    L = Laplacian
    nPoints = size(L)[1]
    amplitude = basis(finalPosition,nPoints)'*getUnitary(tempo,Laplacian)*basis(initialPosition,nPoints)
    prob = norm(amplitude)^2
    return prob
end

#=
Let's try a 100 vertex cycle graph
L = buildLaplacian(100)
getProbability(1,50,L,10)
=#

L = buildLaplacian(100)
getProbability(1,50,L,10)

# This plots! 
#plot(map(n -> getProbability(1,n,L,50),collect(1:100)))


#Get quantum probability for NA cities. This file is supposed to be uploaded in the GitCarpet. Change direction.
using CSV, DataFrames
df = CSV.read("C:\\Users\\daria\\OneDrive\\Desktop\\CdeC\\NA_adjacency2.csv", DataFrame)
ANA = Array(df[!, 2:end])

#Try norm, if this is zero it is ok. 
# norm(ANA - ANA')

L = ANA
getProbability(32, 57, L, 8)

plot(map(n -> getProbability(32, n, L, 1),collect(1:95)))

getProbability(32, 30, L, 40)

#Jalisco probabilities.
ts = collect(0:0.05:6);
probsJAL2IL = map(t -> getProbability(32,30,L,t), ts);
plot(ts,probsJAL2IL)

ns = collect(1:95);
#plot(map(n -> getProbability(32,n,L,0),ns))

#plot(map(n -> getProbability(32,n,L,1),ns))

#plot(map(n -> getProbability(32,n,L,2),ns))

#plot(map(n -> getProbability(32,n,L,3),ns))

#plot(map(n -> getProbability(32,n,L,4),ns))

#plot(map(n -> getProbability(32,n,L,5),ns))

#plot(map(n -> getProbability(32,n,L,6),ns))

#plot(map(n -> getProbability(32,n,L,7),ns))

#plot(map(n -> getProbability(32,n,L,8),ns))

#plot(map(n -> getProbability(32,n,L,9),ns))

#plot(map(n -> getProbability(32,n,L,10),ns))

#plot(map(n -> getProbability(32,n,L,11),ns))

#plot(map(n -> getProbability(32,n,L,12),ns))

#plot(map(n -> getProbability(32,n,L,13),ns))

#This is how I save my files

df = CSV.read("C:\\Users\\daria\\OneDrive\\Desktop\\CdeC\\NA_adjacency2.csv", DataFrame)
    ANA = Array(df[!, 2:end])
using StatsPlots
    
    ploteado = StatsPlots.plot(map(n -> getProbability(32,n,L,1),ns), title = "Quantum Random Walk Jalisco", label = "Jalisco")
    xlabel!("City number")
    ylabel!("Probability")
savefig(ploteado, "QRW1.png")
  


#This is how I save my files too. Jalisco ploteadito.
ts = collect(0:0.05:6);
probsJAL2IL = map(t -> getProbability(32,30,L,t), ts);
 ploteadito = StatsPlots.plot(ts,probsJAL2IL)
savefig(ploteadito, "Jalisco.png")

