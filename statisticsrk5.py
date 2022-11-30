
with open("rk5selfdualrealizations", 'r') as f:
	content = f.readlines()
	nonselfreal = 0
	nonreal = 0
	total = 0
	dimlist = []
	sddimlist = []
	samevariety = 0
	for line in content:
		data = line.split(":")
		total += 1
		realdim = eval(data[3])
		sddim = eval(data[5])
		if sddim < 0:
			nonselfreal += 1
		if realdim < 0 :
			nonreal += 1
		else:
			dimlist.append(realdim)
			sddimlist.append(sddim)
		if data[6] == "true":
			samevariety +=1



	displaydim = [(elt, dimlist.count(elt)) for elt in set(dimlist)]
	displaydimsd = [(elt, sddimlist.count(elt)) for elt in set(sddimlist)] 
 


	print("Total {tot}, Nonrealizable {nonreal}, nonself realizable {nonself}, dimensions {dimlist}, sddimensions {sddimlist}, , same {same}".format(tot = total, nonself = nonselfreal, nonreal = nonreal, dimlist = displaydim, sddimlist = displaydimsd, same = samevariety))

