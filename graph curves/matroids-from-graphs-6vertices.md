## Matroids from graphs on 6 vertices

- We consider all the `3-connected trivalent simple graphs on 6 vertices`. We used the list of such graph from [here](https://en.wikipedia.org/wiki/Table_of_simple_cubic_graphs).

- We call the graphs `Graph6i`, where `6` refers to the number of vertices and `i` is just the index for our list. We describe each graph via its list of edges.

- For each graph in the list, we used the algorithm from `matroid-from-graph.m2` to construct a graph curve
   whose associated graph is our graph Graph6i.

- Our algorithm then intersects the generated graph curve with a randomly generated (i.e. generic) hyperplane. For each graph, we record the equation of the hyperplane that was generated.
   
- We also record the coordinates of the points that we got in this intersection (i.e. in the hyperplane section that we get by intersecting our graph curve with a hyperplane). Because we started with a graph with 2g-2 = 6 vertices, the graph curve that we get always has `genus g = 4` and `degree 2g-2 = 6`, and lies in projective space `P^{g-1} = P^3`, so our hyperplane section consists of `6 points in P^3`.

- Our algorithm from `matroid-from-graph.m2` then extracts a `self-dual matroid on 6 elements {0,1,...,5}` from the configuration of the points that we generated. The matroid has `rank 3` because the points lie and span our hyperplane = P^2 inside P^3.

- We describe the matroid that we get by saying how many bases and non-bases it has. We also enumerate the bases. We also enumerate the circuits of the matroid, ordered by size.

---
---

### 1. Graph61

* #### Edges of graph:

    {0, 1}, {1, 2}, {2, 0}, {3, 4}, {4, 5}, {5, 3}, {0, 3}, {1, 4}, {2, 5}


* #### Randomly generated (generic) hyperplane:
    
    27\*a + 57\*b + 18\*c + 56\*d = 0
    
* #### Coordinates of the 6 points in the hyperplane section:

    [1 : 29 : 0 : -30]
    
    [1 : -3/13 : -10/13 : 0]
    
    [1 : 0 : -29/38 : -9/38]
    
    [0 : 1 : 0 : -57/56]
    
    [0 : 1 : -19/6 : 0]
    
    [0 : 0 : 1 : -9/28]
    
* #### Matroid of rank 3 on base set {0, 1,..., 5}:
    * `18 bases, 2 non-bases`

    * `bases:`
        
        {0, 1, 3}, {0, 2, 3}, {1, 2, 3}, {0, 1, 4}, {0, 2, 4}, {1, 2, 4}, {0, 3, 4}, {1, 3, 4}, {2, 3, 4},
         {0, 1, 5}, {0, 2, 5}, {1, 2, 5}, {0, 3, 5}, {1, 3, 5}, {2, 3, 5}, {0, 4, 5}, {1, 4, 5}, {2, 4, 5}

    * `circuits:`
        * `2 circuits of size 3:`
            
            {0, 1, 2}, {3, 4, 5}

        * `9 circuits of size 4:`
        
            {0, 1, 3, 4}, {0, 2, 3, 4}, {1, 2, 3, 4}, {0, 1, 3, 5}, {0, 2, 3, 5}, {1, 2, 3, 5}, {0, 1, 4, 5}, {0, 2, 4, 5}, {1, 2, 4, 5}

---
---

### 2. Graph62

* #### Edges of graph:

    {0, 1}, {1, 2}, {2, 3}, {3, 0}, {4, 5}, {0, 5}, {1, 4}, {2, 5}, {3, 4}


* #### Randomly generated (generic) hyperplane:
    
    93\*a + 71\*b + 75\*c + 11\*d = 0
    
* #### Coordinates of the 6 points in the hyperplane section:

    [1 : -104/71 : 0 : 1]
    
    [1 : 0 : -13/8 : 21/8]
    
    [1 : -84/73 : -11/73 : 0]
    
    [0 : 1 : -71/75 : 0]
    
    [0 : 0 : 1 : -75/11]
    
    [1 : -1 : 0 : -2]
    
* #### Matroid of rank 3 on base set {0, 1,..., 5}:
    * `20 bases, 0 non-bases`

    * `bases:`
        
        all size 3 subsets of the base set

    * `circuits:`
        * `15 circuits of size 4:`
        
            {0, 1, 2, 3}, {0, 1, 2, 4}, {0, 1, 3, 4}, {0, 2, 3, 4}, {1, 2, 3, 4}, {0, 1, 2, 5},
             {0, 1, 3, 5}, {0, 2, 3, 5}, {1, 2, 3, 5}, {0, 1, 4, 5}, {0, 2, 4, 5}, {1, 2, 4, 5},
             {0, 3, 4, 5}, {1, 3, 4, 5}, {2, 3, 4, 5}


