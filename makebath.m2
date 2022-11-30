
-- Input a 5 x 10 matrix that represents a self-dual configuration
for m from 1 to 279 do(
try(
    f = "genus6curves_nov15" << "";
    data = lines get "rationalspecm2"; 
    line = data#m;
    s = separate(":", line);
    label = s#0;
    print label;
    X = matrix value s#1; 


    S = QQ[x0,x1,x2,x3,x4,x5]; 

    -- Step 0: Make the ideal of the ten points:
    IX = intersect apply(10,i->minors(2,submatrix(X,,i..i)|matrix {{x0},{x1},{x2},{x3},{x4}}));

    correctbetti = new BettiTally from {(0, {0}, 0) => 1,
                 (1, {2}, 2) => 6,
                 (2, {3}, 3) => 5,
                 (2, {4}, 4) => 5,
                 (3, {5}, 5) => 6,
                 (4, {7}, 7) => 1};

    ourbetti = betti res IX;
    try assert (ourbetti == correctbetti) else print "Wrong Betti Table";

    -- Step 1: Pick four general quadrics from IX
    J = minors(1,(gens IX)*random(ZZ^6,ZZ^4));

    -- Step 2: Compute six points in a hyperplane in P^4
    K = J:IX;

    -- Step 3: Compute the linear form \ell and two linear syzygies on the four quadrics in K
    l = first first entries submatrix((mingens K),,{0});
    TwoByFour  = transpose submatrix(gens kernel(submatrix(mingens K,,{1,2,3,4})),,{0,1});

    -- Step 4: Make a 2x3 matrix whose 2x2 minors define a twisted cubic curve
    TwoByThree = TwoByFour * random(ZZ^4,ZZ^3);

    -- Step 5: Make the ideals L and M
    L = minors(2,TwoByThree) + ideal(l);
    M = ideal submatrix(mingens(intersect(L,IX)),,{0,1,2});

    -- Step 6: Compute the ideal N of the elliptic normal curve
    N = M:L;

    -- Step 7: Compute the skewsymmetric matrix \Sigma
    A = (res N).dd_1; B = (res N).dd_2; C = (res N).dd_3;
    X = submatrix(gens kernel(A|(transpose C)),{0,1,2,3,4},{0,1,2,3,4});
    Y = submatrix(gens kernel(A|(transpose C)),{5,6,7,8,9},{0,1,2,3,4});
    Sigma = Y*inverse(X)*B;

    -- Step 8: Compute the quadric and verify the ideal of 4x4-pfaffians
    q =  first first entries mingens ideal ((gens IX) % N);
    N == pfaffians(4,Sigma);

    -- Step 9: Output the matrix+quadric representation of the ideal IX
    --Sigma;
    --q;

    -- Step 10: Lift by adding the new variable x5; V is a random skew-symmetric matrix
        qtilde = q+x5*random(1,S); U=random(ZZ^5,ZZ^5); V=promote(U-transpose(U),S);
    Sigmatilde = Sigma+x5*V;

    -- Step 11: Output the matrix+quadric representation of the ideal IC_
    -- Sigmatilde
    -- qtilde;
    curve = (pfaffians(4,Sigmatilde))+ ideal(qtilde); toString mingens curve;

    -- Verification: Check that the output is correct
    curve+ideal(x5) == IX+ideal(x5), dim curve, degree curve, betti res curve;
    sing = minors(codim(curve),jacobian(curve)) + curve; dim sing;

    f << label << ":" << toString curve << ":" << toString q << endl;
)
else print "something is wrong";
)
f << close;