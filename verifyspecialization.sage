#code to verify a given self-dual point config corresponds to a given basis set

from sage.matroids.advanced import *
seq = eval(sys.argv[1])

def verifypointconfig(fileofmatroids, fileofbases, seq):
    with open(fileofmatroids, "r") as f:
        with open(fileofbases, "r") as g:
            matroids = f.readlines()
            basesfile = g.readlines()
            M = matroids[seq]
            Mdata = M.split(":")
            label = eval(Mdata[0])
            baseslist = eval(basesfile[label-1])
            MatFromBases = Matroid(bases = baseslist)
            if len(Mdata) == 3: #then M is over a number field
                Qt.<t> = QQ[]
                K.<a> = NumberField(sage_eval(Mdata[2], locals={'t':t}))
                Mat = Matroid(matrix(K, sage_eval(Mdata[1], locals={'a':a})))
            else:
                Mat = Matroid(matrix(QQ, sage_eval(Mdata[1])))
            is_iso = Mat.is_isomorphic(MatFromBases)
    return label, is_iso
                
label, is_iso = verifypointconfig("toverify.txt", "rk5matroids", seq)
print(str(label) + ":" + str(is_iso))



#parallel --shuf --timeout 1000 --eta -j2 sage verifyspecialization.sage {} ::: {1..4} >> verificationresults.out