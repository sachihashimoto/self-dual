baseLL = QQ[a];
FFF = (m) -> (
result := "";
    data := lines get "nfspecm2";
    line := data#m;
    s := separate(":", line);
    label := s#0;
    nfParsed := value s#2;
    ptxParsed := value  s#1;
    LL := ring nfParsed/(nfParsed);
    
    fieldL := toField(LL);
    a := fieldL_0;

    ptconfigX := promote(matrix ptxParsed, fieldL); 

    S := fieldL(monoid [x0,x1,x2,x3,x4,x5]);
    (x0,x1,x2,x3,x4,x5) := toSequence gens S;

    -- Step 0: Make the ideal of the ten points:
    IX := intersect apply(10,i->minors(2,submatrix(ptconfigX,,i..i)|matrix {{x0},{x1},{x2},{x3},{x4}}));

    correctbetti := new BettiTally from {(0, {0}, 0) => 1,
                 (1, {2}, 2) => 6,
                 (2, {3}, 3) => 5,
                 (2, {4}, 4) => 5,
                 (3, {5}, 5) => 6,
                 (4, {7}, 7) => 1};

    ourbetti := betti res IX;
    if not (ourbetti == correctbetti) then (result = result| label | ":"|  "Wrong Betti Table"; return result);

    -- Step 1: Pick four general quadrics from IX
    J := minors(1,(gens IX)*random(ZZ^6,ZZ^4));

    -- Step 2: Compute six points in a hyperplane in P^4
    K := saturate(J,IX);

    -- Step 3: Compute the linear form \ell and two linear syzygies on the four quadrics in K
    l := first first entries submatrix((mingens K),,{0});
    TwoByFour  := transpose submatrix(gens kernel(submatrix(mingens K,,{1,2,3,4})),,{0,1});

    -- Step 4: Make a 2x3 matrix whose 2x2 minors define a twisted cubic curve
    TwoByThree := TwoByFour * random(ZZ^4,ZZ^3);

    -- Step 5: Make the ideals L and M
    L := minors(2,TwoByThree) + ideal(l);
    M := ideal submatrix(mingens(intersect(L,IX)),,{0,1,2});

    -- Step 6: Compute the ideal N of the elliptic normal curve
    N := saturate(M,L);

    -- Step 7: Compute the skewsymmetric matrix \Sigma
    A := (res N).dd_1; B := (res N).dd_2; C := (res N).dd_3;
    X := submatrix(gens kernel(A|(transpose C)),{0,1,2,3,4},{0,1,2,3,4});
    Y := submatrix(gens kernel(A|(transpose C)),{5,6,7,8,9},{0,1,2,3,4});
    Sigma := Y*inverse(X)*B;

    -- Step 8: Compute the quadric and verify the ideal of 4x4-pfaffians
    q :=  first first entries mingens ideal ((gens IX) % N);
    if not (N == pfaffians(4,Sigma)) then (result = result| "N is not pfaffians"; return result);

    -- Step 9: Output the matrix+quadric representation of the ideal IX
    --Sigma;
    --q;

    -- Step 10: Lift by adding the new variable x5; V is a random skew-symmetric matrix
    SS := QQ(monoid [x0,x1,x2,x3,x4,x5]);
    (x0,x1,x2,x3,x4,x5) = toSequence gens SS;
    r := map(S, SS);
    qtilde := q+r(x5*random(1,SS)); U:=random(ZZ^5,ZZ^5); V:=promote(U-transpose(U),S);
    Sigmatilde := Sigma+r(x5)*V;

    --S = fieldL[x0,x1,x2,x3,x4,x5];
    -- Step 11: Output the matrix+quadric representation of the ideal IC_
    -- Sigmatilde
    -- qtilde;
    curve := (pfaffians(4,Sigmatilde))+ ideal(qtilde);

    -- Verification: Check that the output is correct
    req1 :=  (curve+ideal(r(x5)) == IX+ideal(r(x5)));
    req2 := (dim curve == 2);
    req3 := (degree curve == 10);
    req4 := (betti res curve == correctbetti);

    if not (req1 and req2 and req3 and req4) then (result = result | label | "something went wrong"; return result);

    sing := minors(codim(curve),jacobian(curve), Strategy => Cofactor) + curve; 
    if not (saturate sing == ideal(r(1))) then (result = result | label | " is singular"; return result);
    result =  result| label | ":" | toString Sigmatilde | ":" | toString qtilde;
    return result;
)




