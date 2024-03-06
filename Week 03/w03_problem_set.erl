% CSE 382 - W02 Problem Set
% Dallin Olson 1/27/2024

-module(w03_problem_set).
-export([main/0]).

% *****************************************************************************
% PROBLEM SET 1
% *****************************************************************************

% 1) Implement the map function described and write test code to convert
% a list of measurements in inches to a list of measurements in centimeters.
% Use the formula 1in = 2.54cm. You will need to modify the test provided in
% the starting code.

map(_Lambda, []) -> [];
map(Lambda, [First|Rest]) -> [Lambda(First)|map(Lambda, Rest)].

% 2) Using the map function you wrote, use a simple cipher to encrypt a list of
% characters. The simple cipher should shift all characters by 1 per the ASCII
% table . For example, “PASSWORD” should be “QBTTXPSE”. In Erlang, a string is
% represented as a list of characters. Therefore, you can list notation with
% strings. Additionally, each character is treated as a number as shown in the
% ASCII table which means you can add numbers to letters. You will need to
% modify the test provided in the starting code.

% 3) Rewrite the map function using a list comprehension and call the new function map_2. Test the new map_2 function in the same way as you tested map with the cipher test above.

map_2(Lambda, List) -> [Lambda(X) || X <- List].

% *****************************************************************************
% PROBLEM SET 2
% *****************************************************************************

% 1) Implement the filter function in Erlang. Use a case block to determine
% whether an item in the list should be included. Test the filter to get a list
% of even numbers from a list using the lambda described in the reading. You
% will need to modify the test provided in the starting code.

filter(_, []) -> [];
filter(Lambda, [First | Rest]) ->
    case Lambda(First) of
        true  -> [First | filter(Lambda, Rest)];
        false -> filter(Lambda, Rest)
    end.

% 2) Rewrite the filter function so that it uses a list comprehension instead of
% using the case. Test the new function with the same lambda function in the
% previous problem. Call the new function filter_2.

filter_2(Lambda, List) ->
    [X || X <- List, Lambda(X)].

% 3) Use the filter functions you wrote to filter a list of temperatures (in
% Celsius) that will support liquid water (as opposed to frozen ice or boiling
% steam).

% 4) Use the filter function you wrote to filter a list of result strings that
% started with the prefix “ERROR:”. Consider using the string:prefix function
% to solve this problem.

% DOES NOT WORK!

% *****************************************************************************
% PROBLEM SET 3
% *****************************************************************************

% 1) Write code in Erlang to demonstrate composition property with the list
% functor. You will not write your code in the test function.

g(X) -> 2 * X.
h(X) -> X * X - 1.
map_composition1(List) ->
    lists:map(fun(X) -> g(h(X)) end, List).
map_composition2(List) ->
    lists:map(fun(X) -> g(X) end, lists:map(fun(X) -> h(X) end, List)).

% Main
main() ->
    io:format("********** START **********~n~n"),

    io:format("Map: ~p~n", [map(fun(Inch) -> Inch * 2.54 end, [1, 2, 3, 4])]),
    io:format("Cipher: ~p~n", [map(fun(C)-> C + 1 end, "Hello there.")]),
    io:format("Map 2: ~p~n", [map_2(fun(C)-> C + 1 end, "Hello there.")]),
    io:format("Filter: ~p~n", [filter(fun(X) -> X rem 2 == 0 end, [1, 2, 3, 4])]),
    io:format("Filter: ~p~n", [filter_2(fun(X) -> X rem 2 == 0 end, [1, 2, 3, 4])]),
    io:format("Filter: ~p~n", [filter_2(fun(T) -> T >= 0 andalso T =< 100 end, [-5, 10, 25, 50, 80, 110])]),

    Results = ["ERROR: Something went wrong",
        "SUCCESS: Operation completed",
        "ERROR: Another error occurred",
        "INFO: This is just information"],
    % DOES NOT WORK!
    % io:format("Filter: ~p~n", [filter_2(fun(Str) -> string:prefix("ERROR:", Str) end, Results)]),

    Numbers = [1, 2, 3, 4, 5],
    io:format("Result λg ∘ λh: ~p~n", [map_composition1(Numbers)]),
    io:format("Result λg And λh Separately: ~p~n", [map_composition2(Numbers)]),

    io:format("~n**********  END  **********~n").