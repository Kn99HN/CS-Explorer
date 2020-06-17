# Meaningful Names

## Use Intention-Revealing Names
Choosing good names takes time but saves more than it takes.

Change to better ones when we found them.

Name of a variable, function, or class, should answer all the big questions. It should show why it exists, what it does, and how it is used.

**If a name requries a comment, then the name does not reveal its intent**

## Avoid Disinformation
Avoid leaving false clues that obscure the meaning of code.

Do not refer to a grouping of accounts as an `accountList` unless it's actually a `List`. 
=> Even if it's a `List`, it might be better not to encode container type into the name.

Spelling similar concepts similarly is *information*. Using inconsistent spellings is *disinformation*. 

## Make Meaningful Distinctions
Number-series naming (a1, a2,..., aN) is the opposite of intentional naming. Such names are not disinformative - they are noninformative, they provide no clue to the author's intention. 

Noise words are another meaningless distinction. Imagine that we have `Product` class. If we have another called `ProductInfo` or `ProductData`, we have made names different without making them meaning anything different. `Info` and `Data` are like `a`, `an` and `the`.

Noise words are redundant. `variable` should never appear in a variable name. 

## Use Human words

## Use Searchable Names
Single-letter names and numeric constants have a particular problem in that they are not easy to locate across body of text. 