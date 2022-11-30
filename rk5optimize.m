//parallel --shuf --timeout 36000 --eta -j40 magma -b seq:={} rk5optimize.m ::: 19 21 41 59 73 75 96 99 101 122 155 157 163 213 215 216 217 218 220 279 285 286 300 301 302 303 304 306 307 309 310 311 312 313 314 316 317 318 319 320 321 322 325 326 328 329 330 331 332 333 337 342 363 364 395 396 397 398 399 400 401 406 407 408 409 411 413 492 548 592 593 594 595 610 611 622 624 632 636 648 673 681 682 687 688 689 698 702 703 705 708 711 715 716 736 739 740 742 748 749 750 751 752 757 759 765 769 773 774 775 781 783 788 791 794 795 796 800 801 803 804 806 807 809 810 811 812 814 816 817 818 821 822 823 824 830 831 832 834 835 837 838 839 841 842 843 844 845 846 847 848 849 850 852 854 855 856 858 859 861 865 866 867 868 869 870 871 872 873 875 877 878 879 880 881 882 883 884 885 887 888 889 890 891 892 893 894 895 896 897 898 899 900 901 902 903 904 905 906 907 908 909 911 913 914 915 916 917 918 919 921 922 923 924 925 926 928 929 930 931 932 933 934 935 937 940 941 943 944 945 946 947 948 949 950 951 952 953 954 955 956 957 958 959 960 961 962 963 964 965 966 967 968 969 970 971 972 973 974 975 976 977 978 979 980 981 982 983 984 985 986 987 988 989 990 991 993 994 995 996 997 998 999 1000 1001 1002 1003 1004 1005 1006 1007 1008 1009 1010 1011 1012 1013 1014 1015 1016 1017 1018 1019 1020 1021 1022 1023 1024 1025 1026 1027 1028 1029 1030 1031 1032 1033 1034 1035 1036 1037 1039 1040 >> combosep22try2.out

