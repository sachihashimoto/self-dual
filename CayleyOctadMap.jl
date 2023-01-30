#needs functions from selfdual_functions.jl
include("selfdual_functions.jl")
#Generates the unique 8th point that completes a set of 7 points in generic position to a Cayley Octad
function cayley_eighth_point(M::MatElem)
    q1 = [M[i,6] for i in 1:4];
    q2 = [M[i,7] for i in 1:4]
    a = vcat(q1,q2);
    RR = FractionField(base_ring(M))
    a8 = (a[2] * a[7] - a[2] * a[8] - a[3] * a[6] + a[3] * a[8] + a[4] * a[6] - a[4] * a[7]) //
     (a[2] * a[3] * a[6] * a[8] - a[2] * a[3] * a[7] * a[8] - a[2] * a[4] * a[6] * a[7] + a[2] * a[4] * a[7] * a[8] + a[3] * a[4] * a[6] * a[7] - a[3] * a[4] * a[6] * a[8]);
    b8 = (a[1] * a[7] - a[1] * a[8] - a[3] * a[5] + a[3] * a[8] + a[4] * a[5] - a[4] * a[7]) //
     (a[1] * a[3] * a[5] * a[8] - a[1] * a[3] * a[7] * a[8] - a[1] * a[4] * a[5] * a[7] + a[1] * a[4] * a[7] * a[8] + a[3] * a[4] * a[5] * a[7] - a[3] * a[4] * a[5] * a[8]);
    c8 = (a[1] * a[6] - a[1] * a[8] - a[2] * a[5] + a[2] * a[8] + a[4] * a[5] - a[4] * a[6]) //
     (a[1] * a[2] * a[5] * a[8] - a[1] * a[2] * a[6] * a[8] - a[1] * a[4] * a[5] * a[6] + a[1] * a[4] * a[6] * a[8] + a[2] * a[4] * a[5] * a[6] - a[2] * a[4] * a[5] * a[8]);
    d8 = (a[1] * a[6] - a[1] * a[7] - a[2] * a[5] + a[2] * a[7] + a[3] * a[5] - a[3] * a[6]) //
     (a[1] * a[2] * a[5] * a[7] - a[1] * a[2] * a[6] * a[7] - a[1] * a[3] * a[5] * a[6] + a[1] * a[3] * a[6] * a[7] + a[2] * a[3] * a[5] * a[6] - a[2] * a[3] * a[5] * a[7]);
    N = zero_matrix(RR,4,8)
    for i in 1:7 N[:,i] = M[:,i] end
    N[:,8] = [a8; b8; c8; d8]
    return N
end

function cayley_map1(M::MatElem)
    return make_Pluecker(cayley_eighth_point(M))
end