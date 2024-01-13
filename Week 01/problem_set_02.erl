% CSE 382 - W02 Problem Set
% Dallin Olson 1/13/2024

-module(problem_set_02).
-export([main/0]).

% 1) Write a stack_push function that treats the list as a stack (LIFO - Last 
% In First Out). The stack_push function will take two parameters, the Stack
% (ie, a list) and a value N. This function should push the value N to the
% front of the Stack.

stack_push(Stack, N) -> [N | Stack].

% 2) Write a stack_pop function that returns a new stack with the first item
% removed. If the stack is empty, then return the empty list [].

stack_pop([]) -> [];
stack_pop([H | T]) -> T. 


% MAIN FUNCION
main() ->
    io:format("********** START **********~n~n"),

    io:format("Stack Push: ~p~n", [stack_push([3, 2, 1], 4)]),
    io:format("Stack Pop: ~p~n", [stack_pop([4,3,2,1])]),

    io:format("~n**********  END  **********~n").