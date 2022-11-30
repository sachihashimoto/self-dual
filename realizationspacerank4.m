//parallel --shuf --timeout 100 --eta -j2 magma -b seq:={} realizationspacerank4.m ::: {1..12} >> rk4nov1.out


U := [[0, 1, 2, 3], [0, 1, 2, 4], [0, 1, 2, 5], [0, 1, 2, 6], [0, 1, 2, 7], [0, 1, 3, 4], [0, 1, 3, 5], [0, 1, 3, 6], [0, 1, 3, 7], [0, 1, 4, 5], [0, 1, 4, 6], [0, 1, 4, 7], [0, 1, 5, 6], [0, 1, 5, 7], [0, 1, 6, 7], [0, 2, 3, 4], [0, 2, 3, 5], [0, 2, 3, 6], [0, 2, 3, 7], [0, 2, 4, 5], [0, 2, 4, 6], [0, 2, 4, 7], [0, 2, 5, 6], [0, 2, 5, 7], [0, 2, 6, 7], [0, 3, 4, 5], [0, 3, 4, 6], [0, 3, 4, 7], [0, 3, 5, 6], [0, 3, 5, 7], [0, 3, 6, 7], [0, 4, 5, 6], [0, 4, 5, 7], [0, 4, 6, 7], [0, 5, 6, 7], [1, 2, 3, 4], [1, 2, 3, 5], [1, 2, 3, 6], [1, 2, 3, 7], [1, 2, 4, 5], [1, 2, 4, 6], [1, 2, 4, 7], [1, 2, 5, 6], [1, 2, 5, 7], [1, 2, 6, 7], [1, 3, 4, 5], [1, 3, 4, 6], [1, 3, 4, 7], [1, 3, 5, 6], [1, 3, 5, 7], [1, 3, 6, 7], [1, 4, 5, 6], [1, 4, 5, 7], [1, 4, 6, 7], [1, 5, 6, 7], [2, 3, 4, 5], [2, 3, 4, 6], [2, 3, 4, 7], [2, 3, 5, 6], [2, 3, 5, 7], [2, 3, 6, 7], [2, 4, 5, 6], [2, 4, 5, 7], [2, 4, 6, 7], [2, 5, 6, 7], [3, 4, 5, 6], [3, 4, 5, 7], [3, 4, 6, 7], [3, 5, 6, 7], [4, 5, 6, 7]];

function constructMinors(M, indices, R, b)
	//we need to let the indices in b be the first indices, and then it doesn't matter
	bcomp := {0,1,2,3,4,5,6,7} diff Set(b);
	bcomp := SetToSequence(bcomp);
	reorder := pmap<[0,1,2,3,4,5,6,7]->[0,1,2,3,4,5,6,7] | [<b[1],0>, <b[2], 1>, <b[3], 2>, <b[4], 3>, <bcomp[1],4>, <bcomp[2],5>, <bcomp[3], 6>, <bcomp[4], 7> ]>;
    return [ R!Determinant(Transpose(Matrix([ColumnSubmatrixRange(M, reorder(i)+1, reorder(i)+1): i in ind]))) : ind in indices]; 
end function;

function normalizeCols(M, minors, R)
	xs := Matrix(4, 4, [R.i : i in [1..16]]);
    firstnotzer := [];
    for i in [1 .. 4] do
        for j in [1 .. 4] do
                if xs[j][i] notin minors and -xs[j][i] notin minors then
                    Append(~firstnotzer, xs[j][i] - R!1);
                break;
            end if;
        end for;
    end for;
    return firstnotzer;
end function;

function normalizeRows(M, minors, R)
	xs := Matrix(4, 4, [R.i : i in [1..16]]);
    firstnotzer := [];
    for i in [1 .. 4] do
        for j in [1 .. 4] do
                if xs[i][j] notin minors and -xs[i][j] notin minors then
                    Append(~firstnotzer, xs[i][j] - R!1);
                break;
            end if;
        end for;
    end for;
    return firstnotzer;
end function;


function saturateIdeal(I, basisminors)
    for f in basisminors do
        I := Saturation(I, f);
    end for;
    return I;
end function;

function constructLambdaEqns(M, R)
    l := [R.i : i in [17..24]];
    prod := M* DiagonalMatrix(l) * Transpose(M);
    leqns := [Vector(prod)[i] : i in [1.. 16]];
    return leqns;
end function;

function strip(s) return Join(Split(Join(Split(s," "),""),"\n"),""); end function;

function doline(nonbases)
	R<[x]> := PolynomialRing(Rationals(), 24);
	xs := Matrix(4, 4, [R.i : i in [1..16]]);
	Id := ScalarMatrix(4,R!1);
	M := HorizontalJoin(Id, xs);
    bases :=  SetToSequence(Set(U) diff Set(nonbases)); 
    b := bases[1]; //pick a basis to relabel by so that we can create the left identity matrix
	nonbasisminors :=constructMinors(M, nonbases, R, b);
	//force the first nonzero entry of each column to be one
	nonzer := normalizeCols(M, nonbasisminors, R);
	//add in all the equations for each non-basis
	nonzercol := normalizeRows(M, nonbasisminors, R);
	//also add in xs = 1 for each first element in the row that is nonzero 
	eqns := nonbasisminors cat nonzer cat nonzercol;
	//now saturate for each basis element
	basisminors := constructMinors(M, bases, R, b);
	I := ideal<R| eqns >;
	Isat := saturateIdeal(I, basisminors);

	gb := GroebnerBasis(Isat);
	d := Dimension(Isat);
	d := d- 8 ;
	leqns := constructLambdaEqns(M,R);
	selfdualeqns := gb cat leqns;
	selfdualI := ideal<R|selfdualeqns>;
	selfdgb := GroebnerBasis(selfdualI);
	sdIsat := Saturation(selfdualI, &*[x[i]: i in [17 .. 24]]);
	sdIsatelim := EliminationIdeal(sdIsat,{x[i] : i in [ 1.. 16]});
	//now resaturate
	ISDsat := saturateIdeal(sdIsatelim, basisminors);
	selfdualdim := Dimension(ISDsat) - 8;
	sdequalsreal := ISDsat eq Isat;
	Q := quo<R | ISDsat>;
	Mspec := ChangeRing(M, Q); 

	output := [* bases, gb, d, Basis(ISDsat), selfdualdim, sdequalsreal, [Eltseq(r) : r in Rows(Mspec)] *];
	return output;

end function;

if assigned seq then
	SetColumns(0);
	SetAutoColumns(false);
	seq := eval seq;
	inputs := Split(Read("rk4matroidsnonbases"), "\n");
	input := eval inputs[seq];
	output := doline(input);
	output := [* seq *] cat output;
	print strip(Join([Sprint(elt) : elt in output], ":"));
	exit;
end if;






