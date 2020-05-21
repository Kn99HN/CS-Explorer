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
- M |= a iff a evalutes to true in M
- M |= ~P iff M !|= P (M does not satisfy P)
- M |= P <-> P' iff M |= P is equivalent to M |= P'
- M |= P & P' iff M |= P and M |= P'
- M |= P | P' iff M |= P or M |= P'
- M |= P -> P' iff M |= P implies M |= P'
- M |= Vx. P iff for all u in U, M[x -> u] |= P
- M |= Ex. P iff exists u in U, M[x -> u] |= P

## Notations 
F,G: first-order formulas over S
M: first-order structure over S
- M |= F: F is true in M (M is a model of F)
- |= F: F is valid
- F |= G -> G is valid
- F |= Contradiction F is unsatisfiable

<!-- Ask about this and expand -->
## Theories
Let DC(T) be the deductive closure of a set of sentences T, i.e DC(T) is the smallest set such that
- T in DC(T)
- {P' | P in DC(T), P |= P'} in DC(T)
A (first-order) theory T(over signature S) is a set of
deductively closed sentences (over S), i.e DC(T) = T.
If T = DC(T) for some set of sentences T, then the elements
of T are called axioms of T.
A theory T is consistent if false not in T.
Theory T is also viewed as class of all models of T.

### Note
A Set T of logical formulas is deductively closed if it contains every formula P that can be logically deduced from T. In other words, if T |= P always implies P in T.

Eg: All true statement can only be deduced from other true statements

## T-Satisfiability and T-Validity
- M is a model for the theory T if all sentences of T are true in M.
- A formula P(x) is T-satisfiable in a theory T if:
    - there is a model M of T in which P(x) evaluates to true
    - Notation M |= P(x)
- A formula P(x) is T-valid in a theory T if 
    - P(x) evaluates to true in every model M of T.
    - Notation: |= P(x)

## Theory of Equality T (Theory of free functions)
- Signature S = {=, a,b,c...,f,g,h}
    - `=` is a binary predicate
    - all constant, function and predicate symbols

- Axioms:
    - Vx. x=x (reflexivity)
    - Vx, y.x=y -> y = x (symmetry)
    - Vx, y,z. x = y & y = z -> x = z (transitivity)
    - For each positive integer n and n-ary function symbol f,
    Vx1,...xb, y1, ... yn & xi = yi -> f(x1,...xn) = f(y1,...yn) (Congruence)
    - For each positive integer n and n-ary predicate symbol P,
    Vx1,...xb, y1, ... yn & xi = yi -> P(x1,...xn) <-> P(y1,...yn) (Equivalence)

## Theory Fragments
- Fragment of a theory T is a syntactically restricted subset of the formulas of theory
Eg: The quantifier-free fragment of theory T is the set of formulas without quantifiers that are valid in T
- There are decidable fragments for undecidable theories
- Theory T is decidable if T-validity is decidable for every formula F of T

# SMT Solver

## Architecture
- Quantifier Instantiation
- Arithmetic
- Arrays
- Uninterpreted Functions
- Arrays
- Bit-Vectors
- DPLL: Explanations, conflicts, lemmas, propagations

<!-- Explanation detailed for this approach -->
## Lazy Approach to SMT

g(a) = c & (f(g(a)) != f(c) | g(a) = d) & c != d

-> 1 & (!2 | 3) & !4
-> Model returns [1,!2,!4]
-> Theory solver detecs [1,!2] - T-unsat
-> Send [1,!2 | 3, !4, !1 | 2] to SAT solver
-> SAT solver returns [1,2,3,!4]
-> Theory solver detecs [1,3,!4] T-unsat
-> Send[1, !2 | 3, !4, !1 | 2, !1 | !3 | 4] to SAT solver
-> SAT solver detecs unsat





