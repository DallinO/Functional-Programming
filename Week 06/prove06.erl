% CSE 382 Prove 06

% (c) BYU-Idaho - It is an honor code violation to post this
% file completed or uncompleted in a public file sharing site. W4.

% Instructions: Use this template file for this prove assignment.
% The details of what to do for each problem are found in
% the reading. IMPORTANT: Comment out code that is not
% running properly.  The `test_ps#` functions should return `ok`.
% When writing tests use the `expected_result` = `actual result` format.

-module(prove06).
-export([test_ps1/0, test_ps2/0, test_ps3/0]).

% Problem 1.1

-record(account, {owner::string(), identifier::string(), balance::float()}).

combine_accounts(Account1, nil) -> Account1;
combine_accounts(nil, Account2) -> Account2;
combine_accounts(Account1 = #account{balance=Balance1}, Account2 = #account{balance=Balance2}) when Balance1 > Balance2 ->
    #account{owner=Account1#account.owner, identifier=Account1#account.identifier, balance=Balance1 + Balance2};
combine_accounts(Account1, Account2) ->
    #account{owner=Account2#account.owner, identifier=Account2#account.identifier, balance=Account1#account.balance + Account2#account.balance}.

combine_accounts_2(Account1, nil) -> Account1;
combine_accounts_2(nil, Account2) -> Account2;
combine_accounts_2(Account1, Account2) when element(3, Account1) > element(3, Account2) ->
    {element(1, Account1), element(2, Account1), element(3, Account1) + element(3, Account2)};
combine_accounts_2(Account1, Account2) ->
    {element(1, Account2), element(2, Account2), element(3, Account1) + element(3, Account2)}.

% Problem 1.3

combine_functions(nil, F) -> F;
combine_functions(F, nil) -> F;
combine_functions(F1, F2) ->
    fun(X) -> F2(F1(X)) end.

% Problem 2.1

cut_half(Number) when Number > 1 ->
    Result = Number / 2,
    Remainder = Number rem 2,
    if
        Remainder == 0 ->
            {ok, trunc(Result)};
        true ->
            {fail}
    end;
cut_half(_) -> {fail}.

maybe_unit(Value) -> {ok, Value}.

maybe_bind({ok, Value}, Lambda) -> Lambda(Value);
maybe_bind({fail}, _) -> {fail}.


% Problem 2.2
% The following 3 check functions already return the Result Monad type as described in the instructions.
% Implement the result_unit and result_bind functions.

result_bind({ok}, Password, Lambda) ->
    case Lambda(Password) of
        {ok} -> {ok};
        {error, Errors} -> {error, Errors}
    end;
result_bind({error, PrevErrors}, Password, Lambda) ->
    case Lambda(Password) of
        {ok} -> {error, PrevErrors};
        {error, Errors} -> {error, lists:append(PrevErrors, Errors)}
    end.


result_unit() -> {ok}.







check_mixed_case(Password) ->
    UpperExists = lists:foldl(fun (Letter, Result) -> Result or ((Letter >= 65) and (Letter =< 90)) end, false, Password),
    LowerExists = lists:foldl(fun (Letter, Result) -> Result or ((Letter >= 97) and (Letter =< 172)) end, false, Password),
    if
        UpperExists and LowerExists -> {ok};
        UpperExists -> {error,["Must have at least one lower case letter."]};
        LowerExists -> {error,["Must have at least one upper case letter."]};
        true -> {error,["Must have at least one upper case and one lower case letter."]}
    end.

check_number_exists(Password) ->
    NumberExists = lists:foldl(fun (Letter, Result) -> Result or ((Letter >= 48) and (Letter =< 57)) end, false, Password),
    if
        NumberExists -> {ok};
        true -> {error,["Must have at least one number."]}
    end.

check_length(Password) ->
    if
        length(Password) < 8 -> {error,["Must be at least 8 characters long."]};
        true -> {ok}
    end.


% Problem 3.1
% Most of the list monad code is provided below.  Implement the pop and bind functions.
create() -> {nil, 0}.

push(Value, List) -> {{Value, List},1}.

len({_List, Length}) -> Length.

value({List, _Length}) -> List.

pop(nil) -> create();
pop({First, Rest}) -> {Rest, -1}.

bind({List, Length}, Lambda, Operational_Parameters) -> 
    {New_list, Delta_Length} = erlang:apply(Lambda, Operational_Parameters ++ [List]),
    {New_list, Length + Delta_Length}.


% Problem 3.2
% The push2 function is implemented below.  Implement the pop2 and bind2 per the instructions.
push2(Value, List) -> {ok, {{Value, List},1}}.

pop2(nil) -> {fail};
pop2({First, Rest}) -> {ok, {Rest, -1}}.

bind2({List, Length}, Lambda, Operational_Parameters) -> 
    case erlang:apply(Lambda, Operational_Parameters ++ [List]) of
        {ok, {New_list, Delta_Length}} -> {New_list, Length + Delta_Length};
        {fail} -> {List, Length}
    end.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Test Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test code for problem set 1
test_ps1() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    A1 = {"Bob", "1234", 100},
    A2 = {"Tim", "2424", 600},
    A3 = {"Sue", "5851", 500},

    A4 = #account{owner="Bob", identifier="1234", balance=100},
    A5 = #account{owner="Tim", identifier="2424", balance=600},
    A6 = #account{owner="Sue", identifier="5851", balance=500},

    % Write test code to demonstrate the associative property with combineAccounts using the 3 accounts above
    {"Tim","2424",1200} = combine_accounts_2(A1, combine_accounts_2(A2, A3)),
    {"Tim","2424",1200} = combine_accounts_2(combine_accounts_2(A1, A2), A3),

    {account,"Tim","2424",1200} = combine_accounts(A4, combine_accounts(A5, A6)),
    {account,"Tim","2424",1200} = combine_accounts(combine_accounts(A4, A5), A6),


    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    A7 = {"Edward", "8879", 3000},
    A8 = {"George", "5546", 50},

    % Write test code using a fold to combine all 5 accounts into one account for Bob (A1)
    Accounts = [
        A1,
        A2,
        A3,
        A7,
        A8
    ],
    {"Edward", "8879", 4250} = lists:foldl(fun combine_accounts_2/2, nil, Accounts),

    % OR ???

    {"Edward", "8879", 4250} = combine_accounts_2(combine_accounts_2(combine_accounts_2(combine_accounts_2(A1, A2), A3), A7), A8),


    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    F1 = fun string:to_upper/1,
    F2 = fun string:trim/1,
    F3 = fun string:reverse/1,

    % Write test code to demonstrate the associate property of combineFunctions using the 3 functions above
    Combined_F1 = combine_functions(combine_functions(F1, F2), F3),
    Combined_F2 = combine_functions(F1, combine_functions(F2, F3)),

    "FEDCBA" = Combined_F1("   abCDef  "),
    "FEDCBA" = Combined_F2("   abCDef  "),


    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code to combine all three functions in the previous problem using a foldl per the instructions
    All_Combined = lists:foldl(fun(F, Acc) -> combine_functions(F, Acc) end, nil, [F1, F2, F3]),
    "FEDCBA" = All_Combined("   abCDef  "),


    ok.

% Test code for problem set 2
test_ps2() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    {ok,4} = cut_half(8),
    {fail} = cut_half(5),
    {fail} = cut_half(-1),
    {ok,50} = maybe_bind(maybe_bind(maybe_unit(200), fun cut_half/1), fun cut_half/1),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    Password1 = "simple",
    Result1 = result_bind(result_bind(result_bind(result_unit(), Password1, fun check_mixed_case/1), Password1, fun check_number_exists/1), Password1, fun check_length/1),
    io:format("Result1 = ~p~n",[Result1]), % Should show error with all three errors in the list

    Password2 = "mostlygood23",
    Result2 = result_bind(result_bind(result_bind(result_unit(), Password2, fun check_mixed_case/1), Password2, fun check_number_exists/1), Password2, fun check_length/1),
    io:format("Result2 = ~p~n",[Result2]), % Should show error with one error about missing an upper case letter

    Password3 = "GoodPassword42",
    Result3 = result_bind(result_bind(result_bind(result_unit(), Password3, fun check_mixed_case/1), Password3, fun check_number_exists/1), Password3, fun check_length/1),
    io:format("Result3 = ~p~n",[Result3]), % Should show ok

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Modify the test code below to replace `put_your_fold_here` with a foldl to do the same chaining as the previous problem
    CheckFuns = [fun check_mixed_case/1, fun check_number_exists/1, fun check_length/1],
    Result1_With_Fold = lists:foldl(fun(CheckFun, Acc) -> result_bind(Acc, Password1, CheckFun) end, result_unit(), CheckFuns),

    io:format("Result1_With_Fold = ~p~n",[Result1_With_Fold]),

    Result2_With_Fold = lists:foldl(fun(CheckFun, Acc) -> result_bind(Acc, Password2, CheckFun) end, result_unit(), CheckFuns),
    io:format("Result2_With_Fold = ~p~n",[Result2_With_Fold]),

    Result3_With_Fold = lists:foldl(fun(CheckFun, Acc) -> result_bind(Acc, Password3, CheckFun) end, result_unit(), CheckFuns),
    io:format("Result3_With_Fold = ~p~n",[Result3_With_Fold]),

    ok.

% Test code for problem set 3
test_ps3() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    L1 = create(),
    nil = value(L1),
    0 = len(L1),

    L2 = bind(L1, fun push/2, [2]),
    {2,nil} = value(L2),
    1 = len(L2),

    L3 = bind(L2, fun push/2, [4]),
    {4,{2,nil}} = value(L3),
    2 = len(L3),

    L4 = bind(L3, fun push/2, [6]),
    {6,{4,{2,nil}}} = value(L4),
    3 = len(L4),

    L5 = bind(L4, fun pop/1, []),
    {4,{2,nil}} = value(L5),
    2 = len(L5),

    L6 = bind(L5, fun push/2, [8]),
    {8,{4,{2,nil}}} = value(L6),
    3 = len(L6),

    L7 = bind(L6, fun pop/1, []),
    {4,{2,nil}} = value(L7),
    2 = len(L7),

    L8 = bind(L7, fun pop/1, []),
    {2,nil} = value(L8),
    1 = len(L8),

    L9 = bind(L8, fun pop/1, []),
    nil = value(L9),
    0 = len(L9),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    L10 = bind2(L9, fun push2/2, [100]),
    {100, nil} = value(L10),
    1 = len(L10),

    L11 = bind2(L10, fun push2/2, [200]),
    {200, {100, nil}} = value(L11),
    2 = len(L11),

    L12 = bind2(L11, fun pop2/1, []),
    {100, nil} = value(L12),
    1 = len(L12),

    L13 = bind2(L12, fun pop2/1, []),
    nil = value(L13),
    0 = len(L13),

    L14 = bind2(L13, fun pop2/1, []),
    nil = value(L14),
    0 = len(L14),

    ok.
