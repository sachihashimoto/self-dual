//parallel --shuf --timeout 36000 --joblog oct17 --eta -j40 magma -b seq:={} hyperplanewithspecialize.m ::: 97 938 220 302 321 342 363 397 406 409 492 624 632 750 752 803 804 806 810 811 812 814 816 817 818 821 823 824 830 831 832 834 835 837 839 841 842 845 846 847 848 849 850 852 854 855 856 859 861 865 866 868 869 870 872 875 879 880 881 882 885 887 888 890 891 892 893 894 895 896 897 899 900 901 902 903 904 905 906 907 909 911 914 915 916 919 921 923 924 926 930 937 943 944 945 946 947 948 949 950 951 952 953 954 955 956 957 958 959 960 961 962 963 964 966 967 968 969 970 971 972 973 974 975 976 977 980 981 982 983 984 985 986 987 988 989 991 994 995 996 997 998 999 1001 1004 1005 1006 1007 1008 1009 1010 1011 1012 1013 1014 1015 1016 1017 1018 1019 1020 1021 1022 1023 1024 1025 1026 1027 1028 1029 1030 1031 1032 1033 1034 1035 1036 1037 1039 1040 >> hyperplanespecoct17.out
U := [[1,2,3,4,7], [5,6,8,9,10], [1,2,3,4,5], [1,2,3,4,6], [1,2,3,4,8], [1,2,3,4,9], [1,2,3,4,10], [1,2,3,5,6], [1,2,3,5,7], [1,2,3,5,8], [1,2,3,5,9], [1,2,3,5,10], [1,2,3,6,7], [1,2,3,6,8], [1,2,3,6,9], [1,2,3,6,10], [1,2,3,7,8], [1,2,3,7,9], [1,2,3,7,10], [1,2,3,8,9], [1,2,3,8,10], [1,2,3,9,10], [1,2,4,5,6], [1,2,4,5,7], [1,2,4,5,8], [1,2,4,5,9], [1,2,4,5,10], [1,2,4,6,7], [1,2,4,6,8], [1,2,4,6,9], [1,2,4,6,10], [1,2,4,7,8], [1,2,4,7,9], [1,2,4,7,10], [1,2,4,8,9], [1,2,4,8,10], [1,2,4,9,10], [1,2,5,6,7], [1,2,5,6,8], [1,2,5,6,9], [1,2,5,6,10], [1,2,5,7,8], [1,2,5,7,9], [1,2,5,7,10], [1,2,5,8,9], [1,2,5,8,10], [1,2,5,9,10], [1,2,6,7,8], [1,2,6,7,9], [1,2,6,7,10], [1,2,6,8,9], [1,2,6,8,10], [1,2,6,9,10], [1,2,7,8,9], [1,2,7,8,10], [1,2,7,9,10], [1,2,8,9,10], [1,3,4,5,6], [1,3,4,5,7], [1,3,4,5,8], [1,3,4,5,9], [1,3,4,5,10], [1,3,4,6,7], [1,3,4,6,8], [1,3,4,6,9], [1,3,4,6,10], [1,3,4,7,8], [1,3,4,7,9], [1,3,4,7,10], [1,3,4,8,9], [1,3,4,8,10], [1,3,4,9,10], [1,3,5,6,7], [1,3,5,6,8], [1,3,5,6,9], [1,3,5,6,10], [1,3,5,7,8], [1,3,5,7,9], [1,3,5,7,10], [1,3,5,8,9], [1,3,5,8,10], [1,3,5,9,10], [1,3,6,7,8], [1,3,6,7,9], [1,3,6,7,10], [1,3,6,8,9], [1,3,6,8,10], [1,3,6,9,10], [1,3,7,8,9], [1,3,7,8,10], [1,3,7,9,10], [1,3,8,9,10], [1,4,5,6,7], [1,4,5,6,8], [1,4,5,6,9], [1,4,5,6,10], [1,4,5,7,8], [1,4,5,7,9], [1,4,5,7,10], [1,4,5,8,9], [1,4,5,8,10], [1,4,5,9,10], [1,4,6,7,8], [1,4,6,7,9], [1,4,6,7,10], [1,4,6,8,9], [1,4,6,8,10], [1,4,6,9,10], [1,4,7,8,9], [1,4,7,8,10], [1,4,7,9,10], [1,4,8,9,10], [1,5,6,7,8], [1,5,6,7,9], [1,5,6,7,10], [1,5,6,8,9], [1,5,6,8,10], [1,5,6,9,10], [1,5,7,8,9], [1,5,7,8,10], [1,5,7,9,10], [1,5,8,9,10], [1,6,7,8,9], [1,6,7,8,10], [1,6,7,9,10], [1,6,8,9,10], [1,7,8,9,10], [2,3,4,5,6], [2,3,4,5,7], [2,3,4,5,8], [2,3,4,5,9], [2,3,4,5,10], [2,3,4,6,7], [2,3,4,6,8], [2,3,4,6,9], [2,3,4,6,10], [2,3,4,7,8], [2,3,4,7,9], [2,3,4,7,10], [2,3,4,8,9], [2,3,4,8,10], [2,3,4,9,10], [2,3,5,6,7], [2,3,5,6,8], [2,3,5,6,9], [2,3,5,6,10], [2,3,5,7,8], [2,3,5,7,9], [2,3,5,7,10], [2,3,5,8,9], [2,3,5,8,10], [2,3,5,9,10], [2,3,6,7,8], [2,3,6,7,9], [2,3,6,7,10], [2,3,6,8,9], [2,3,6,8,10], [2,3,6,9,10], [2,3,7,8,9], [2,3,7,8,10], [2,3,7,9,10], [2,3,8,9,10], [2,4,5,6,7], [2,4,5,6,8], [2,4,5,6,9], [2,4,5,6,10], [2,4,5,7,8], [2,4,5,7,9], [2,4,5,7,10], [2,4,5,8,9], [2,4,5,8,10], [2,4,5,9,10], [2,4,6,7,8], [2,4,6,7,9], [2,4,6,7,10], [2,4,6,8,9], [2,4,6,8,10], [2,4,6,9,10], [2,4,7,8,9], [2,4,7,8,10], [2,4,7,9,10], [2,4,8,9,10], [2,5,6,7,8], [2,5,6,7,9], [2,5,6,7,10], [2,5,6,8,9], [2,5,6,8,10], [2,5,6,9,10], [2,5,7,8,9], [2,5,7,8,10], [2,5,7,9,10], [2,5,8,9,10], [2,6,7,8,9], [2,6,7,8,10], [2,6,7,9,10], [2,6,8,9,10], [2,7,8,9,10], [3,4,5,6,7], [3,4,5,6,8], [3,4,5,6,9], [3,4,5,6,10], [3,4,5,7,8], [3,4,5,7,9], [3,4,5,7,10], [3,4,5,8,9], [3,4,5,8,10], [3,4,5,9,10], [3,4,6,7,8], [3,4,6,7,9], [3,4,6,7,10], [3,4,6,8,9], [3,4,6,8,10], [3,4,6,9,10], [3,4,7,8,9], [3,4,7,8,10], [3,4,7,9,10], [3,4,8,9,10], [3,5,6,7,8], [3,5,6,7,9], [3,5,6,7,10], [3,5,6,8,9], [3,5,6,8,10], [3,5,6,9,10], [3,5,7,8,9], [3,5,7,8,10], [3,5,7,9,10], [3,5,8,9,10], [3,6,7,8,9], [3,6,7,8,10], [3,6,7,9,10], [3,6,8,9,10], [3,7,8,9,10], [4,5,6,7,8], [4,5,6,7,9], [4,5,6,7,10], [4,5,6,8,9], [4,5,6,8,10], [4,5,6,9,10], [4,5,7,8,9], [4,5,7,8,10], [4,5,7,9,10], [4,5,8,9,10], [4,6,7,8,9], [4,6,7,8,10], [4,6,7,9,10], [4,6,8,9,10], [4,7,8,9,10], [5,6,7,8,9], [5,6,7,8,10], [5,6,7,9,10], [5,7,8,9,10], [6,7,8,9,10]];

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

