using Oscar

# Returns the simple self-dual matroids from the polyDB database
# Only works for rank up to 4
function get_selfdual_matroids(rk)
    db = Polymake.Polydb.get_db();
    collection = db["Matroids.Small"]
    query = Dict("RANK"=>rk, "SIMPLE"=>true,"IDENTICALLY_SELF_DUAL"=>true);
    results = Polymake.Polydb.find(collection, query);
    l = collect(results)
    oscar_matroids = [Matroid(pm) for pm in l]
    return oscar_matroids
end

function is_self_dual(mat)
	return revlex_basis_encoding(mat)[2] == revlex_basis_encoding(dual_matroid(mat))[2]
end

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