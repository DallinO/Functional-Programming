% CSE 382 Prove 10

% (c) BYU-Idaho - It is an honor code violation to post this
% file completed or uncompleted in a public file sharing site. W4.

% Instructions: Use this template file for this prove assignment.
% The details of what to do for each problem are found in
% the reading. IMPORTANT: Comment out code that is not
% running properly.  The `test_ps#` functions should return `ok`.
% When writing tests use the `expected_result` = `actual result` format.

-module(prove10).
-export([test_ps1/0, test_ps2/0, test_ps3/0]).

% Problem 1.1
-record(ral_tree, {type = node, count = 0, left = nil, right = nil}).
-record(leaf, {type = leaf, value}).

merge(Carry_Tree, []) -> 
    [Carry_Tree];
merge(Carry_Tree, [nil | Rest_Trees]) ->
    [Carry_Tree | Rest_Trees];
merge(Carry_Tree, [Tree | Rest_Trees]) ->
    Merged_Tree = {},
    [nil | merge(Merged_Tree, Rest_Trees)].

count(Merged_Tree)

prepend(Value, RAL) -> merge({leaf, Value}, RAL).

% Problem 2.1

lookup_in_tree()

lookup(Index, RAL) when Index < 0 -> nil;
lookup(Index, []) -> nil;
lookup(Index, [nil|Rest_Trees]) -> lookup(Index, Rest_Trees);
lookup(Index, [Tree|Rest_Trees]) when Index >= (count(Tree)) -> 
    lookup(Index - (count(Tree)), Rest_Trees);
lookup(Index, [Tree|Rest_Trees]) -> lookup_in_tree(Index, Tree).

update_in_tree()

update(Index, Value, RAL) when Index < 0 -> RAL;
update(Index, Value, []) -> [];
update(Index, Value, [nil|Rest_Trees]) -> update(Index, Value, Rest_Trees);
update(Index, Value, [Tree|Rest_Trees]) when Index >= (count(Tree)) -> [Tree|(update(Index - (count(Tree)), Value, Rest_Trees))];
update(Index, Value, [Tree|Rest_Trees]) -> [update_in_tree(Index, Value, Tree)].


% Problem 2.2



% Code for use in Problem 3.1
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
    %RAL1 = prepend(100, []),
    %[{leaf,100}] = RAL1,

    %RAL2 = prepend(200, RAL1),
    %[nil,
    % {node,2,{leaf,200},{leaf,100}}
    %] = RAL2,

    %RAL3 = prepend(300, RAL2),
    %[{leaf,300},
    % {node,2,{leaf,200},{leaf,100}}
    %] = RAL3,

    %RAL4 = prepend(400, RAL3),
    %[nil,
    % nil,
    % {node,4,{node,2,{leaf,400},{leaf,300}},{node,2,{leaf,200},{leaf,100}}}
    %] = RAL4,

    %RAL5 = prepend(500, RAL4),
    %[{leaf,500},
    % nil,
    % {node,4,{node,2,{leaf,400},{leaf,300}},{node,2,{leaf,200},{leaf,100}}}
    %] = RAL5,

    %RAL6 = prepend(600, RAL5),
    %[nil,
    % {node,2,{leaf,600},{leaf,500}},
    % {node,4,{node,2,{leaf,400},{leaf,300}},{node,2,{leaf,200},{leaf,100}}}
    %] = RAL6,

    %RAL7 = prepend(700, RAL6),
    %[{leaf,700},
    % {node,2,{leaf,600},{leaf,500}},
    % {node,4,{node,2,{leaf,400},{leaf,300}},{node,2,{leaf,200},{leaf,100}}}
    %] = RAL7,

    %RAL8 = prepend(800, RAL7),
    %[nil,
    % nil,
    % nil,
    % {node,8,{node,4,{node,2,{leaf,800},{leaf,700}},{node,2,{leaf,600},{leaf,500}}},{node,4,{node,2,{leaf,400},{leaf,300}},{node,2,{leaf,200},{leaf,100}}}}
    %] = RAL8,

    ok.

% Test code for problem set 2
test_ps2() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    %RAL1 = prepend(100, []),
    %RAL2 = prepend(200, RAL1),
    %RAL3 = prepend(300, RAL2),
    %RAL4 = prepend(400, RAL3),
    %RAL5 = prepend(500, RAL4),
    %RAL6 = prepend(600, RAL5),
    %RAL7 = prepend(700, RAL6),
    %nil = lookup(7,RAL7),  % Invalid Index
    %nil = lookup(-1,RAL7), % Invalid Index
    %700 = lookup(0,RAL7),
    %600 = lookup(1,RAL7),
    %500 = lookup(2,RAL7),
    %400 = lookup(3,RAL7),
    %300 = lookup(4,RAL7),
    %200 = lookup(5,RAL7),
    %100 = lookup(6,RAL7),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %RAL7 = update(7,1000,RAL7),  % Invalid Index
    %RAL7 = update(-1,1000,RAL7), % Invalid Index

    %RAL8 = update(0,888,RAL7),
    %[{leaf,888},
    % {node,2,{leaf,600},{leaf,500}},
    % {node,4,{node,2,{leaf,400},{leaf,300}},{node,2,{leaf,200},{leaf,100}}}
    %] = RAL8,

    %RAL9 = update(4,333,RAL8),
    %[{leaf,888},
    % {node,2,{leaf,600},{leaf,500}},
    % {node,4,{node,2,{leaf,400},{leaf,333}},{node,2,{leaf,200},{leaf,100}}}
    %] = RAL9,

    %RAL10 = update(6,111,RAL9),
    %[{leaf,888},
    % {node,2,{leaf,600},{leaf,500}},
    % {node,4,{node,2,{leaf,400},{leaf,333}},{node,2,{leaf,200},{leaf,111}}}
    %] = RAL10,

    ok.

% Test code for problem set 3
test_ps3() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Add test code to compare the performance of RAL with
    % Erlang list per the instructions

    %List1 = lists:seq(0,999999),
    %start_perf(),
    %999999 = lists:nth(1000000, List1),
    %stop_perf("list lookup last one"),


    %start_perf(),

    %stop_perf("ral lookup last one"),

    % Observations (see instructions):

    ok.