U := [[1,2,3,4,7], [5,6,8,9,10], [1,2,3,4,5], [1,2,3,4,6], [1,2,3,4,8], [1,2,3,4,9], [1,2,3,4,10], [1,2,3,5,6], [1,2,3,5,7], [1,2,3,5,8], [1,2,3,5,9], [1,2,3,5,10], [1,2,3,6,7], [1,2,3,6,8], [1,2,3,6,9], [1,2,3,6,10], [1,2,3,7,8], [1,2,3,7,9], [1,2,3,7,10], [1,2,3,8,9], [1,2,3,8,10], [1,2,3,9,10], [1,2,4,5,6], [1,2,4,5,7], [1,2,4,5,8], [1,2,4,5,9], [1,2,4,5,10], [1,2,4,6,7], [1,2,4,6,8], [1,2,4,6,9], [1,2,4,6,10], [1,2,4,7,8], [1,2,4,7,9], [1,2,4,7,10], [1,2,4,8,9], [1,2,4,8,10], [1,2,4,9,10], [1,2,5,6,7], [1,2,5,6,8], [1,2,5,6,9], [1,2,5,6,10], [1,2,5,7,8], [1,2,5,7,9], [1,2,5,7,10], [1,2,5,8,9], [1,2,5,8,10], [1,2,5,9,10], [1,2,6,7,8], [1,2,6,7,9], [1,2,6,7,10], [1,2,6,8,9], [1,2,6,8,10], [1,2,6,9,10], [1,2,7,8,9], [1,2,7,8,10], [1,2,7,9,10], [1,2,8,9,10], [1,3,4,5,6], [1,3,4,5,7], [1,3,4,5,8], [1,3,4,5,9], [1,3,4,5,10], [1,3,4,6,7], [1,3,4,6,8], [1,3,4,6,9], [1,3,4,6,10], [1,3,4,7,8], [1,3,4,7,9], [1,3,4,7,10], [1,3,4,8,9], [1,3,4,8,10], [1,3,4,9,10], [1,3,5,6,7], [1,3,5,6,8], [1,3,5,6,9], [1,3,5,6,10], [1,3,5,7,8], [1,3,5,7,9], [1,3,5,7,10], [1,3,5,8,9], [1,3,5,8,10], [1,3,5,9,10], [1,3,6,7,8], [1,3,6,7,9], [1,3,6,7,10], [1,3,6,8,9], [1,3,6,8,10], [1,3,6,9,10], [1,3,7,8,9], [1,3,7,8,10], [1,3,7,9,10], [1,3,8,9,10], [1,4,5,6,7], [1,4,5,6,8], [1,4,5,6,9], [1,4,5,6,10], [1,4,5,7,8], [1,4,5,7,9], [1,4,5,7,10], [1,4,5,8,9], [1,4,5,8,10], [1,4,5,9,10], [1,4,6,7,8], [1,4,6,7,9], [1,4,6,7,10], [1,4,6,8,9], [1,4,6,8,10], [1,4,6,9,10], [1,4,7,8,9], [1,4,7,8,10], [1,4,7,9,10], [1,4,8,9,10], [1,5,6,7,8], [1,5,6,7,9], [1,5,6,7,10], [1,5,6,8,9], [1,5,6,8,10], [1,5,6,9,10], [1,5,7,8,9], [1,5,7,8,10], [1,5,7,9,10], [1,5,8,9,10], [1,6,7,8,9], [1,6,7,8,10], [1,6,7,9,10], [1,6,8,9,10], [1,7,8,9,10], [2,3,4,5,6], [2,3,4,5,7], [2,3,4,5,8], [2,3,4,5,9], [2,3,4,5,10], [2,3,4,6,7], [2,3,4,6,8], [2,3,4,6,9], [2,3,4,6,10], [2,3,4,7,8], [2,3,4,7,9], [2,3,4,7,10], [2,3,4,8,9], [2,3,4,8,10], [2,3,4,9,10], [2,3,5,6,7], [2,3,5,6,8], [2,3,5,6,9], [2,3,5,6,10], [2,3,5,7,8], [2,3,5,7,9], [2,3,5,7,10], [2,3,5,8,9], [2,3,5,8,10], [2,3,5,9,10], [2,3,6,7,8], [2,3,6,7,9], [2,3,6,7,10], [2,3,6,8,9], [2,3,6,8,10], [2,3,6,9,10], [2,3,7,8,9], [2,3,7,8,10], [2,3,7,9,10], [2,3,8,9,10], [2,4,5,6,7], [2,4,5,6,8], [2,4,5,6,9], [2,4,5,6,10], [2,4,5,7,8], [2,4,5,7,9], [2,4,5,7,10], [2,4,5,8,9], [2,4,5,8,10], [2,4,5,9,10], [2,4,6,7,8], [2,4,6,7,9], [2,4,6,7,10], [2,4,6,8,9], [2,4,6,8,10], [2,4,6,9,10], [2,4,7,8,9], [2,4,7,8,10], [2,4,7,9,10], [2,4,8,9,10], [2,5,6,7,8], [2,5,6,7,9], [2,5,6,7,10], [2,5,6,8,9], [2,5,6,8,10], [2,5,6,9,10], [2,5,7,8,9], [2,5,7,8,10], [2,5,7,9,10], [2,5,8,9,10], [2,6,7,8,9], [2,6,7,8,10], [2,6,7,9,10], [2,6,8,9,10], [2,7,8,9,10], [3,4,5,6,7], [3,4,5,6,8], [3,4,5,6,9], [3,4,5,6,10], [3,4,5,7,8], [3,4,5,7,9], [3,4,5,7,10], [3,4,5,8,9], [3,4,5,8,10], [3,4,5,9,10], [3,4,6,7,8], [3,4,6,7,9], [3,4,6,7,10], [3,4,6,8,9], [3,4,6,8,10], [3,4,6,9,10], [3,4,7,8,9], [3,4,7,8,10], [3,4,7,9,10], [3,4,8,9,10], [3,5,6,7,8], [3,5,6,7,9], [3,5,6,7,10], [3,5,6,8,9], [3,5,6,8,10], [3,5,6,9,10], [3,5,7,8,9], [3,5,7,8,10], [3,5,7,9,10], [3,5,8,9,10], [3,6,7,8,9], [3,6,7,8,10], [3,6,7,9,10], [3,6,8,9,10], [3,7,8,9,10], [4,5,6,7,8], [4,5,6,7,9], [4,5,6,7,10], [4,5,6,8,9], [4,5,6,8,10], [4,5,6,9,10], [4,5,7,8,9], [4,5,7,8,10], [4,5,7,9,10], [4,5,8,9,10], [4,6,7,8,9], [4,6,7,8,10], [4,6,7,9,10], [4,6,8,9,10], [4,7,8,9,10], [5,6,7,8,9], [5,6,7,8,10], [5,6,7,9,10], [5,7,8,9,10], [6,7,8,9,10]];

