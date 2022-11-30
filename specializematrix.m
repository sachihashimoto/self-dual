//parallel --shuf --timeout 100 --eta -j2 magma -b seq:={} specializematrix.m ::: {1..7} >> testspec.out
//parallel --shuf --timeout 1000 --eta -j8 magma -b seq:={} specializematrix.m ::: {1..784} >> numberfieldspec.out
//338 744 559 751

//parallel --shuf --joblog joblogspec.txt --timeout 1000 --eta -j4 magma -b seq:={} specializematrix.m ::: {1..757} >> testall2.out
//parallel --shuf --timeout 1000 --eta -j4 magma -b seq:={} specializematrix.m ::: {1..360} >> spechyperplane.out
//parallel --shuf --timeout 5000 --eta -j30 magma -b seq:={} specializematrix.m ::: {1..123} >> spechyperplaneotherfile.out
//parallel --shuf --timeout 1000 --eta -j4 magma -b seq:={} specializematrix.m :::  843 160 146 299 281 214 182 180 240 237 4 92 233 87 235 186 42 44 324 6 316 94 212 289 231 294 287 171 222 109 229 246 291 205 263 314 103 107 113 105 201 285 153 166 190 194 30 296 14 339 118 304 244 175 226 301 36 99 242 207 210 111 283 28 34 >> spechyperplane2.out
//parallel --joblog specoct14 --shuf --timeout 5000 --eta -j30 magma -b seq:={} specializematrix.m ::: {1..495} >> specializationoct14.out


function count(l, x0)
    i := 0;
    for x in l do
        if x eq x0 then
            i +:= 1;
        end if;
    end for;
    return i;
end function;

