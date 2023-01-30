The files in this directory were used the prove Theorem 6.5 in the paper "Self-dual matroids from canonical curves"
The computations were done using polymake 4.6 and Singular 4.3.1
 
The documents cone0 to cone6 contain the intersections of the 6 representative cones of trop(Gr(3,6)) with the space of self-dual points.
They are polymake objects, i.e. the files can be loaded into polymake and investigated there.
For this open polymake and type
$C0 = load("your/path/to/cone0");

There will be information/reference to the original Data on Trop(Gr(3,6)) and the methods/code for reproduction available shortly.


The file tropicalGr26 contains the Singular code including output to compute the tropical Variety of Gr(2,6).

The file tropicalizationSelfdualGrassmanian.txt contains the Singular code including output to compute the tropical Variety of SGr(3,6).

These last two files cannot be loaded directly into either Singular or polymake for further investigation. 