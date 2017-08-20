# submodels

Inital exploration to investigate the following question.

When having a categorical variable (K levels), what is better:

a) Fit the model in the usual way by coding the categorical predictor with dummy variables

b) Fit K different models (with one predictor variable less than option a) and then recombine the models to do predictions ?

In this boston housing example we see that there is improvement with option b).

However I ended up finding some literature (since this is sort of asking for piecewise regression).

A few related articles: 

-http://web.stanford.edu/~boyd/papers/pdf/cvx_pwl_fit.pdf

-http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.62.3214&rep=rep1&type=pdf

-http://mason.gmu.edu/~jluo2/optimal.pdf

-https://astro.temple.edu/~msobel/documents/pami07-7.pdf

Note: the code is not clean, and obviously proofs nothing other than the fact that we can find examples where this works.

