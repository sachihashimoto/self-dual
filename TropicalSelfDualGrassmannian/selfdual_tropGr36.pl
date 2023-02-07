use application "polytope";
script("DataTropGr36/read_cones.pl");
$cones = load("DataTropGr36/ConesDrOfGr36.data");
#The equations defining the self-dual locus of R^20
$Eq =  new Matrix<Rational>([[0,1,-1,0,-1,1,0,0,0,0,0,0,0,0,-1,1,0,1,-1,0],[0,1,0,-1,-1,0,1,0,0,0,0,0,0,-1,0,1,1,0,-1,0],[1,0,-1,0,-1,0,0,1,0,0,0,0,-1,0,0,1,0,1,0,-1],[1,0,0,-1,-1,0,0,0,1,0,0,-1,0,0,0,1,1,0,0,-1],[0,1,-1,0,0,0,0,0,-1,1,-1,1,0,0,0,0,0,1,-1,0],[0,1,0,-1,0,0,0,-1,0,1,-1,0,1,0,0,0,1,0,-1,0],[1,0,-1,0,0,0,-1,0,0,1,-1,0,0,1,0,0,0,1,0,-1],[1,0,0,-1,0,-1,0,0,0,1,-1,0,0,0,1,0,1,0,0,-1],[1,1,-1,-1,-1,0,0,0,0,1,-1,0,0,0,0,1,1,1,-1,-1]]);
#A basis of the lineality space of trop(Gr(3,6))
$Lin = new Matrix<Rational>([[1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0],[1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0],[1,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,1,1,1,0],[0,1,0,0,1,0,0,1,1,0,1,0,0,1,1,0,1,1,0,1],[0,0,1,0,0,1,0,1,0,1,0,1,0,1,0,1,1,0,1,1],[0,0,0,1,0,0,1,0,1,1,0,0,1,0,1,1,0,1,1,1]]);

#The linear space defined by the self-duality condition is a cone
$SD = new Cone(INEQUALITIES=>[],EQUATIONS=>$Eq);

#Defines an array of the 7 representatives of the cones of trop(Gr(3,6)) modulo the group action together with the lineality space.
$c = new Array<Cone>(new Cone(INPUT_RAYS=>string2cone($cones->[0])->RAYS, INPUT_LINEALITY=>$Lin),new Cone(INPUT_RAYS=>string2cone($cones->[1])->RAYS, INPUT_LINEALITY=>$Lin),new Cone(INPUT_RAYS=>string2cone($cones->[2])->RAYS, INPUT_LINEALITY=>$Lin),new Cone(INPUT_RAYS=>string2cone($cones->[3])->RAYS, INPUT_LINEALITY=>$Lin),new Cone(INPUT_RAYS=>string2cone($cones->[4])->RAYS, INPUT_LINEALITY=>$Lin),new Cone(INPUT_RAYS=>string2cone($cones->[5])->RAYS, INPUT_LINEALITY=>$Lin),new Cone(INPUT_RAYS=>string2cone($cones->[6])->RAYS, INPUT_LINEALITY=>$Lin));

#Computes the intersection of the cone representatives with the self-dual linear space. Note that the lineality space is always contained in the self-dual linear space $SD.
$Int = new Array<Cone>(intersection($c->[0],$SD),intersection($c->[1],$SD),intersection($c->[2],$SD),intersection($c->[3],$SD),intersection($c->[4],$SD),intersection($c->[5],$SD),intersection($c->[6],$SD));

