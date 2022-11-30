function powerset(x::Vector{T}) where T
    result = Vector{T}[[]]
    for elem in x, j in eachindex(result)
        push!(result, [result[j] ; elem])
    end
    result
end

function is_stable(M::Matroid)
    k = length(M)
    boo = true
    pset = powerset([ i for i in 1:k])
    subsets = [pset[i] for i in 2:length(pset)-1]
    for v in subsets
            if rank(M,v) > length(v)//2
            else
                boo = false 
                return boo
            end
    end
    return boo
end

outputfile = "list_stability_rank5"
inputfile = "rk5matroids"
open(outputfile, "w" ) do file
    open(inputfile, "r") do file1
        for (i,M) in enumerate(eachline(inputfile))
            basesM = eval(Meta.parse(M));
            println(file,i," ",is_stable(matroid_from_bases(basesM,1:10)))
            println(i)
        end
    end
end
