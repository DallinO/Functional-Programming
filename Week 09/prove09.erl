% CSE 382 Prove 09

% (c) BYU-Idaho - It is an honor code violation to post this
% file completed or uncompleted in a public file sharing site. W4.

% Instructions: Use this template file for this prove assignment.
% The details of what to do for each problem are found in
% the reading. IMPORTANT: Comment out code that is not
% running properly.  The `test_ps#` functions should return `ok`.
% When writing tests use the `expected_result` = `actual result` format.

-module(prove09).
-export([test_ps3/0]).

% Problem 1.1
% Using the rank and make functions below, implement the insert function
% per the instructions.
rank(nil) -> 0;
rank({Rank, _, _, _}) -> Rank.

% insert(New_Value, nil) -> make(New_Value, nil, nil);
% insert(New_Value, Node={_, Value, _, _}) when New_Value =< Value ->
%     make(New_Value, nil, Node);
% insert(New_Value, {_, Value, Left, Right})->
%     make(Value, Left, (insert(New_Value, Right))).



% Problem 2.
% Modify the make function below to perform the swap per the instructions.
make(Value, Left, Right) -> 
    Rank_Left = rank(Left),
    Rank_Right = rank(Right),
    case Rank_Left >= Rank_Right of
        true -> {Rank_Right + 1, Value, Left, Right};
        false -> {Rank_Left + 1, Value, Right, Left}
    end.

% Problem 2.2

% merge(Heap1, nil) -> Heap1;
% merge(nil, Heap2) -> Heap2;
% merge({_, Value, Left, Right}, Heap2={_, Value2, Left2, Right2}) when Value =< Value2 ->
%     make(Value, Left, merge(Right, Heap2));
% merge(Heap1, {_, Value, Left, Right}) ->
%     make(Value, Left, merge(Heap1, Right)).

% remove_min({_, _, Left, Right}) -> merge(Left, Right).


% Problem 3.1
% Implement the remove_min/2, insert/3, and merge/3 to take the compare lambda parameter.
% The get_min function is provided for you to support the test code.
get_min(nil) -> nil;
get_min({_, Value, _, _}) -> Value.

remove_min({_, _, Left, Right}, Lambda) -> merge(Left, Right, Lambda).

insert(New_Value, nil, _) -> make(New_Value, nil, nil);
insert(New_Value, Node={_, Value, Left, Right}, Lambda) ->
   case Lambda(New_Value, Value) of
    true -> make(New_Value, nil, Node);
    false -> make(Value, Left, (insert(New_Value, Right, Lambda)))
    end.

merge(Heap1, nil, _) -> Heap1;
merge(nil, Heap2, _) -> Heap2;
merge(Heap1={_, Value, Left, Right}, Heap2={_, Value2, Left2, Right2}, Lambda) ->
  case Lambda(Value, Value2) of
    true -> make(Value, Left, merge(Right, Heap2, Lambda));
    false -> make(Value, Left, merge(Heap1, Right, Lambda))
    end.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Test Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test code for problem set 1%
%test_ps1() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Note that this test code when first executed will not perform the swaps
    % When Problem 2.1 is implemented, this code will behave differently.
%     H = lists:foldl(fun insert/2, nil, [10,15,20,5,12,17,19,20,21,13,8,1]),
%     io:format("~p~n",[H]),

%     % The result without swapping should be:
%      {12,1,nil,
%       {11,5,nil,
%        {10,8,nil,
%         {9,10,nil,
%          {8,12,nil,
%           {7,13,nil,
%            {6,15,nil,
%             {5,17,nil,{4,19,nil,{3,20,nil,{2,20,nil,{1,21,nil,nil}}}}}}}}}}}},

%     ok.

% % Test code for problem set 2
% test_ps2() ->

%     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Test Problem 2.1
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     H = lists:foldl(fun insert/2, nil, [10,15,20,5,12,17,19,20,21,13,8,1]),
%     {1,1,{2,5,{2,10,{1,15,nil,nil},{1,20,nil,nil}},{1,8,{2,12,{2,19,{1,20,nil,nil},{1,21,nil,nil}},{1,13,{1,17,nil,nil},nil}},nil}},nil} = H,

%     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Test Problem 2.2
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     H1 = lists:foldl(fun insert/2, nil, [10,15,20,5,12,17,19]),
%     {3,5,{2,10,{1,15,nil,nil},{1,20,nil,nil}},{2,12,{1,17,nil,nil},{1,19,nil,nil}}} = H1,

%     H2 = remove_min(H1),
%     {2,10,{2,12,{1,17,nil,nil},{1,19,{1,20,nil,nil},nil}},{1,15,nil,nil}} = H2,

%     H3 = remove_min(H2),
%     {2,12,{1,17,nil,nil},{1,15,{1,19,{1,20,nil,nil},nil},nil}} = H3,

%     H4 = remove_min(H3),
%     {2,15,{1,19,{1,20,nil,nil},nil},{1,17,nil,nil}} = H4,

%     H5 = remove_min(H4),
%     {1,17,{1,19,{1,20,nil,nil},nil},nil} = H5,

%     H6 = remove_min(H5),
%     {1,19,{1,20,nil,nil},nil} = H6,

%     H7 = remove_min(H6),
%     {1,20,nil,nil} = H7,

%     H8 = remove_min(H7),
%     nil = H8,

%     ok.

% Test code for problem set 3
test_ps3() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Set the value for Calls_Compare per the instructions to test the new functions you wrote above.
    Calls = [{"EST", 4, "Bob"},{"EST", 1, "Sue"},{"MST", 2, "Tim"},{"PST", 1, "George"},{"CST", 2, "Josh"},{"CST", 3, "Clara"}],
    Calls_Compare = fun({TImeZone, Priority, Name}, {TimeZone2, Priority2, _}) -> Priority =< Priority2 end,

    PQ = lists:foldl(fun (Value, Acc) -> insert(Value,Acc,Calls_Compare) end, nil, Calls),

    {"PST",1,"George"} = get_min(PQ),
    PQ2 = remove_min(PQ, Calls_Compare),

    {"EST",1,"Sue"} = get_min(PQ2),
    PQ3 = remove_min(PQ2, Calls_Compare),

    {"MST",2,"Tim"} = get_min(PQ3),
    PQ4 = remove_min(PQ3, Calls_Compare),

    {"CST",2,"Josh"} = get_min(PQ4),
    PQ5 = remove_min(PQ4, Calls_Compare),

    {"CST",3,"Clara"} = get_min(PQ5),
    PQ6 = remove_min(PQ5, Calls_Compare),

    {"EST",4,"Bob"} = get_min(PQ6),
    nil = remove_min(PQ6, Calls_Compare),


    ok.
