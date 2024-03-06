% CSE 382 Prove 07

% (c) BYU-Idaho - It is an honor code violation to post this
% file completed or uncompleted in a public file sharing site. W4.

% Instructions: Use this template file for this prove assignment.
% The details of what to do for each problem are found in
% the reading. IMPORTANT: Comment out code that is not
% running properly.  The `test_ps#` functions should return `ok`.
% When writing tests use the `expected_result` = `actual result` format.

-module(prove07).
-export([test_ps1/0, test_ps2/0, test_ps3/0, handle_server/0]).

% Problem 1.1
% Modify the code below to add the Step parameter per the instructions.
range(Start, Stop, _) when Start =:= Stop ->
    fun () -> {undefined, done} end;
range(Start, Stop, Step) when (Step =/= 0) and (Step * (Stop - Start) > 0) ->
    fun () -> {Start, range(Start + Step, Stop, Step)} end;
range(_, _, _) ->
    fun () -> {undefined, done} end.


% Problem 1.2
% Implement the words stream function using the first_word function provided below
first_word(Text) ->
    Result = string:split(Text," "),
    case Result of
        [Word,Rest] -> {Word, Rest};
        [Word] -> {Word, ""}
    end.

words(Text) ->
    fun () ->
        {Word, Rest} = first_word(Text),
        case Word of
            "" -> {undefined, done};
            _ -> {Word, words(Rest)}
        end
    end.

% Problem 2.1
% The iter and next functions for the
% fixed_iterator Monad are written below.
% Implement the iter_sum function.
iter(Stream) -> {undefined, Stream}.

next({_,done}) -> {undefined, done};
next({_,Lambda}) -> Lambda().

%iter_sum(Fixed_Iterator) -> 


% Problem 3.1
% Modify the handle_server as described in the instructions
handle_server() ->
    receive
        {Client_PID, echo, {Text}} -> Client_PID ! {Text};
        {Client_PID, add, {X, Y}} -> Client_PID ! {X + Y};
        {Client_PID, avg, {Numbers}} -> 
            AvgResult = average(Numbers), 
        Client_PID ! {AvgResult}
    end,
    handle_server().

average(Numbers) ->
    Sum = lists:sum(Numbers),
    Length = length(Numbers),
    Avg = case Length of
        0 -> 0;
        _ -> Sum / Length
    end,
    Avg.


start_server() ->
    spawn(prove07, handle_server, []).

% Problem 3.2

start_running_avg_server() ->
    spawn(running_avg_server, handle_running_avg_server, [0, 0]).

handle_running_avg_server(Sum, Count) ->
    receive
        {Client_PID, add, Number} ->
            NewSum = Sum + Number,
            NewCount = Count + 1,
            NewAverage = NewSum / NewCount,
            Client_PID ! {NewAverage};
        {Client_PID, remove, Number} ->
            NewSum = Sum - Number,
            NewCount = Count - 1,
            NewAverage = NewSum / NewCount,
            Client_PID ! {NewAverage};
        {Client_PID, display} ->
            Average = if
                Count > 0 -> Sum / Count;
                true -> 0 
            end,
            Client_PID ! {Average},
        handle_running_avg_server(Sum, Count)
    end.

% The following function is used to send
% commands to your servers for problems 3.1 and 3.2
send_to_server(Server_PID, Command, Params) ->
    Server_PID ! {self(), Command, Params},
    receive
        {Response} -> Response
    end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Test Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test code for problem set 1
test_ps1() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    Stream1 = range(1,10,3),
    {1, Stream2} = Stream1(),
    {4, Stream3} = Stream2(),
    {7, Stream4} = Stream3(),
    %{10, Stream5} = Stream4(),
    %{undefined, done} = Stream5(),

    Stream6 = range(10,1,-4),
    {10, Stream7} = Stream6(),
    {6, Stream8} = Stream7(),
    {2, Stream9} = Stream8(),
    {undefined, done} = Stream9(),

	Stream10 = range(1,1,0),
    {undefined, done} = Stream10(),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    Stream11 = words("The cow jumped over the moon"),
    {"The", Stream12} = Stream11(),
    {"cow", Stream13} = Stream12(),
    {"jumped", Stream14} = Stream13(),
    {"over", Stream15} = Stream14(),
    {"the", Stream16} = Stream15(),
    {"moon", Stream17} = Stream16(),
    {undefined, done} = Stream17(),

    Stream18 = words("Happy"),
    {"Happy", Stream19} = Stream18(),
    {undefined, done} = Stream19(),

    Stream20 = words(""),
    {undefined, done} = Stream20(),

    ok.

% Test code for problem set 2
test_ps2() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % io:format("Start Time: ~p~n",[time()]),
    % Result1 = iter_sum(iter(range(1,500000000,1))),
    % io:format("iter_sum completed: ~p ~p~n",[time(), Result1]),

    % Result2 = lists:sum(lists:seq(1,500000000,1)),
    % io:format("lists:sum completed: ~p ~p~n",[time(), Result2]),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Add your observations below as a comment

    % The iter_sum took 21 seconds and the sum took 119 seconds.  Its faster to be lazy.

    ok.

% Test code for problem set 3
test_ps3() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    Server1_PID = start_server(),
    "Hello" = send_to_server(Server1_PID, echo, {"Hello"}),
    21 = send_to_server(Server1_PID, add, {13, 8}),
    25.0 = send_to_server(Server1_PID, avg, {[10,20,30,40]}),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    Server2_PID = start_running_avg_server(),
    10.0 = send_to_server(Server2_PID, add, {10}),    % 10
    15.0 = send_to_server(Server2_PID, add, {20}),    % 10, 20
    20.0 = send_to_server(Server2_PID, add, {30}),    % 10, 20, 30
    25.0 = send_to_server(Server2_PID, remove, {10}), % 20, 30
    30.0 = send_to_server(Server2_PID, add, {40}),    % 20, 30, 40
    30.0 = send_to_server(Server2_PID, remove, {30}), % 20, 40
    40.0 = send_to_server(Server2_PID, add, {60}),    % 20, 40, 60
    42.5 = send_to_server(Server2_PID, add, {50}),    % 20, 40, 60, 50
    42.5 = send_to_server(Server2_PID, display, {}),

    ok.
