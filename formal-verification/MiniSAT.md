# MiniSAT

MiniSAT aims to help SAT-community understand the process more easily. It use conflict-driven backtracking together with watched literals and dynamic variable ordering.

## API
```
# Creating a new variable
newVar

# Creating a clause from the list of literals. If conflict arise, it will detect it.
addClause(...)

# Handle all the assignments and finding satisfiability
solve()

# Called before solved. propagate all unit information and remove satisfied constraints.
simplifyDB
```
After which, if solve returns True. We can repeatedly add new clause and keeps solving

## Overview of the Solver

### MiniSAT

#### Propagation
Based on CHAFF. For each literal, a list of constraints is kept. 

Two unbound literals p and q of the clause are selected, and references to the clause are added to the list of p and q respectively. The literals are said to be watched and the lists of constraints are referred to as watcher list. As soon as a watched literal becomes True, the constraint is invoked to see if information may be propagated, or to select new unbound literals to be watched.

For the watcher system, backtracking is then relatively cheap.

#### Learning
The process starts when a constraint becomes conflicting under the current assignment. 

The conflicting constraint is then asked for a set of variable assignments that make it contradictory.

We repeatedly do this until certain point that we are sure the assignments leads to the contradiction.

Learnt clauses serve two purposes:
- Driving the backtracking
- Speed up future conflicts by "caching" the reason for the conflict. As the recorded clauses start to build on each other and participate in the unit propagation, the accumulated effect of learning can be massive. 

#### Search
The procedure start iteratively. The procedure start by selecting an unassigned variable x (called the decision variable), assuming it to be True.

The consequence will then be propagated, possibly resulting in more variable assignments.

All assigments will be stored on a stack in the order they were made. It is divided into decision levels and is used to undo information during backtracking.

We would use dynamic variable order that gives priority to variables involved in recent conflicts.

#### Activity Heuristics

