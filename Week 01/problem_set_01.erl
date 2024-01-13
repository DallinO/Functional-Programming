% CSE 382 - W01 Problem Set
% Dallin Olson 1/13/2024


% Module name matches the file name
-module(problem_set_01).          
-export([main/0]).

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

% MAIN Function
main() ->
    io:format("********** START **********~n~n"),

    hello(),
    io:format("Add Return: ~p~n", [add(1, 2)]),
    io:format("Multiply/1: ~p~n", [multiply(1)]),
    io:format("Multiply/2: ~p~n", [multiply(2, 2)]),
    io:format("Multiply/3: ~p~n", [multiply(3, 3, 3)]),
    io:format("Water (Solid) : ~p~n", [water(31)]),
    io:format("Water (Liquid): ~p~n", [water(32)]),
    io:format("Water (Gas)   : ~p~n", [water(212)]),
    io:format("Fibonacci: ~p~n", [fib(10)]),
    io:format("Sum: ~p~n", [sum(5)]),
    io:format("Square: ~p~n", [plot(fun(X) -> X * X end)]),
    io:format("Subtract: ~p~n", [plot(fun(X) -> X - 1 end)]),
    io:format("Absolute Value: ~p~n", [plot(fun(X) -> abs(X) end)]),
    io:format("Divide & Floor: ~p~n", [plot(fun(X) -> math:floor(X / 3) end)]),

    io:format("~n**********  END  **********~n").