function SanityCheck(M, bases)
    //For each minor of M, we check that only the nonbasis minors are 0
    //enough to check that we have the right number of minors 0, since we will not introduce extra nonzero minors

    minors := Minors(M, 5);
    zeros := count(minors, 0);

    if zeros eq (252 - #bases) then
        return true;
    else
        return false;
    end if;

end function;


function randrat(B)
    num := Random(1,B);
    den := Random(1,B);
    b := Random([1,-1]);
    return b*num/den;
end function;

function RandomSpecialization(freevars, Q, M, R, gb, bases)
    found := false;
    while not found do
        evalvector := [];
        for i in [1..25] do
            if i notin freevars then
                Append(~evalvector, Q.i);
            else 
                Append(~evalvector, randrat(10));
            end if;
        end for;
        newgb := [];

        for poly in gb do
            Append(~newgb, R!Evaluate(poly, evalvector));
        end for;

        for var in freevars do
            Append(~newgb, R.var - R!evalvector[var]);
        end for;

        Inew := Ideal(newgb cat gb);
        gbfinal := GroebnerBasis(Inew);
        Qnew := quo<R|Inew>;
        Mspec := ChangeRing(M, Qnew);

        if SanityCheck(Mspec, bases) then
            found := true;
        else
            found := false;
        end if;
    end while;

    eqns := [poly : poly in gbfinal |  Degree(poly) ne 1];
    l := #eqns;
    if l ne 0 then
        nfeqn := eqns[l];
    else
        nfeqn := 1;
    end if;

    return Mspec, nfeqn;
end function;

function onevar(poly)
    P := Parent(poly);
    S<t>:= PolynomialRing(Rationals());
    if poly eq P!0 then
        return S!0;
    end if;
    c, m := CoefficientsAndMonomials(poly);
    univariatepoly := &+[c[i]*t^Degree(mon) : i->mon in m];
    return univariatepoly;
end function;

function onevarmat(M)
    return [[onevar(elt) : elt in Eltseq(row)] : row in Rows(M)];
end function;

function choosefactor(factors);
    degrees := [Degree(f[1]) : f in factors];
    mindeg := Minimum(degrees);
    for f in factors do
        if Degree(f[1]) eq mindeg then
            return f[1];
        end if;
    end for;
end function;

function SpecializeOverNumberField(Mspec, nfeqn, bases)
    //Assumption: last equation is in one variable
    definingeqn := onevar(nfeqn);
    factors := Factorization(definingeqn);
    definingeqn := choosefactor(factors);
    if Degree(definingeqn) eq 1 then
        Mt := onevarmat(Mspec);
        a, b := Explode(Coefficients(definingeqn));
        return  Matrix([[Evaluate(elt, -a/b) : elt in row] : row in Mt]), 1;
    else
        K<a>:=NumberField(definingeqn);
        Mt := onevarmat(Mspec);
        return Matrix([[Evaluate(elt, a) : elt in row] : row in Mt]), definingeqn;
    end if;
end function;


function SpecializeMatrix(gb, bases)
    R := Parent(gb[1]);
    if gb  eq [1] then
        return [* [[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]] *];
    end if;
    I := Ideal(gb);
    xs := Matrix(5, 5, [R.i : i in [1..25]]);
    Id := ScalarMatrix(5,R!1);
    M := HorizontalJoin(Id, xs);
    Q := quo<R|I>;
    d, freevars := Dimension(I);

    best := 10000;
    eqnsbest := -1;
    Mbest := -1;
    for i in [1 .. 20] do // I'm feeling lucky!
        Mspec, nfeqn := RandomSpecialization(freevars, Q, M, R, gb, bases);
        if nfeqn eq 1 then 
            deg := 0;
            Mbest := Mspec;
            eqnsbest := 1;
            best := deg;
            break;
        end if;
        deg := Degree(nfeqn);
        if deg lt best then
            Mbest := Mspec;
            eqnsbest := nfeqn;
            best := deg;
        end if;
    end for;

    if deg ne 0 then
        Mspec, definingeqn := SpecializeOverNumberField(Mspec, nfeqn, bases);
        if definingeqn ne 1 then
            return [* [Eltseq(r) : r in Rows(Mspec)], definingeqn *]; 
        else 
            return [* [Eltseq(r) : r in Rows(Mspec)] *];
        end if;
    end if;

    return [* [Eltseq(r) : r in Rows(Mspec)] *];
end function;

function strip(s) return Join(Split(Join(Split(s," "),""),"\n"),""); end function;

//ratlabels := [622, 781, 306, 320, 740, 871, 316, 309, 705, 174, 190, 698, 304, 328, 858, 276, 286, 73, 395, 783, 775, 326, 99, 303, 21, 736, 101, 749, 59, 177, 288, 301, 165, 317, 773, 19, 333, 878, 313, 100, 412, 755, 102, 785, 239, 789, 691, 336, 327, 225, 732, 754, 74, 605, 601, 604, 228, 798, 927, 772, 779, 305, 308, 221, 334, 79, 158, 152, 802, 84, 753, 410, 154, 743, 936, 55, 728, 33, 282, 234, 251, 718, 614, 208, 187, 584, 61, 513, 184, 66, 36, 281, 229, 191, 684, 260, 257, 713, 771, 90, 262, 85, 920, 18, 3, 151, 2, 65, 268, 758, 730, 6, 714, 111, 4, 106, 747, 112, 256, 69, 242, 173, 271, 104, 35, 87, 232, 15, 179, 231, 44, 167, 236, 744, 270, 529, 252, 248, 204, 23, 770, 11, 209, 53, 211, 64, 864, 323, 94, 72, 265, 249, 274, 244, 696, 171, 299, 71, 57, 146, 13, 37, 277, 267, 12, 233, 136, 786, 110, 580, 283, 149, 121, 5, 210, 34, 147, 32, 123, 148, 76, 290, 14, 1, 17, 183, 195, 176, 250, 29, 224, 860, 24, 735, 181, 253, 67, 763, 238, 78, 77, 227, 52, 185, 45, 851, 132, 117, 261, 182, 46, 241, 226, 278, 8, 10, 186, 778, 264, 108, 685, 63, 42, 56, 89, 118, 863, 168, 214, 745, 105, 263, 246, 54, 547, 517, 243, 166, 235, 194, 766, 458, 297, 710, 43, 49, 787, 48, 164, 159, 237, 390, 230, 590, 269, 797, 16, 162, 70, 109, 272, 247, 60, 107, 741, 259, 768, 617, 514, 255, 733, 613, 746, 324];

if assigned seq then
    SetColumns(0);
    SetAutoColumns(false);
    seq := eval seq;
    inputs := Split(Read("temp.out"), "\n");
    line := Split(inputs[seq], ":");
    if #line eq 1 then exit; end if;
    label :=  eval line[1];
    if true then
        R<[x]> := PolynomialRing(Rationals(),25);
        selfdualgb := line[5];
        selfdualgb := eval selfdualgb;
        bases := line[2];
        bases := eval line[2];
        output := SpecializeMatrix(selfdualgb, bases);
        if output[1] eq [[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]  then
            exit;
        end if;
        output := [* label *] cat output;
        print strip(Join([Sprint(elt) : elt in output], ":"));
    end if;
    exit;
end if;
