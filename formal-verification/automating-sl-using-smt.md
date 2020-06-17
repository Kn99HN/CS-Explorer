# Automating Separation Logic Using SMT

## Separation Logic
Extension of Hoare logic for providing the correctness of heap-manipulating programs. It has two characteristics:
- Spatial conjunction operator that decomposes the heap into disjoin regions, each can be reasoned independently.
- Inductive spatial predicates that describe the shape of unbounded linked data structures s.a lists, tress etc. 

It gives rise to *frame rule*. The rule makes separation logic attractive for developers of program verification tools.

A reduction of separation logic to first-order logic enables complete combinations with other theories implemented in Z3 and CVC4.

Technique used relies on a transition of SL formulas into a decidable fragment of first-order logic, which is referred as logic of *graph reachability and stratified sets* (GRASS). Formulas in this logic express properties of the structure of graphs, such as whether nodes in the graph are inter-reachable. 

The technique can be used to solve frame inference and abduction problems. 

## Preliminaries

The team uses first order logic with equality, which is the theoretical foundation of modern SMT solvers. 

**Many-sorted first-order logic** A *signature* Σ is a tuple (S,Ω,Π), where S ia countable set of *sorts*, Ω is a countable set of *function symbols*, and Π is a countable set of *predicate symbols*. Each function and predicate symbol has an associated sort, which is a tuple of sorts in S. A function symbol whose sort is a single sort in S is called constant. 

For two signatures Σ1 & Σ2, were Σ1 U Σ2 for the signature that is obtained by taking point-wise union of Σ1 and Σ2. Σ1 and Σ2 are disjoint if they do not share any function or predicate symbols. We write Σ1 in Σ2 if Σ1 U Σ2 = Σ2. A Σ-term is built as usual from function symbols in Ω and variables taken from a set X that is disjoint from S, Ω and Π. Each variable x in X has an associated sort in S. We also assume the standard notions of Σ-atom, Σ-literal, and Σ-formula. 

**Interpretations and structures**
Let Σ = (S,Ω,Π) be a signature. A partial Σ-interpretation Α over variables X is a function that maps each sort s in S to a non-empty set s^A and each function symbol f in Ω of sorts s1 x .... x sn -> t to a partial function f^A: s1^A x .... x sn^A -> t^A. Similarly, evert predicate p in Π of sorts s1 x .... x sn is interpreted as a relation p^A in s1^A x .... x sn^A. Finally, A interprets every variable called total interpretation or simply interpretation if it interprets all function symbols by total functions. We denote by A|Σ,X the Σ'-interpretation over X'. We write A|Σ for A|Σ,Ο. A partial Σ-structure is a partial Σ-interpretation over an empty set of variables. For a partial Σ-interpretation A and  σ in S U Ω U Π U X, we denote by A|σ |-> v| the interpretation that is like A but interprets σ as v. 
