# Theory Solvers

## Motivation
- How to decide T-satisfiability of individual theories?
- How to compose individual theory solvers decide constraints involving multiple theories?
- How to deal with quantifiers?

## Checking validity in T
- How to show that P is T-valid?
P == a = b & b = c -> g(f(a), b) = g(f(c),a)

- Let M be a model for T. The only possibility for M not to be a model of P is if 

M |= a = b & b = c and M !|= g(f(a),c) = g(f(c), a)
- M |= Vx,y,z. x = y & y = z -> x = z
- M |= a = b & b = c
- M |= a = c

Let M be a model for T
- M |= Vx,y . x = y -> f(x) = f(y)
- M |= a =c
- M |= f(a) = f(c)

- M |= a = b & b = c
- M |= a = b
- M |= Vx,y. x = y -> y = x
- M |= b = a
- M |= Vx,y,u,v . x = y & u = v -> g(x, u) = g(y, v)
- M |= f(a) = f(c)
- M |= b = a
- M |= g(f(a), b) = g(f(c), a)

## Note
Since we have proved that for a model M for T, we will lead to the conclusion Q. We have, M |= P

## Problems
- Finding the right axioms to instantiate and which instances to consider
- Time and space consuming
- Can lead to an endless number of instantiations

## Solutions
- Decision procedures - algorithms specialized in reasoning about specific theories
- Input: a formula in theory
- Output: answer if the formula is satisfiable, and if yes, it would also be nice to get a model

# Congruence Closure Algorithm
- Leverage the use of union-find data structure

## Deciding Equality
a = b, b = c, d = e, b = s, d = t, a != e, a != s

For each equality, we create a set of values such that they are all equal. We use a heuristic approach
-> {a,b,c,s}, {d,e,t}

## Deciding Equality + (uninterpreted) Functions
a = b, b = c, d = e, b = s, d = t, f(a, g(d)) != f(b,g(e))

-> {a,b,c,s}, {d,e,t}, {g(d)}, {g(e)}, {f(a,g(d))}, {f(b,g(e))}

### Congruence Rule
x1 = y1, ... xn = yn implies f(x1,...xn) = f(y1,...yn)

-> {a,b,c,s}, {d,e,t}, {g(d)}, {g(e)}, {f(a,g(d)), f(b,g(e))}

## Theory of Arrays T
- Signature S = {read, write, =}
- read(a,i): binary function which reads an array a at index i
- write(a,i,v): ternary function which writes a value v to index i of array a

### Axioms of T
- Va,i,j. i = j -> read(a,i) = read(a,j)
- Va,v,i,j. i = j -> read(write(a,i,v), j) = v
- Va, v,i,j. i != j -> read(write(a,i,v), j) = read(a,j)

### Decidability of T
- Quantifier-free fragment of T is decidable

### Note
- Equality is only defined for array elements
Eg: read(a,i) = e -> Vj. read(write(a,i,e), j) = read(a,j) is T-valid

