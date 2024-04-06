% CSE 382 Prove 08

% (c) BYU-Idaho - It is an honor code violation to post this
% file completed or uncompleted in a public file sharing site. W4.

% Instructions: Use this template file for this prove assignment.
% The details of what to do for each problem are found in
% the reading. IMPORTANT: Comment out code that is not
% running properly.  The `test_ps#` functions should return `ok`.
% When writing tests use the `expected_result` = `actual result` format.

-module(prove08).
-export([test_ps1/0, test_ps2/0, test_ps3/0]).

% Problem 1.1

add(NewValue, nil) ->
    {NewValue, nil, nil};
add(NewValue, {Value, Left, Right}) when NewValue < Value ->
    {Value, add(NewValue, Left), Right};
add(NewValue, {Value, Left, Right}) when NewValue > Value ->
    {Value, Left, add(NewValue, Right)};
add(NewValue, Node) ->
    Node.

% Problem 1.2
contains(_, nil) ->
    false;
contains(Value, {Value, _, _}) ->
    true;
contains(Value, {NodeValue, Left, _}) when Value < NodeValue ->
    contains(Value, Left);
contains(Value, {NodeValue, _, Right}) when Value > NodeValue ->
    contains(Value, Right).

% Problem 2.1
% Finish the add_rbt by implementing add_rbt_ and the remaining scenarios
% for the balance function (scenario 1 is already implemented) per the instructions.
% Function to add a value to a red-black tree
add_rbt(NewValue, Tree) ->
    {_Color, Value, Left, Right} = add_rbt_(NewValue, Tree),
    {black, Value, Left, Right}.

add_rbt_(NewValue, nil) ->
    {red, NewValue, nil, nil};
add_rbt_(NewValue, {Color, Value, Left, Right}) when NewValue < Value ->
    balance({Color, Value, add_rbt_(NewValue, Left), Right});
add_rbt_(NewValue, {Color, Value, Left, Right}) when NewValue > Value ->
    balance({Color, Value, Left, add_rbt_(NewValue, Right)});
add_rbt_(NewValue, Node) ->
    Node.

% Helper function to balance the red-black tree
balance({black, Z, {red, X, A, {red, Y, B, C}}, D}) ->
    {red, Y, {black, X, A, B}, {black, Z, C, D}};
balance({black, X, A, {red, Y, B, {red, Z, C, D}}}) ->
    {red, Y, {black, X, A, B}, {black, Z, C, D}};
balance({black, X, A, {red, Z, {red, Y, B, C}, D}}) ->
    {red, Y, {black, X, A, B}, {black, Z, C, D}};
balance({black, Z, {red, Y, {red, X, A, B}, C}, D}) ->
    {red, Y, {black, X, A, B}, {black, Z, C, D}};
balance(Node) ->
    Node. % No need for balancing if the pattern doesn't match

% Problem 2.2

contains_rbt(_, nil) ->
    false;
contains_rbt(Value, {_, Value, _, _}) ->
    true;
contains_rbt(Value, {_, NodeValue, Left, _}) when Value < NodeValue ->
    contains_rbt(Value, Left);
contains_rbt(Value, {_, NodeValue, _, Right}) when Value > NodeValue ->
    contains_rbt(Value, Right).


% The following functions are fully implemented for use by the Problem 3.1 test
% code.
start_perf() ->
    eprof:start_profiling([self()]).

stop_perf(Title) ->
    io:format("Perf (~p): ~n",[Title]),
    eprof:stop_profiling(),
    eprof:analyze(total).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Test Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test code for problem set 1
