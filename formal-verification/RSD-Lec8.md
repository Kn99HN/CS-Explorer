# Lecture 8

## SMT (Satisfiability Modulo Theories)

### Motivation
Is there an assignments to the x,y,z,w variables such that P evaluates to true? 
=> This reduce the complexity of SAT problems

## First-Order Logic

### Functions, Variables, Predicates
- a,b f,g
- x,y,z
- P,Q,=

### Terms
- a, f(a), g(x,y)

### Atomic formulas, Literals
- P(x, f(a)), ~Q(y,z)

### Quantifier free formulas
- P(f(a), b) & c = g(d)

### Formulas, sentences
- Vx.Vy. P(x, f(x)) | g(y,x) = h(y)

### Signatures
A signature consists of 
- A set of function symbols: S = {f,g}
- A set of predicate symbols: S = {P, Q, =, true, false}
- A set of arity function: S Union S -> N

### Terms
- Given a signature S and a set of variables X.
- The set of terms T(S, X) is the smallest set formed by the grammar:

t in T = x | f(t1,...tn)
where x in X
      f in S t1, ... tn in T

### Quantifier-Free Formulas
a, !Q, Q <-> Q', Q & Q', Q | Q', Q -> Q'

### Formulas
- Adding formation rules: Vx and Ex

<!-- Ask professor Wies to understand this -->
## Semantics: Structures
A first-order structure M consists of: 
- Domain U: nonempty set of elements
- Interpretation: f: U^n -> U
- Interpretation: P subset of U for each P in Signature P with arity(P) = n
- Assignment x in U for every variable x in X
- A formula P is true in a structure M if it evaluates to true under the given interpretations over the domain U

## Semantics: Evaluation of Terms and Atoms
- A term t in a structure M evaluates to:
    - x if t = x for some x in X
    - f(u1,...) if t = f(t1,....) and each ti evaluates to ui in M

- An P(t1, ....) atom in a structure M evaluates to b in {true, false} where:
 - b iff (u1, ....) in P
 - and each ti evaluates to ui in M

## Semantics: Evaluation of Formulas




