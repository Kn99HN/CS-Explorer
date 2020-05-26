#  Lecture 7

## Logic

### Syntax
- An alphabet or a set of symbols
- expression: a finite sequence of ymbols
- well-formed expressions: expression following a set of rules

### Semantics
- Gives meaning to well-formed expressions
- Formal induction and recursion can be used to give rigorous semantics

## The SAT Problem
- It is decidable but NP-complete
- Therefore, checking the validity is co-NP-complete
- Many problems in formal verification can be reduced to checking the satisfiability of a formula in some logic
- NP-completeness here means the time need to solve a SAT problem grows exponentially with the number of propositional variables in the formula

### Naive SAT procedures - Enumeration

#### Idea: 
- Guess candidate model and evaluate formula

#### Problem:
- Exponential running time


### Naive SAT procedures - Deduction

#### Idea:
- Draw logical consequences from facts given in the
formula to obtain proof of contradiction
- Eg: resolution (Davis, Putnam 1960)

#### Problem:
- What if formula is satisfiable
- resolution may infer many irrelevant consequences

### Resolution-based Algorithm
- Convert formula into CNF
- Apply the following proof rules to generate new clauses until either:
    - the empty clause is inferred (formula is unsat)
    - no further clauses can be inferred (formula is sat)

(C1 | C2) => (C1 V l) (C2 | ~l)