test_ps1() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    L1 = add(5, nil),
    {5,nil,nil} = L1,

    L2 = add(3, L1),
    {5,{3,nil,nil},nil} = L2,

    L3 = add(7, L2),
    {5,{3,nil,nil},{7,nil,nil}} = L3,

    L4 = add(4, L3),
    {5,{3,nil,{4,nil,nil}},{7,nil,nil}} = L4,

    L5 = add(2, L4),
    {5,{3,{2,nil,nil},{4,nil,nil}},{7,nil,nil}} = L5,

    L6 = add(6, L5),
    {5,{3,{2,nil,nil},{4,nil,nil}},{7,{6,nil,nil},nil}} = L6,

    L7 = add(8, L6),
    {5,{3,{2,nil,nil},{4,nil,nil}},{7,{6,nil,nil},{8,nil,nil}}} = L7,

    L8 = add(5, L7), % Check a duplicate value
    {5,{3,{2,nil,nil},{4,nil,nil}},{7,{6,nil,nil},{8,nil,nil}}} = L8,

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    false = contains(1, L8),
    true = contains(2, L8),
    true = contains(3, L8),
    true = contains(4, L8),
    true = contains(5, L8),
    true = contains(6, L8),
    true = contains(7, L8),
    true = contains(8, L8),
    false = contains(9, L8),

    ok.

% Test code for problem set 2
test_ps2() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    L1 = add_rbt(5, nil),
    io:format("~p~n", [L1]),
    {black,5,nil,nil} = L1,

    L2 = add_rbt(3, L1),
    io:format("~p~n", [L2]),
    {black,5,{red,3,nil,nil},nil} = L2,

    L3 = add_rbt(7, L2),
    {black,5,{red,3,nil,nil},{red,7,nil,nil}} = L3,

    L4 = add_rbt(4, L3),
    {black,4,{black,3,nil,nil},{black,5,nil,{red,7,nil,nil}}} = L4,

    L5 = add_rbt(2, L4),
    {black,4,{black,3,{red,2,nil,nil},nil},{black,5,nil,{red,7,nil,nil}}} = L5,

    L6 = add_rbt(6, L5),
    {black,4,{black,3,{red,2,nil,nil},nil},{red,6,{black,5,nil,nil},{black,7,nil,nil}}} = L6,

    L7 = add_rbt(8, L6),
    {black,4,{black,3,{red,2,nil,nil},nil},{red,6,{black,5,nil,nil},{black,7,nil,{red,8,nil,nil}}}} = L7,

    L8 = add_rbt(10, L7),
    {black,6,{black,4,{black,3,{red,2,nil,nil},nil},{black,5,nil,nil}},{black,8,{black,7,nil,nil},{black,10,nil,nil}}} = L8,

    L9 = add_rbt(1, L8),
    {black,6,{black,4,{red,2,{black,1,nil,nil},{black,3,nil,nil}},{black,5,nil,nil}},{black,8,{black,7,nil,nil},{black,10,nil,nil}}} = L9,

    L10 = add_rbt(0, L9),
    {black,6,{black,4,{red,2,{black,1,{red,0,nil,nil},nil},{black,3,nil,nil}},{black,5,nil,nil}},{black,8,{black,7,nil,nil},{black,10,nil,nil}}} = L10,

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    false = contains_rbt(-1, L10),
    true = contains_rbt(2, L10),
    true = contains_rbt(3, L10),
    true = contains_rbt(4, L10),
    true = contains_rbt(5, L10),
    true = contains_rbt(6, L10),
    true = contains_rbt(7, L10),
    true = contains_rbt(8, L10),
    false = contains_rbt(9, L10),

    ok.

% Test code for problem set 3
test_ps3() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Write test code to compare performance of the binary search tree
    % and the red black tree per the instructions.  You can use the List
    % variable below when performing the foldl functions.  Add your code
	% in between the start_perf and stop_perf function calls.

    List = lists:seq(1,10000),
    start_perf(),
    T1 = lists:foldl(fun add/2, nil, List),

    stop_perf("add"),

    start_perf(),
    T2 = lists:foldl(fun add_rbt/2, nil, List),

    stop_perf("add_rbt"),

    start_perf(),
    contains(10000, T1),
    stop_perf("contains"),

    start_perf(),
    contains_rbt(10000, T2),
    stop_perf("contains_rbt"),

    % Observations (see instructions):

    ok.
