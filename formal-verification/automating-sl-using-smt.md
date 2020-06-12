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