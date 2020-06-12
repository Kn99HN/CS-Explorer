# Propositional Logic

## Syntax 

**Truth symbols**: True and False
**Propositional variables**: denoted by P,Q,R...

**Formula**: True, False or a propositional variable P, or the application of the connectives to formula:
- ~F: negation
- F1 && F2: conjunction
- F1 || F2: disjunction
- F1 -> F2: implication
- F1 <-> F2: iff

**arity**: the number of arguments that it takes

Negation takes one argument so it is unary but other connectives take two so it is binary. 

The left and right arguments of -> are called antecedent and consequent. 

**atom**: a truth symbol or propositional variable
**literal**: an atom or its negation. 
**formula**: literal or the application of logical connective to a formula

**subformula**: Formula G is subformula of F if it occurs syntactically within G. 

## Semantics 
What is the meaning of Propositional Logic. 

**Semantics** provides its meaning. Meanning is given the truth values `true` and `false`, where they are different. 

How do we give meaning to formulae. First step is defining the semnatics of PL to provide mechanism for evaluating propositional variables. 

**Interpretation** I assigns to every propositional variable exactly one truth value. 

### Example
```
I" {P -> True, Q -> False,...}
```
is an interpretation assigning `true` to P and `false` to Q. I assigns every propostional variable available to us a value. 

**Inductive definition** defines the meaning of basic elements first, which in PL are atoms. Then it assumes that the meaning of a set of elements is fixed and defines a more complex element in terms of these elements. 

We write I |= F if F evaluates to `true` and I ~|= F if F evaluates to `false`. 

## Satisfiability and Validity
A formula F is **satisfiable** iff there exists an interpretation I such that I |= F. A formula F is **valid** iff for all interpretations I, I |= F.

**satisfiabilit** and **validity** are dual concepts. F is valid iff ~F is unsatisfiable. 

Suppose F is valid then for any interpretation I, I |= F. By negation, I ~|= ~F, so ~F is unsatisfiable.

Conversely, suppose that ~F is unsatisfiable. For any I, I ~|= ~F, so that I |= F by negation. Thus, F is valid.

