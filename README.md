# LP-Optimization

#To view my project, please visit https://docs.google.com/document/d/11l84jfOrdeC-aq7lpM8khMv-8WArKiEl2tBjuiWhOBo/edit#heading=h.g6bx6qe5q6e3. Contents will be translated onto LaTeX soon.

Introduction:

In this project, we evaluated the accuracy of a fast online linear algorithm by comparing it to the offline algorithm using different sets of input data. 

The fast-online linear programming algorithm uses the fast dual iterative algorithm and applies a “boosting” strategy by running K rounds of random permutation. This algorithm can approximate the solution of linearly constrained convex programming problems efficiently but at the cost of precision loss. 


We would like to quantify the precision loss, however, the loss is dependent on the characteristic of input data.

We defined a set of input data using different distribution samples and complexities. Then we feed the data to control and experiment algorithms and measure the precision loss between the two. The control is the “real” solution determined by the offline algorithm, and the experiment is the fast online linear algorithm.

One important note is that for the fast online algorithm, it normally requires the b-vector to be O(n) complexity and very large. However, we also experiment with a “balanced” a-vector which allows us to use a b-vector with the O(1) complexity.

Results and methods:

Please view in linked document.

Conclusion:

From the data, it is clear that our fast online linear programming algorithm performs exceptionally well under all the types of testing data. In each case, the approximate solution was very similar to the true solution.

For our data categorized as having a b-vector with a uniform distribution, the algorithm is able to approximate very similar results compared to the offline algorithm. We discovered that the algorithm using a balanced a-vector and order of O(1) b-vector is able to produce extremely similar results compared to an input having an O(n) order b-vector.

For our data categorized as having a b-vector with a Bernoulli distribution, we observed that as the p-value that determines the number of 1’s increases, the algorithm is able to attain better and more accurate results. Below is a graph of the trials using different p-values.


