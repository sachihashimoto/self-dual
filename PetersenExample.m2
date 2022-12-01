X = matrix {{7 , -5 , -1 , -3 , -5 , 0 , 0 , 0 , 0 , 0 },
{0 , 0 , 0 , 0 , 0 , 14 , -5 , -1 , 1 , 5 },
{-3 , -3 , 0 , 0 , 0 , -9 , 12 , -1 , 0 , 5 },
{-3 , 5 , -2 , 0 , 0 , -9 , 0 , 22 , 0 , 0 },
{-3 , 5 , 1 , 1 , 0 , -9 , -5 , -1 , -3 , 5 }};
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
U = matrix {{0, 0, -1, 0, 0}, {0, 0, 0, 1, 0}, {-1, 0, 0, 0, 1}, {1, 0, 0, 1, 0}, {1, 0, 0, 1, 0}};
V=promote(U-transpose(U),S);
Sigmatilde = Sigma+x5*V;


qtilde = q+x5*(x0);

curve = (pfaffians(4,Sigmatilde))+ ideal(qtilde); 

assert (curve+ideal(x5) == IX+ideal(x5));
assert (dim curve == 2);
assert (degree curve == 10);
assert (betti res curve == correctbetti);
sing = minors(codim(curve),jacobian(curve)) + curve; 
assert (radical sing == ideal (x0,x1,x2,x3,x4,x5));

print Sigma;
print (V*x5);
print qtilde;
