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

#### Note
- A literal is a variable or its negation
- A clause is a disjunction of literals: a | b
- A unit clause contains only one literal: a, ~a

#### Example

`δ = (x1 | ~x4) & (x1 | x3) & (~x3 | x2 | x4)`

- Assume x4 = 0 @ 1. Unit propagation yields no additional implied assignments. 
- Assume x1 = 0 @ 2. Unit propagation yields x3 = 1 @ 2 and x2 = 1 @ 2 

=> Explanation: 
- First step x4 = 0, then we have:
`(x1 | 1) & (x1 | x3) & (~x3 | x2 | 0)`
- Next, x1 = 0, then we have
`(0 | 1) & (0 | x3) & (~x3 | x2 | 0)`
- Then for the other two clauses to satisfied, we can apply unit propagation to have x3 = 1:
`(0 | 1) & (0 | 1) & (~0 | x2 | 0)`
- Similarly, we can also infer for the last clause to be satisfied x2 = 1

- Assigned variables and antecedents define a directed acyclu graph I = (V, E), which is the implication graph.
- Vertices of the implication graph are defined by all assigned variables and one node k, V in X U {k}.
- The edges in the graph are the antecedent of each assigned variable: 
    - If ω = α(x) => a directed edge from each variable in ω to x.
    - If unit propagation yields an unsatisfied clause j, then a special vertex k is used to represent the unsatisfied clause.

# Organization of CDCL Solvers

```
CDCL(φ,ν)
    if(UnitPropagation(φ,ν) == CONFLICT)
        then return UNSAT
    dl = 0 <- Decision level
    while(! AllVariablesAssigned(φ,ν)):
        do (x,v) = PickBranchingVariable(φ,ν) <- Decision stage
            dl = dl + 1
            ν = ν U {(x,v)}
            if(UnitProp(φ,ν) == CONFLICT): <- Deduce stage
                then Β = ConflictAnalysis(φ,ν) <- Diagnose Stage
                    if B < 0:
                        return UNSAT
                        else Backtrack(φ,ν,Β)
                            dl = B
    return SAT
```

- UnitPropagation consists of the iterated application of the unit clause rule. If an unsatisfied clause is identified, then a conflict indication is returned.
- PickBranchingVariable consits of selecting a variable to assign and respective value
- ConflictAnalysis consists of analyzing the most recent conlfict and learning new clause from the conflict.
- AllVariablesAssigned tests whether all variables have been assigned, then the CNF formula is satisfiable.

### Conflict Analysis

<!-- Ask about this -->
#### Learning Clauses from Conflicts

- Each time the solvers identifies a conflict due to unit propagation, the conflict analysis procedure is invoked. As a results, one or more new clauses are learnt and a backtracking decision level is computed.
- It analyzes the structure of unit propagation and decides which literals to include in the learnt clause.
- The decision levels associated with assigned variables define a partial order of the variables. Starting from a given unsatisfied clause (represented in the graph by k), the conflict analysis procedure visits variables implied at most recent decision level (i.e the current largest decision level), identifies the antecedents of visited variables, and keeps from the antecedents the literals assigned at decision levels less than the most recent decision level. This process is repeated until the most recent decision variable is visited.
- Let d be the current decision level.
- Let x be the decision variable.
- Let ν(x) = v be the decision assignment
- Let w be an unsatisfied clause identified with unit propagation.
- vertex k is such that α(κ) = w.
<!-- What does this mean? Asking about Conflict analysis -->
- For two clauses wj and wk, for which there is a unique variable x such that one clause has a literal x and the other has literal ~x, wj @ wk contains all the literals of wj and wk with the exception of x and ~x
- We define a predicate that holds if a clause ω has an implied literal l assigned at the current decision level d:
    ε(ω,l,d) = 1 if l in ω & δ(l) = d & α(l) != NULl
             = 0 otherwise
- Let ω^d,i_L with i = 0,1,... be the intermediate clause obtained after i resolution operations. 

### Exploiting Structure with UIPs
- Structure of implied assignments induced by unit propagation is a key aspect of the clause learning procedure. 
- Unit Implication Points (UIPs):
    - a dominator in the implication graph, and represents an alternative decision assignment at the current decision level that results in the same conflict.

    => Reducing the size of learnt clauses.
- There is a UIP at decision level d, when the number of literals in ω assigned at decision level d is 1.
- Let σ(ω, d) be number of literals in ω assigned at decision level d. σ(ω, d) can be defined as:
    - σ(ω,d) = |{l in ω | δ(l) = d}|

- We create a clause containing literals from the learnt clause until the first UIP is identified. 
### Backtracking Schemes 
- Stop at the first UIP and backtrack to the conflicting area by using a lazy data structures.
- We backtrack given the information of the learnt clause. This is referred to as first UIP clause learning.