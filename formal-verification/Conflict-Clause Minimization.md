# A SAT Solver with Conflict-Clause Minimization

Two features are made in MiniSAT with respect to the original CHAFF:
- Incremental MiniSAT interface.
- Support for user defined boolean constraints.

## Variable Order
The decision heuristics of MiniSAT is an improved VSIDS order, where variable activities are decayed 5% after each conflict.

The new scheme responds more quickly to changes in the productive set of branch-variables than the original, and avoid branching on out-dated variables. 

The scheme increases the activity of all variables occuring in some clause used in the conflict analysis.

## Binary clauses
Storing the literal to be propagated directly in the watcher list. Often, in the original, it is stored in a separate set of vectors on the side

## Clause deletion
MiniSAT aggresively deletes learned clauses based on activity heuristic similar to the one for variables. They keep a limit on how many learned clauses are allowed is increased after each restart. Keeping the number of clauses low seems to be particular important for small but hard problems. 

# Conflict clause minimization

## Definition
Let C and C' be clauses, + is the resolution operator on variable x. If C + C' in C then C is said to be self-subsumed by C' with respect to x. 

C' is used to remove x (or ~x) from C. It is effective to use this in conflict clause geneation. 

```
strengthenCC(clause C) #C is conflict clause

    for each p in C do:
        if (reason(~p) \ {p} in C):
            mark p
    remove all marked literals in C
```

`reason(p) denote the clause that become unit and propagated p = True.

For every literal p of the newly generated conflict clause C, the algorithm tries to self-subsume C by the reason clause for p. If successful, p can be removed, replacing C with C + reason(p). 

In simpler terms, any literal in a clause that is implied False by assuming a subset of other literals in that clause to be False, might be removed. 



Check the paper out [here](http://minisat.se/downloads/MiniSat_v1.13_short.pdf)