function constructMinorsUnframed(M, indices, R, b)
    bcomp := {1,2,3,4,5,6,7,8,9,10} diff Set(b);
    bcomp := SetToSequence(bcomp);
    reorder := pmap<[1,2,3,4,5,6,7,8,9,10]->[1,2,3,4,5,6,7,8,9,10] | [<b[1],1>, <b[2], 2>, <b[3], 3>, <b[4], 4>, <b[5], 5>,  <bcomp[1],6>, <bcomp[2],7>, <bcomp[3], 8>, <bcomp[4], 9>, <bcomp[5], 10> ]>;
    return [ R!Determinant(Transpose(Matrix([ColumnSubmatrixRange(M, reorder(i), reorder(i)): i in ind]))) : ind in indices]; 
end function;

function nonzeroEntries(M, minors, R)
    xs := Matrix(5, 5, [R.i : i in [1..25]]);
    nonzeroentries := [];
    for i in [1 .. 5] do
        for j in [1 .. 5] do
                if xs[j][i] notin minors and -xs[j][i] notin minors then
                    Append(~nonzeroentries, <j,i>);
            end if;
        end for;
    end for;

    return nonzeroentries;
end function;

function saturateIdeal(eqns, basisminors, R)
    Isat := ideal<R| eqns >;
    for f in basisminors do
        Isat := Saturation(Isat, f);
    end for;
    return Isat;
end function;

function constructLambdaEqns(M, R)
    l := [R.i : i in [26 .. 35]];
    prod := M* DiagonalMatrix(l) * Transpose(M);
    leqns := [Vector(prod)[i] : i in [1 .. 25]];
    return leqns;
end function;

function strip(s) return Join(Split(Join(Split(s," "),""),"\n"),""); end function;

function findpossiblecols(nonzer)
    goodcols := [];
    for i in [1 .. 5] do
        fullcol := true;
        for j in [ 1.. 5] do
            if <j, i> notin nonzer then
                fullcol := false;
                break;
            end if;
        end for;
        if fullcol then
            Append(~goodcols, i);
        end if;
    end for;
    return goodcols;
end function;

function findpossiblerows(nonzer, c)
    //remains to pick one element <j_1,1> , <j_2,1>, ..., <j_5,5> excluding <j_c,c> 
    firstindex := AssociativeArray(); //create dictionary of second indices 1: all second indices ... etc.
    for pair in nonzer do
        if IsDefined(firstindex,pair[2]) then
            Append(~firstindex[pair[2]], pair[1]);
        else 
            firstindex[pair[2]] := [pair[1]];
        end if;
    end for;

    //return all possibilities 
    res := [];
    for i1 in firstindex[1] do
        for i2 in firstindex[2] do
            for i3 in firstindex[3] do
                for i4 in firstindex[4] do
                    for i5 in firstindex[5] do
                        row := [i1, i2,  i3,  i4, i5];
                        row := [elt : i->elt in row | i ne c];
                        Append(~res, row);
                    end for;
                end for;
            end for;
        end for;
    end for;

    return res;

end function;


function evaluatexs(r, c, xs)
    evalxs := xs;
    for i in [1 .. 5] do
        evalxs[i, c] := 1;
    end for;
    for i->x in r do
        if i lt c then
            evalxs[x, i] := 1; //we skipped the one in column c
        else 
            evalxs[x, i+1] := 1;
        end if;
    end for;
    return evalxs;
end function;


function chooseOptimalOnes(xs, b, M, R, nonbases)
    nonbasisminors := constructMinorsUnframed(M, nonbases, R, b);
    nonzer := nonzeroEntries(M, nonbasisminors, R); //possible placement of ones, given the above
    //you need to choose one element in each column and row, and iterate over each choice for each b
    possiblecols := findpossiblecols(nonzer); 
    if #possiblecols eq 0 then
        return [* -1, []*];
    end if;
    for c in possiblecols do
        //now have to iterate over all possible row choices, find the best degree, then compare across all columns...
        rowchoices := findpossiblerows(nonzer, c);
        if #rowchoices eq 0 then
            return [* -1, []*];
        end if;
        for r in rowchoices do 
            evalxs := evaluatexs(r,c, xs);
            evalvector := Eltseq(evalxs); //evaluate the column and row choices to be 1
            for i in [1 .. 10] do Append(~evalvector, 0); end for; //lambda are dumb
            deg :=  &*[Degree(Evaluate(poly, evalvector)) : poly in nonbasisminors | poly ne 0];
            if not assigned(bestdeg) then
                bestdeg := deg;
                bestr := r;
            else
                if deg lt bestdeg then
                    bestdeg := deg;
                    bestr := r;
                end if;
            end if;
        end for;
        if not assigned(bestr) then
            return [* -1, []*];  //no good options
        end if;
        if not assigned(bestpair) then
            winningcdeg := bestdeg;
            bestpair := [* c, bestr *];
        else 
            if bestdeg lt winningcdeg then
                winningcdeg := bestdeg;
                bestpair := [* c, bestr *]; //choose best [c, r] after optimizing r
            end if;
        end if;
    end for;
    return bestpair;

