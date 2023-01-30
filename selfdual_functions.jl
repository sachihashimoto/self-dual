using Oscar;
#Generate a point in the Grassmannian in Pluecker coordinates from Matrix
function make_Pluecker(M::MatElem)
    n = ncols(M);
    k = Int(n//2);
    Pl= bases(uniform_matroid(k,n));
    Coor = []
    for v in Pl
        append!(Coor,[det(M[:,v])])
    end
    return Coor
end

#Generate the image of the Pluecker coordinates v under the Hodgestar map of the Grassmannian Gr(k/2,k)
function hodge_star(v::Vector,k::Int)
    dualpluecker = []
    n = length(v)
    Pl2 = bases(uniform_matroid(Int(k//2),k))
    for i in 1:n
       append!(dualpluecker,[sign(perm(vcat(Pl2[n-i+1],Pl2[i])))*v[n-i+1]])
    end 
    return dualpluecker 
end

function torusaction(l::Vector,n::Int)
    Pl2 = bases(uniform_matroid(n,2*n));
    H = []
    for i in 1:length(Pl2)
        help =1
        for j in Pl2[i]
            help = help*l[j]
        end
        append!(H,[help])
    end
    return H
end

#Test whether two vectors give the same projective point.
function is_proj_equal(A::Vector,B::Vector)
boo = true
for i in 1:70
 if B[i]!=0
        boo = boo&& B[i]//A[i] ==B[1]//A[1]
    end
end
return boo
end 

#Tests whether a point in Pluecker coordinates is contained in the open part of the Grassmannian
function in_openpart(P::Vector)
    boo = true
    for i in 1:length(P)
        boo = boo && P[i]!=0
    end
    return boo
end


#To compute the space of lambdas satisfying the self-duality condition for a given point configuration
#If the output does contain a vector with all entries nonzero, the point configuration is self-dual
#only works over QQ
function selfduality_condition(M::MatElem)
    n = ncols(M);
    @assert(2*nrows(M)== n);
    RR, l = PolynomialRing(QQ, n)
    D = zero_matrix(RR, n,n)
    for i in 1:n
        D[i,i] = l[i]
    end
    X = M*D*transpose(M)
    I = ideal(RR, [X[i,j] for i in 1:Int(n//2) for j in 1:Int(n//2) ])
    gens = groebner_basis(I)
    if gens == [1]
        error("groeberbases equals 1")
    end
    b = [ [if j==i 1 else 0 end for j in 1:n] for i in 1:n]
    Solve = matrix(QQ,length(gens),n,[evaluate(gens[i],b[j]) for i in 1:length(gens) for j in 1:n])
    return kernel(Solve)
end

###To get a diagonal matrix from a vector such that the diagonal entries of the matrix are the entries of the vector.
function diagonal_matrix(v::Vector{fmpq})
    n = length(v)
    D = zero_matrix(QQ,n,n)
    for i in 1:n
        D[i,i] = v[i]
    end
    return D
end

