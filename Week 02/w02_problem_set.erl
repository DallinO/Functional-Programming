% CSE 382 - W02 Problem Set
% Dallin Olson 1/22/2024

-module(w02_problem_set).          
-export([main/0]).

% *****************************************************************************
% PROBLEM SET 1
% *****************************************************************************

% 1) Implement the prepend function.

prepend(List, Value) -> [Value|List].

% 2) Implement the append function.

append([], Value)           -> [Value];
append([First|Rest], Value) -> [First | append(Rest, Value)].

% 3) To do some additional practice with lists, write a head function that will
% return the first item in the list. If the list is empty, then return the atom
% nil.

head([])        -> nil;
head([First|_]) -> First.

% 4) Implement a tail function that will return the last item in the list. The
% tail function will need to use recursion just like the append function. If
% the list is empty, then return nil.

tail([])       -> nil;
tail([Last])   -> Last;
tail([_|Rest]) -> tail(Rest).

% *****************************************************************************
% PROBLEM SET 2
% *****************************************************************************

% 1) Implement the remove_first.

remove_first([]) -> [];
remove_first([_First|Rest]) -> Rest.

% 2) Implement insert_at function.

insert_at(List, _Value, Index) when Index < 0 -> List;
insert_at(List, Value, 0) -> [Value | List];
insert_at([], _Value, _Index) -> [];
insert_at([First|Rest], Value, Index) -> [First | insert_at(Rest, Value, Index-1)].

% 3) Implement a function called remove_last that removes the last item in the
% list. If the list is empty, then return an empty list.

remove_last([])           -> [];
remove_last([_])          -> [];
remove_last([First|Rest]) -> [First|remove_last(Rest)].

% 4) Implement a function called remove_at like the insert_at function which
% removes an item at a specific index. Notice that this function does not have
% a Value parameter since we are removing. Additionally, unlike insert_at,
% specifying an index equal to the length of the list is considered an invalid
% index. If the index is invalid (too small or too big), then return the
% original list.

remove_at(List, Index) when Index < 1; Index > length(List) -> List;
remove_at([_ | Rest], 1)         -> Rest;
remove_at([First | Rest], Index) -> [First | remove_at(Rest, Index - 1)].

% *****************************************************************************
% PROBLEM SET 3
% *****************************************************************************

% 1) Write the specifications and definitions for the head, tail, removeLast,
% and removeAt functions. You will write these in your code template as comments.

% spec head:: [a] -> a
% def head:: [] -> nil
% def head:: [First|Rest] -> First

% spec tail:: [a] -> a
% def tail:: [] -> nil;
% def tail:: [Last]  -> Last;
% def tail:: [First|Rest]) -> tail(Rest).

% spec remove_last:: [a] -> [a]
% def remove_last:: [] -> [];
% def remove_last:: [Rest] -> [];
% def remove_last:: [First|Rest] -> [First|remove_last(Rest)].

% spec remove_at:: [a] -> [a]
% def remove_at:: List Index WHEN Index < 1 OR Index > length(List) -> List;
% def remove_at:: [First | Rest] 1) -> Rest;
% def remove_at:: [First | Rest] Index) -> [First | remove_at(Rest Index - 1)].

% 2) Implement a function called backwards (which does the same thing as the
% reverse function found in Erlang for lists). The specification and definition
% of this functions is shown below. Notice there are two specifications because
% there is a one arity function (called by the user in the test code) and a two
% arity function (called recursively with the result list). You will need to
% implement both specifications.

backwards(List)                   -> backwards(List, []).
backwards([], Result)             -> Result;
backwards([First | Rest], Result) -> backwards(Rest, [First | Result]).


main() ->
    io:format("********** START **********~n~n"),

    io:format("Prepended List: ~p~n", [prepend([1, 2, 3], 4)]),
    io:format("Appended List: ~p~n", [append([1, 2, 3], 4)]),
    io:format("Head: ~p~n", [head([1, 2, 3])]),
    io:format("Tail: ~p~n", [tail([1, 2, 3])]),
    io:format("Remove First: ~p~n", [remove_first([1, 2, 3])]),
    io:format("Insert: ~p~n", [insert_at([1, 2, 3], 4, 1)]),
    io:format("Remove Last: ~p~n", [remove_last([1, 2, 3])]),
    io:format("Remove At: ~p~n", [remove_at([1, 2, 3], 0)]),
    io:format("Backwards: ~p~n", [backwards([1, 2, 3])]),

    io:format("~n**********  END  **********~n").