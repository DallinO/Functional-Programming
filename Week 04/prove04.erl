% CSE 382 Prove 04

% (c) BYU-Idaho - It is an honor code violation to post this
% file completed or uncompleted in a public file sharing site. W4.

% Instructions: Use this template file for this prove assignment.
% The details of what to do for each problem are found in
% the reading. IMPORTANT: Comment out code that is not
% running properly.  The `test_ps#` functions should return `ok`.
% When writing tests use the `expected_result` = `actual result` format.

-module(prove04).
-export([test_ps1/0, test_ps2/0, test_ps3/0]).

% Problem 1.1

fold(_Lambda, Acc, []) -> Acc;
fold(Lambda, Acc, [First|Rest]) -> fold(Lambda, Lambda(First, Acc), Rest).

% Problem 2.1

foldr(_Lambda, Acc, []) -> Acc;
foldr(Lambda, Acc, [First|Rest]) -> Lambda(First, foldr(Lambda, Acc, Rest)).

% Problem 3.1

unfold(0, _Curr, _Lambda) -> [];
unfold(Count, Curr, Lambda) -> [Curr|unfold(Count-1, Lambda(Curr), Lambda)].

% Problem 3.4

range(Start, Size, Step) ->
    RangeLambda = fun(Curr) -> Curr + Step end,
    unfold(Size, Start, RangeLambda).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Test Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test code for problem set 1
test_ps1() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write the lambda function and call the fold to find the sum
    Sum = fun(Value, Acc) -> Acc + Value end,
    55 = fold(Sum, 0, [1,2,3,4,5,6,7,8,9,10]),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write the lambda function and call the fold to concatenate the strings.
    Concat = fun(String, Acc) -> Acc ++ String end,
    "ABCD" = fold(Concat, "", ["A","B","C","D"]),
    "OneTwoThreeFour" = fold(Concat, "", ["One","Two","Three","Four"]),
    "Mary had a little lamb" = fold(Concat, "", ["Mary"," ","had"," ","a"," ","little"," ","lamb"]),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write the lambda function and call the fold to count the items in a list
    Count = fun(_Element, Acc) -> Acc + 1 end,
    8 = fold(Count, 0, [4,2,7,9,10,25,-3,0]),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write the lambda function and call the fold to reverse a list
    Reverse = fun(Element, Acc) -> [Element|Acc] end,
    [7,5,3,1] = fold(Reverse, [], [1,3,5,7]),

    ok.

% Test code for problem set 2
test_ps2() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Using the same lambda function from problem 1.2, test the foldr function that you wrote.
    Concat = fun(String, Acc) -> Acc ++ String end,
    "DCBA" = foldr(Concat, "", ["A","B","C","D"]),
    "FourThreeTwoOne" = foldr(Concat, "", ["One","Two","Three","Four"]),
    "lamb little a had Mary" = foldr(Concat, "", ["Mary"," ","had"," ","a"," ","little"," ","lamb"]),

    ok.

% Test code for problem set 3
test_ps3() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code using unfold to generate an arithmetic sequence as instructed
    Arithmetic = fun(Curr) -> Curr + 5 end,
    [5, 10, 15, 20, 25, 30] = unfold(6, 5, Arithmetic),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code using unfold to generate a geometric sequence as instructed
    Geometric = fun(Curr) -> Curr / 2 end,
    [1, 0.5, 0.25, 0.125, 0.0625, 0.03125] = unfold(6, 1, Geometric),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    [3,7,11,15,19] = range(3,5,4),
    [10,20,30,40,50,60] = range(10, 6, 10),


    ok.
