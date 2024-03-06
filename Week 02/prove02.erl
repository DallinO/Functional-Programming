% CSE 382 Prove 02

% (c) BYU-Idaho - It is an honor code violation to post this
% file completed or uncompleted in a public file sharing site. W4.

% Instructions: Use this template file for this prove assignment.
% The details of what to do for each problem are found in
% the reading. IMPORTANT: Comment out code that is not
% running properly.  The `test_ps#` functions should return `ok`.
% When writing tests use the `expected_result` = `actual result` format.

-module(prove02).
-export([test_ps1/0, test_ps2/0, test_ps3/0]).

% Problem 1.1
prepend(List, Value) -> [Value|List].

% Problem 1.2
append([], Value)           -> [Value];
append([First|Rest], Value) -> [First|append(Rest, Value)].

% Problem 1.3
head([])        -> nil;
head([First|_]) -> First.

% Problem 1.4
tail([]) -> nil;
tail([Last])       -> Last;
tail([_|Rest]) -> tail(Rest).

% Problem 2.1
remove_first([])       -> [];
remove_first([_|Rest]) -> Rest.

% Problem 2.2
insert_at(List, _Value, Index) when Index < 0 -> List;
insert_at(List, Value, 0) -> [Value | List];
insert_at([], _Value, _Index) -> [];
insert_at([First|Rest], Value, Index) -> [First | insert_at(Rest, Value, Index-1)].

% Problem 2.3
remove_last([])           -> [];
remove_last([_])          -> [];
remove_last([First|Rest]) -> [First|remove_last(Rest)].

% Problem 2.4
remove_at([_ | Rest], 0)         -> Rest;
remove_at(List, Index) when Index < 1; Index > length(List) -> List;
remove_at([First | Rest], Index) -> [First | remove_at(Rest, Index - 1)].

remove_at_2(Index, List) when is_integer(Index), Index > 0, is_list(List) -> remove_at_2(Index, List, []).
remove_at_2(1, [_ | Tail], Acc) -> lists:reverse(Acc) ++ Tail;
remove_at_2(Index, [Head | Tail], Acc) when Index > 1 -> remove_at_2(Index - 1, Tail, [Head | Acc]);
remove_at_2(_, [], _) -> [].

% Problem 3.1
% Write the specifications and definitions below using comments:
%
% head:
%
% tail:
%
% removeLast:
%
% removeAt:
%

% Problem 3.2
backwards(List)                   -> backwards(List, []).
backwards([], Result)             -> Result;
backwards([First | Rest], Result) -> backwards(Rest, [First | Result]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Test Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test code for problem set 1
test_ps1() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    [0,1,2,3,4] = prepend([1,2,3,4],0),
    [0] = prepend([],0),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    [1,2,3,4,5] = append([1,2,3,4],5),
    [5] = append([],5),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    1 = head([1,2,3,4]),
    nil = head([]),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    4 = tail([1,2,3,4]),
    nil = tail([]),

    ok.

% Test code for problem set 2
test_ps2() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    [2,3,4] = remove_first([1,2,3,4]),
    [] = remove_first([]),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    [0,1,2,3,4] = insert_at([1,2,3,4], 0, 0),
    [1,0,2,3,4] = insert_at([1,2,3,4], 0, 1),
    [1,2,3,0,4] = insert_at([1,2,3,4], 0, 3),
    [1,2,3,4,0] = insert_at([1,2,3,4], 0, 4),
    [1,2,3,4] = insert_at([1,2,3,4], 0, 5),
    [1,2,3,4] = insert_at([1,2,3,4], 0, -1),
    [0] = insert_at([], 0, 0),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    [1,2,3] = remove_last([1,2,3,4]),
    [] = remove_last([]),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    [2,3,4] = remove_at([1,2,3,4], 0),
    [1,3,4] = remove_at([1,2,3,4], 1),
    [1,2,3] = remove_at([1,2,3,4], 3),
    [1,2,3,4] = remove_at([1,2,3,4], 4),
    [1,2,3,4] = remove_at([1,2,3,4], -1),

    ok.

% Test code for problem set 3
test_ps3() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % There is no test code for problem 3.1.

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    [5,4,3,2,1] = backwards([1,2,3,4,5]),
    [] = backwards([]),

    ok.

