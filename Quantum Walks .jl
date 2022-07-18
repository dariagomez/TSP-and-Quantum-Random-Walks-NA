#Hamiltoniano -> energía total del sistema. 
#H = T + V (Total movement)
# H = -1/2 d^{2}/d^{2}

#Laplacian

#N/2 +- Root(N)
#Quantum walk on a line 


using LinearAlgebra, Plots

#Laplacian para hexágono

L = 2*diagm(ones(6))

for k = 1:5
    L[k, k+1] = -1
    L[k+1, k] = -1
end

L[1, 6] = -1
L[6, 1] = -1
#Extensión del Laplaciano

U(t) = exp(-1im*t*L)

function basis(n)
    v = zeros(6)
    v[n] = 1
    return v
end

function getProba(initialPosition, finalPosition, tempo)
    amp = basis(finalPosition)'*U(tempo)*basis(initialPosition)
    prob = norm(amp)^(2)
    return prob 
end 

getProba(1, 4, 1)

getProba(1, 6, 2)

getProba(4, 6, 24)

#Laplacian para matriz de nxn

function getLaplacian(nPoints::Int)
    L = 2*diagm(ones(nPoints))
    L += -1 * diagm(1 => ones(nPoints -1))
    L += -1 * diagm(-1 => ones(nPoints -1))
    L[1, end] = -1
    L[end, 1] = -1
    return L
end

#Unitario para matriz de nxn

function getUnitary(tempo, Laplacian)
    U(t) = exp(-1im*tempo*Laplacian)
    return U
end

function basis(k,nPoints)
    v = zeros(nPoints)
    v[k] = 1
    return v
end

#Probabilidad Quantum Random Walk, para Laplacian nxn (n ciudades)

function getProbability(initialPosition, finalPosition, Laplacian, tempo)
    L = Laplacian
    nPoints = size(L)[1]
    amplitude = basis(finalPosition,nPoints)'*getUnitary(tempo,Laplacian)*basis(initialPosition,nPoints)
    prob = norm(amplitude)^2
    return prob
end
