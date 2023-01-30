using Oscar
# R is the Ring on which you work
# Depending on the Ring R, in the following t can be replaced by a prime p.
#EXAMPLE (replace by your own choice!)
R =QQ;
t = 3;
function tropicalised(Q::Vector)
  #     val = TropicalSemiringMap(base_ring(Q[1]),t);
       q = []
   for i in 1:length(Q)
       append!(q,[val(Q[i])])
   end
   return q 
end