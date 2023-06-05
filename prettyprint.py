
def prettyprint(line):
	data = line.split(":")
	nonbasesnum = len(eval(data[1]))
	print("Matroid label: {}".format(data[0]))
	print("Number of bases: {}".format(nonbasesnum))

	if eval(data[3]) < 0:
		print("Dimension of realization space: {}".format("-1"))
		print("Dimension of self-dual realization space: {}".format("-1"))
	else:
		print("Dimension of realization space: {}".format(data[3]))
		print("Dimension of self-dual realization space: {}".format(data[5]))
		print("Are the spaces equal? {}".format(data[6]))
	print("Groebner basis for realization space:{}".format(data[2]))
	print("Groebner basis for self-dual realization space:{}".format(data[4]))

	if eval(data[5]) > 0:
		print("Template for ISD matroid: ")
		print(data[7].replace(',', ' ').replace('] [', ']\n[')[1:-1])

def showbases(line):
	data = line.split(":")
	print(data[1]) 



whichfile = input("Enter 4 for rank 4 data and 5 for rank 5 data: ")
if whichfile == "4" :
	file = "rk4.out"
if whichfile == "5":
	file = "rk5selfdualrealizations"
with open(file, 'r') as f:
	content = f.readlines()
	while True:
		line = input("Enter line number: ")
		linenum = eval(line)
		line = content[linenum-1]
		prettyprint(line)
		seebases = input("Do you want to see the bases? yes/no ")
		if seebases == "yes":
			showbases(line)
