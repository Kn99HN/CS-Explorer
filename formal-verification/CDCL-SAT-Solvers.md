# Conflict-Driven Clause Learning SAT Solvers

## Key techniques:
- Learning new clauses from conflicts during backtrack search
- Exploiting structure of conflicts during clause learning
- Using lazy data structures for representation of formulas
- Branching heuristics must have low computational overhead and must receive feedback from backtrack search
- Periodically restarting backtrack search

## Notation
- We define an assignment v as a function v: X -> {0,u,1}, where u stands for undefined.
- l = {
    v(x) if l = x
    1 - v(x) if l = ~x
}
- w = max{l | l in w}
- t = min{w | w in t}
- Clauses are unsatisfied, satisfied, unit or unresolved:
    - A clause is unsatisfied if all its literals are assigned value 0 (or False).
    - A clause is satisfied if at least one of its literals is assigned 1 (or True).
    - A clause is unit if all literals but one are assigned value 0 (or False).
    - A clause is unresolved if it is neither satisfied, nor satisfied, nor unit.
- Unit clause rules:
    - If a clause is unit, then its sole unassigned literal must be assigned 1 for it to be satisfied.
- Unit propagation:
    - applied after each branching step
    - used for identifying variables which must be assigned a specific Boolean value.
    - If an unsatisfied clause is identified, a conflict condition is declared and the algorithm backtracks
- Each variable x is characterize by value, antecedent and the decision level.
- A variable x that is assigned a value as the result of applying the unit clause rule is impled.
- The unit clause ω used for implying variable x is the antecedent of x, or α(x) = ω
- The decision level of a variable x denotes the depth of the decision tree at which it is assigned a value.
- The decision level for an unassigned variable x is -1.
- Formally speaking, the decision level of x with antecedent ω is given by:
    δ(x) = max({0} U {δ(x} | y in ω & y != x})
=> The decision level of an implied literal is either the highest level of implied literals in a unit clause, or it is 0 in case the clause is unit. 
- Notation x = v@d means ν(x) = v and δ(x) = d. Moreover, the decision level of a literal is defined as the decision level of its variable

#### Example

`δ = (x1 | ~x4) & (x1 | x3) & (~x3 | x2 | x4)`

- Assume x4 = 0 @ 1. Unit propagation yields no additional implied assignments. 
- Assume x1 = 0 @ 2. Unit propagation yields x3 = 1 @ 2 and x2 = 1 @ 2 

