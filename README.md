## Lambda Calculus Interpreter

The project allows to interpret lambda-expressions by implementing the beta reduction, call by name and call by value strategies.

The file types.ml defines the syntax of lambda expressions.

The file utils.ml contains functions useful to the interpreter, in particular it implements a function that identifies the free variables in a lambda-expression, a function that generates fresh variables and a function that implements the capture-avoiding-substitution.

The file interpreter.ml implements the evaluation functions according to the various strategies.

The file tests.ml contains tested lambda-expressions.

In case of functions whose reduction is infinite (limit of 1000 iterations) an exception is raised.

Although the definition of beta reduction is not deterministic (and the interpreter is), the Confluence Theorem of lambda calculus ensures that in cases where the computation ends the result is the same.

The Scanner and Parser part are not managed, therefore to use the interpreter it is advisable to provide the lambda expressions in the form of Abstract Syntax Tree.

Usage:
make
make run