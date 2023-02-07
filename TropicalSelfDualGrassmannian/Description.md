The files in this directory were used the prove Theorem 6.5 in the paper "Self-dual matroids from canonical curves"
The computations were done using polymake 4.6 and Singular 4.3.1
 
The documents cone0 to cone6 contain the intersections of the 6 representative cones of trop(Gr(3,6)) with the space of self-dual points.
They are polymake objects, i.e. the files can be loaded into polymake and investigated there.
For this open polymake and type
$C0 = load("your/path/to/cone0");

In order to reproduce these data run the code in selfdual_tropGr36.pl within polymake.
This file calls the documents in DataTropGr36, which contains the data on cones and rays of the tropical Grassmannian Trop(Gr(3,6)) modulo the group action and scripts to recover the data. 
The Data of the tropical Grassmannian Trop(Gr(3,6)) was originally computed by Speyer and Sturmfels for "The tropical Grassmannian" and  analysed by Herrmann, Jensen, Joswig and Sturmfels for the paper "How to draw tropical planes". It is also available at the internet page https://www.uni-math.gwdg.de/jensen/Research/G3_7/grassmann3_6.html
The encoding of the data that is used here, as well as the scripts, were provided by Benjamin Schröter in the style used for the Data of the paper "Parallel Computation of tropical varieties, their positive part, and tropical Grassmannians". 

The file tropicalGr26 contains the Singular code including output to compute the tropical Variety of Gr(2,6).

The file tropicalizationSelfdualGrassmanian.txt contains the Singular code including output to compute the tropical Variety of SGr(3,6).

These last two files cannot be loaded directly into either Singular or polymake for further investigation. 