use application "polytope";

# Creates a cone from a Set<String> of the form v#g
# where g is an index pointing to a group elements and v is an index of  representative of a ray
sub string2cone{
	my $s = shift;

	# you may have to change paths to load files 
	my $G = load("group36");
	my $GrRays = load("GrRays36.data");
	my $dim = 20;


	my $j = 0;
	my $R = new Matrix($s->size,$dim);
	my $w = new Vector($dim);
	foreach my $r (@{$s}){
		my @tmp = split '#', $r;
		my $g = $G->[$tmp[1]];
		my $v = $GrRays->[$tmp[0]];
		$v = permuted($v,$G->[$tmp[1]]);
		$R->row($j++) = $v;
		$w+=$v;
	}
	return new Cone(RAYS=>$R,REL_INT_POINT=>primitive($w));
}


#To use the above method excute the following lines in the polymake-shell
#  script("read_cones.pl");
#  
#  $cones = load("polymake_data_TGr38GroebnerCones.data");
#  $c = string2cone($cones->[0]);
#
#or
#
#  $cones = load("polymake_data_TGr38PlueckerCones.data");
#  $c = string2cone($cones->[0]);
#
#The variable $c refers to a Cone object. You may change the index (here 0) to get another cone.
#  



