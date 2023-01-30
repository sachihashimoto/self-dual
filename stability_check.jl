include("get_selfdual_matroids.jl")

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
