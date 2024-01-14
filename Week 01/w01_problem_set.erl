% CSE 382 - W01 Problem Set
% Dallin Olson 1/13/2024

-module(w01_problem_set).          
-export([main/0]).

% *****************************************************************************
% PROBLEM SET 1
% *****************************************************************************

% 1) Implement the hello function to display “Hello World!”.
hello() -> io:format("Hello World!~n").

% 2) Implement the add function to add two numbers.
add(A1, A2) ->  A1 + A2.

% 3) Implement the multiply function three different ways each with a different
% number of parameters (i.e. different arity)
multiply(M1)            -> M1 * 1.
multiply(M1, M2)        -> M1 * M2.
multiply(M1, M2, M3)    -> M1 * M2 * M3.

% 4) Implement the water function that will take a temperature in Fahrenheit 
% and return “Frozen”, “Gas”, or “Liquid”. Implement this using three 
% clauses that use the when guard.

water(T) when T < 32             -> "Solid";
water(T) when T >= 32, T < 212   -> "Liquid";
water(T) when T >= 212           -> "Gas".

% 5) Implement the fib function to calculate the nth Fibonacci number. Assume
% the 1st and 2nd number is 1. You will need to use recursion. 
% Recommend using body recursion.

fib(1) -> 1;
fib(2) -> 1;
fib(N) -> fib(N - 1) + fib(N - 2).

% Implement the sum function to add up the numbers from 0 to N (assume N is a
% positive integer) Use recursion instead of using any built-in functions.
% Recommend using body recursion.

sum(0) -> 0;
sum(N) when N > 0 -> N + sum(N - 1).

% Create lambda functions to pass to the plot function. The plot function will
% create {X,Y} coordinates where X goes from -5 to 5 and Y is calculated from
% your lambda function. The curly braces represent a tuple in Erlang. Create
% lambda functions for the following scenarios:

plot(Lambda) ->
    [{X, Lambda(X)} || X <- lists:seq(-5, 5)].

% *****************************************************************************
% PROBLEM SET 2
% *****************************************************************************

% 1) Write a stack_push function that treats the list as a stack (LIFO - Last 
% In First Out). The stack_push function will take two parameters, the Stack
% (ie, a list) and a value N. This function should push the value N to the
% front of the Stack.

stack_push(Stack, N) -> [N | Stack].

% 2) Write a stack_pop function that returns a new stack with the first item
% removed. If the stack is empty, then return the empty list [].

stack_pop([]) -> [];
stack_pop([First | Rest]) -> Rest. 

% 3) Finish the quicksort function provided to you in the starting code.
% The algorithm for quicksort is to first pick a position in the list
% (in our case we will pick the first number) and call it our pivot. We will
% then recursively call quicksort on all of the numbers less than the pivot
% and then call quicksort on all the numbers greater than or equal to the pivot.
% The correct sorted list is then the concatenation (++) of the following 3
% lists:
%   [sorted list of numbers less than the pivot] ++
%   [the one pivot] ++
%   [sorted list of numbers greater than or equal to the pivot].
% The code is setup already but you need to write list comprehensions for creating:
%   - A sub-list containing all numbers in the list less than the pivot
%   (first number in the list) which will be passed to the quicksort function.
%   - A sub-list containing all numbers in the list greater than or equal to the
%   pivot (first number in the list) which will be passed to the quicksort function.

quicksort([]) -> [];
quicksort([Pivot | Rest]) ->
    quicksort([X || X <- Rest, X < Pivot]) ++
    [Pivot] ++
    quicksort([Y || Y <- Rest, Y >= Pivot]).

% MAIN Function
main() ->
    io:format("********** START **********~n~n"),

    % Problem Set 01
    hello(),
    io:format("Add Return: ~p~n", [add(1, 2)]),
    io:format("Multiply/1: ~p~n", [multiply(1)]),
    io:format("Multiply/2: ~p~n", [multiply(2, 2)]),
    io:format("Multiply/3: ~p~n", [multiply(3, 3, 3)]),
    io:format("Water (Solid) : ~p~n", [water(31)]),
    io:format("Water (Liquid): ~p~n", [water(32)]),
    io:format("Water (Gas)   : ~p~n", [water(212)]),
    io:format("Fibonacci:  ~p~n", [fib(10)]),
    io:format("Sum: ~p~n", [sum(5)]),
    io:format("Square: ~p~n", [plot(fun(X) -> X * X end)]),
    io:format("Subtract: ~p~n", [plot(fun(X) -> X - 1 end)]),
    io:format("Absolute Value: ~p~n", [plot(fun(X) -> abs(X) end)]),
    io:format("Divide & Floor: ~p~n", [plot(fun(X) -> math:floor(X / 3) end)]),
    % Problem Set 02
    io:format("Stack Push: ~p~n", [stack_push([3, 2, 1], 4)]),
    io:format("Stack Pop:  ~p~n", [stack_pop([4,3,2,1])]),
    io:format("Quicksort:  ~p~n", [quicksort([4, 2, 7, 1, 9, 3, 5, 6, 8])]),

    io:format("~n**********  END  **********~n").