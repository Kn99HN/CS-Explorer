# Many Sorted First Order Logic

## Signatures

A **signature** Σ consists of:
- A set of *function symbols*: {f,g...}
- A set of *predicate symbols*: {P,Q, =, true, false,...}
- *Arity* Function

**constant** are function symbols with arity 0.

A countable set X of variables:
- disjoint from Σ

## Terms
- Given a signature Σ and a set of variables X.
- The set of *terms* T(Σ,Χ) is the smallest set formed by grammar:
    - t in T ::= x | f(t1,...tn)
    - x in X
    - f in Σf, t1,...tn in T

## Quantifier-Free Formulas
The set QFF(Σ,Χ) of **quantifier-free formulas** is the smallest set such that:

σ in QFF(Σ, Χ) is:
- a (atoms)
- ~σ (negations)
- σ <-> σ' (bi-implications)
- σ && σ' 
- σ || σ'
- σ -> σ'

## Formulas
The set of **first-order formulas** are obtained by adding the formation rules:
σ ::= :
- For every x. σ
- There exists x. σ

A **sentences** is a first-order formula with no free variables.

## Semantics
A **first-order structure** M consists of:
- Domain U: nonempty set of elements
- Interpretation, f^M: U^n -> U for each f in Σf with arity(f) = n
- Interpretation P^M in U^n for each P in Σp with arity (P) = n
- Assignment X^M in U for every variable x in X

A formula 