function constructLambdaEqns(M, R)
    l := [R.i : i in [26 .. 35]];
    prod := M* DiagonalMatrix(l) * Transpose(M);
    leqns := [Vector(prod)[i] : i in [1 .. 25]];
    return leqns;
end function;

function strip(s) return Join(Split(Join(Split(s," "),""),"\n"),""); end function;

function reconstructminors(Isat, M, U, R)
    Q := quo<R | Isat>;
    minors := [];
    allminors:=  [ R!Determinant(Transpose(Matrix([ColumnSubmatrixRange(M, i, i): i in ind]))) : ind in U]; ; 
    for f in allminors do
        if Q!f ne Q!0 then
            Append(~minors, f);
        end if;
    end for;
    return minors;

end function;

function weightedrandom()
    n := Random(0,10);
    if n eq 2 then
        return 0;
    end if;
    return n;

end function;

function doline(input)
    //label, bases, gb, d


    R<[x]> := PolynomialRing(Rationals(), 35);
    label := eval input[1];
    bases := eval input[2];
    gb := eval input[3];
    d := eval input[4];

    xs := Matrix(5, 5, [R.i : i in [1..25]]);
    Id := ScalarMatrix(5,R!1);
    M := HorizontalJoin(Id, xs);
    nonbases :=  SetToSequence(Set(U) diff Set(bases)); 
    

    leqns := constructLambdaEqns(M,R);
    selfdualeqns := gb cat leqns;
    //now we try to cut down by some hyperplanes to reduce the complexity of the next computations?
    Isat := ideal<R|gb>;
    hyp := [];
    for j in [1 .. d-1] do
        Append(~hyp, &+[weightedrandom() * x[i] : i in [1 .. 25]]);
    end for;
    selfdualI := ideal<R|selfdualeqns cat hyp>;
    sdIsat := Saturation(selfdualI, ideal<R| &*[x[i]: i in [26 .. 35]]>);
    sdIsatelim := EliminationIdeal(sdIsat, {x[i] : i in [1 .. 25]});
    sdequalsreal := sdIsatelim eq Isat;
    if sdequalsreal then
        selfdualdim := Dimension(sdIsatelim) - 10;
        Q := quo<R | sdIsatelim>;
        Mspec := ChangeRing(M, Q);
    else
        Isdsat := sdIsatelim;
        basisminors := reconstructminors(Isat, M, U, R);
        assert #basisminors eq #bases;
        for f in basisminors do
            Isdsat := Saturation(Isdsat, f);
        end for;
        sdIsatelim := Isdsat;
        selfdualdim := Dimension(sdIsatelim) - 10;
        Q := quo<R | sdIsatelim>;
        Mspec := ChangeRing(M, Q);
        sdequalsreal := sdIsatelim eq Isat;
    end if;

    output := [* bases, gb, d, Basis(sdIsatelim), selfdualdim, sdequalsreal, [Eltseq(r) : r in Rows(Mspec)] *];
    return output;

end function;



if assigned seq then
    SetColumns(0);
    SetAutoColumns(false);
    seq := eval seq;
    inputs := Split(Read("rk5allrealizations_nov7"), "\n");
    input := Split(inputs[seq], ":");
    label := eval input[1];
    if label in [983, 1021, 1036, 1037] then
        print label;
        //label, bases, gb, d
        output := doline(input);
        output := [* label *] cat output;
        selfdualgbstr := Sprint(output[5]); //dumb
         R<[x]> := PolynomialRing(Rationals(),25);

        selfdualgb := (eval selfdualgbstr);
        bases := output[2];
        newoutput := SpecializeMatrix(selfdualgb, bases);
        if newoutput[1] eq [[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]  then
            print 0;
            exit;
        end if;
        newoutput := [* label *] cat newoutput;
            print strip(Join([Sprint(elt) : elt in newoutput], ":"));
        exit;
    end if;
end if;
