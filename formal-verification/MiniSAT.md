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
Each variable has an activity attached to it. Every time a variable occurs in a recorded conflict clause, its activity is increased. 

We called this `bumping`. After recording the conflict, the activity of all the variables in the system are multiplied by a constant less than 1, decaying the activity of variables over time.

MiniSAT uses a similar schemes. When a learnt clause is used in the analysis process of a conflict, its activity is bumped. Inactive clauses are periodically removed. 

#### Constraint Removal
The constraint database is divided into two parts: the `problem constraints` and the `learnt clauses`. 

#### Top-level solver
The solver uses `restart` as its main strategy to escape from futile parts of the search tree. 

## Implementation

### The solver state
The state does not contain a boolean conflict. Instead we impose as an invariant that the solver must never be in a conflicting state. 

Therefore, any method that puts the solver in a conflicting state must communicate this. 

### Constratints

#### Constructor
Called once at top level. It creates and adds constratint to appropriate wathcer lists after enquing unit information derivable under the current top level assignment. Conflict must be communicated. 

#### Remove
The remove method supplants the destructor by receiving the solver state as a parameter. It disposes the constratint and remove it from the watcher lists.

#### Propagate
Called if constraint is found in a watcher list during propagation of unit transformation p. Constraint is removed from the list and is required to insert into a new or same watcher list. 

The unit information derivable as a consequence of p should be enqueued. 

#### Simplify
Simplyfying representation under current assignment.

#### Undo
During backtracking, the method is called if constraint added itself to undo list of `var(p)` in `propagate()`. The current variable assignments are guaranteed to be identifical to that of the moment before propagate was called. 

#### Calculate Reason

### Propagation
The routine keeps a set of literals (unit information) that is to be propagated. We called this the `propagation queue`. When a literal is inserted in the queue, the corresponding variable is immediately assigned. 

For each literal in the queue, the watcher list of the literal determines the constraints that may be affected by the assignments. 

Each constraint is asked by a call to its `propagate()` method if more unit information can be inferred, which will then be enqueued. The process continues until either the queue is empty or a conflict is found. 

### Learning
As we propagate unit clause, we might lead to a conflict. The conflict clause may lead us to the clause, which starts the conflicting assignments. After an analysis, we can add the new clause to the database. This is called a `learnt` conflict clause. 

We then use First UIP as the learning schemes. In a breadth-first manner, continue to expand literals of the current decision level, until there is just one left. 

The analysis returns a conflict clause, but also the backtracking level, which is the lowest decision level for which the conflict clause is unit. 

### Search

#### Restarts
We will look for analysis of conflicts. If failing to solve the SAT-problem within the search bound, all assumptions will be cancelled and contradition returned. We restart the search with a new set of parameters.

#### Reduce
We pass an upper limit on the number of learnt clauses that are kept. Once this number is reached, `reduceDB()` is called. Clauses that are currently the reason for variables are said to be `locked` and cannot be removed by `reduceDB()`. Limit is then extended by number of assigned variables, which approximates number of locked clauses.



