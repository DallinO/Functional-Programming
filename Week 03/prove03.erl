% CSE 382 Prove 03

% (c) BYU-Idaho - It is an honor code violation to post this
% file completed or uncompleted in a public file sharing site. W4.

% Instructions: Use this template file for this prove assignment.
% The details of what to do for each problem are found in
% the reading. IMPORTANT: Comment out code that is not
% running properly.  The `test_ps#` functions should return `ok`.
% When writing tests use the `expected_result` = `actual result` format.

-module(prove03).
-export([test_ps1/0, test_ps2/0, test_ps3/0]).

% Problem 1.1
map(_, []) -> [];
map(Lambda, [First|Rest]) -> [Lambda(First)|map(Lambda, Rest)].

% Problem 1.3
map_2(Lambda, List) -> [Lambda(X) || X <- List].

% Problem 2.1
filter(_, []) -> [];
filter(Lambda, [First|Rest]) ->
    case Lambda(First) of
        true ->
            [First | filter(Lambda, Rest)];
        false ->
            filter(Lambda, Rest)
    end.

filter_2(_, []) -> [];
filter_2(Lambda, List) ->
    [X || X <- List, Lambda(X)].


% Problem 2.2



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Test Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test code for problem set 1
test_ps1() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Modify the test code below to convert a list of measurements
    Data_In = [1, 2, 3, 4, 5],
    In_to_Cm_Lambda = fun(X) -> X * 2.54 end,
    Data_Cm = map(In_to_Cm_Lambda, Data_In),
    [2.54, 5.08, 7.62, 10.16, 12.7] = Data_Cm,

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Modify the test code below to implement a simple cipher using map
	Password = "PASSWORD",
    Cipher_Lambda = fun(X) -> X + 1 end,
    Encrypted = map(Cipher_Lambda, Password),
    "QBTTXPSE" = Encrypted,

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code below to implement a simple cipher using map2
    Password = "PASSWORD",
    Encrypted = map_2(Cipher_Lambda, Password),
    "QBTTXPSE" = Encrypted,

    ok.

% Test code for problem set 2
test_ps2() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Modify the test code below to get the even numbers from a list using filter
    Numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    Even_Lambda = fun(X) -> X rem 2 == 0 end,
    Even_Numbers = filter(Even_Lambda, Numbers),
    [2, 4, 6, 8, 10] = Even_Numbers,

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code below to get the even numbers from a list using filter2
    Numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    Even_Numbers = filter_2(Even_Lambda, Numbers),
    [2, 4, 6, 8, 10] = Even_Numbers,


    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Modify the test code to get liquid temperatures from a list using filter
	[20, 80] = filter(fun(C) -> C >= 0 andalso C =< 100 end, [-10, 20, -15, 110, 80]),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    Messages = ["INFO: Reading the data",
        "INFO: Validating the data",
        "WARNING: Missing meta data",
        "ERROR: Column 2 Row 5 expected number",
        "WARNING: Row 12 unexpected line terminator",
        "INFO: Validation complete",
        "INFO: Processing data",
        "ERROR: Command 7 unknown",
        "INFO: Processing complete"],

    % Write test code using the Messages variable above to get only
    % ERROR messages using filter.
    Result = [
        "ERROR: Column 2 Row 5 expected number",
        "ERROR: Command 7 unknown"],
    Error_Lambda = fun(Message) ->
        case string:prefix(Message, "ERROR") of
            nomatch -> false;
            _ -> true
        end
    end,
    Result = filter_2(Error_Lambda, Messages),
    ok.

% Test code for problem set 3
test_ps3() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % List of values to use in the demonstration
    Values = [1, 2, 3, 4],

    % Create the lambda functions
    G = fun(X) -> X * 2 end,
    H = fun(X) -> X * X - 1 end,

    % Left Side of Composition Property
    [0,6,16,30] = map_2(fun(X) -> G(H(X)) end, Values),

    % Right Side of Composition Property
    [0,6,16,30] = map_2(G, map_2(H, Values)),

    ok.