end function;

function chooseOptimalBasis(nonbases, bases, M, R, xs)
    //returns a frame for M which gives the smallest product of degrees for the minors of the nonbases
    firsttime := true; //work around to check if we have assigned bestdeg
    done := false;

    for i->b in bases do
        c, r := Explode(chooseOptimalOnes(xs, b, M, R, nonbases));
        if c ne -1 then
            print c;

            t := Cputime();
            evalxs:= evaluatexs(r, c, xs);
            t:= Cputime();
            Id := ScalarMatrix(5,R!1);
            Meval := HorizontalJoin(Id, evalxs);
            nonbasisminors := constructMinorsUnframed(Meval, nonbases, R, b);
            t := Cputime();
            deg := &*[Degree(poly) : poly in nonbasisminors | poly ne 0];
            t := Cputime(t);
            if firsttime then
                bestdeg := deg;
                bestb := b;
                bestminors := nonbasisminors;
                bestpair := [* c, r *];
                firsttime := false;
            end if;
            t := Cputime(t);
            if deg lt bestdeg then
                bestdeg := deg;
                bestb := b;
                bestminors := nonbasisminors;
                bestpair := [* c, r *];
            end if;
            // if bestdeg lt 2^(#nonbases - 5) then
            //     // good enough?
            //     return bestb, bestdeg, bestpair, bestminors;
            // end if;
        end if;
    end for;
    
    return bestb, bestdeg, bestpair, bestminors;
end function;

function doline(bases)
    R<[x]> := PolynomialRing(Rationals(), 35);
    xs := Matrix(5, 5, [R.i : i in [1..25]]);
    Id := ScalarMatrix(5,R!1);
    M := HorizontalJoin(Id, xs);
    nonbases :=  SetToSequence(Set(U) diff Set(bases)); 
    b, deg, pair, nonbasisminors := chooseOptimalBasis(nonbases, bases, M, R, xs);
    print "done with optimal basis";
    
    c, r := Explode(pair);

    //construct equations forced by setting elements in c and r to 1
    nonzereqns := [];
    for i in [1 .. 5] do
        Append(~nonzereqns, xs[i, c]-  1);
    end for;
    for i->x in r do
        if i lt c then
            Append(~nonzereqns, xs[x, i] - 1);
        else
            Append(~nonzereqns, xs[x, i+1] - 1);
        end if;
    end for;

    eqns := nonbasisminors cat nonzereqns; // construct equations of the ideal I
    I := Ideal(eqns);
    Q := quo<R|I>;    

    //construct basisminors
    basisminors := constructMinorsUnframed(M, bases, R, b);

    Isat := saturateIdeal(eqns, basisminors, R); 
    gb := GroebnerBasis(Isat);
    d := Dimension(Isat);
    d := d - 10;
    leqns := constructLambdaEqns(M,R);
    selfdualeqns := gb cat leqns;
    selfdualI := ideal<R|selfdualeqns>;
    sdIsat := Saturation(selfdualI, ideal<R| &*[x[i]: i in [26 .. 35]]>);
    sdIsatelim := EliminationIdeal(sdIsat, {x[i] : i in [1 .. 25]});
    sdequalsreal := sdIsatelim eq Isat;
    if sdequalsreal then
        selfdualdim := Dimension(sdIsatelim) - 10;
        Q := quo<R | sdIsatelim>;
        Mspec := ChangeRing(M, Q);
    else
        Isdsat := sdIsatelim;
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
    inputs := Split(Read("rk5matroids"), "\n");
    input := eval inputs[seq];
    if seq notin [1038, 1041] then
        output := doline(input);
        output := [* seq *] cat output;
        print strip(Join([Sprint(elt) : elt in output], ":"));
    end if;
    exit;
end if;

