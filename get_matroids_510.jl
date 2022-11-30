function get_simple_matroids(rk,el)
    db = Polymake.Polydb.get_db();
    collection = db["Matroids.Small"]
    query = Dict("RANK"=>rk, "N_ELEMENTS"=>el, "SIMPLE"=>true);
    results = Polymake.Polydb.find(collection, query);
    l = collect(results)
    oscar_matroids = [Matroid(pm) for pm in l]
    baseslist = [bases(dual_matroid(M)) for M in oscar_matroids]
    return baseslist
end

B = get_simple_matroids(4,9)


#rank 5 on 9 elements,  B are the bases
function get_bases_9_to_10(B::Vector{Vector{Int64}})
    set = [1,2,3,4,5,6,7,8,9,10];
    n= length(B)
    #we form the complement for each basis
    complement=[[1]];
    for v in B
       q = []
       for s in set
        if !(s in v)
            append!(q,[s])
        end
       end
       append!(complement,[q])
    end
    newBases = vcat(B,[complement[i] for i in 2:n+1])
    return newBases
end

Y = [get_bases_9_to_10(B[i]) for i in 1:length(B)]
newList = [[[1]]]
for m in Y
    if Polymake.matroid.check_basis_exchange_axiom([Polymake.Set(m[i]) for i in 1:length(m)])
        append!(newList,[m])
    end          
end

newList2 = [newList[i] for i in 2:length(newList)]

outfile = "new_selfdual_rk5_modISO.txt";
List = [uniform_matroid(5,10)]
f = open(outfile, "w")
println(f,bases(List[1]))
open(outfile,"w") do file 
for i in 1:length(newList2)
        M = matroid_from_bases(newList2[i],1:10)
		b = false
		for j in 1:length(List)
			b= b || is_isomorphic(M,List[j])
			if b
				break
			end
		end
		if !b
			append!(List,[M])
            println(file,bases(M))
		end
        #println(i) #to check for progress
end 


outfile = "nonbases_selfdual_rk5_modISO.txt";
open(outfile, "w") do file
    for i in 1:length(List)
    println(file,length(nonbases(List[i])))
    end
end