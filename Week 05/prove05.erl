% CSE 382 Prove 05

% (c) BYU-Idaho - It is an honor code violation to post this
% file completed or uncompleted in a public file sharing site. W4.

% Instructions: Use this template file for this prove assignment.
% The details of what to do for each problem are found in
% the reading. IMPORTANT: Comment out code that is not
% running properly.  The `test_ps#` functions should return `ok`.
% When writing tests use the `expected_result` = `actual result` format.

-module(prove05).
-export([test_ps1/0, test_ps2/0, test_ps3/0]).

% Problem 1.2

greater_list(Value) ->
    fun(List) ->
        lists:filter(fun(Item) -> Item > Value end, List)
    end.

multiply_list(Value) -> 
    fun(List) -> 
        lists:map(fun(Item) -> Value * Item end, List)
    end.

% Problem 1.3
% Provide specification and definition (as comments) along with the code
multiples_of_list(Value) ->
    fun(List) ->
        lists:filter(fun(Item) -> Item rem Value =:= 0 end, List)
    end.

% Problem 2.1

curry3(Lambda) -> (fun(Param1) -> (fun(Param2) -> (fun(Param3) -> Lambda(Param1, Param2, Param3) end) end) end).

% Problem 2.2
alert_intermediate(Location) ->
    curry3(fun(Category, Message) -> alert(Location, Category, Message) end).

% Problem 2.3
alert_intermediate(Location, Category) ->
    curry3(fun(Message) -> alert(Location, Category, Message) end).


% Problem 3.1
map_filter_fold2(Value) ->
    List = lists:seq(1, Value),
    fun (MapL) -> 
        MapList = lists:map(MapL, List),
        fun (FilterL) ->
            FilterList = lists:filter(FilterL, MapList),
            fun (FoldInit, FoldL) ->
                FoldResult = lists:foldl(FoldL, FoldInit, FilterList),
                FoldResult
            end
        end
    end.

partial_application(Value) ->
    PartialFunction = map_filter_fold2(Value),
    MapFunction = fun(X) -> 3 * X end, % Mapping function (triples the value)
    FilterFunction = fun(X) -> X rem 2 =:= 0 end, % Filtering function (checks for even numbers)
    PartialFunction(MapFunction, FilterFunction).


% Problem 3.2


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The following functions are fully implemented for you to use in the problem sets.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Display a formatted alert message with three parts.
alert(Location, Category, Message) -> io:format("~p for ~p : ~p~n", [Category, Location, Message]).

% Return True if the Value is within range
range_check(Low, High, Value) -> (Value >= Low) and (Value =< High).

% Calculate the average of list of numbers.
list_average(List) ->
    lists:foldl(fun (Item, Total) -> Item + Total end, 0, List) / length(List).

% Create a one arity function that counts all items in a list that have
% the specified Term in the string.
list_text_count(Term) ->
    fun(List) -> lists:foldl(fun (Item, Total) ->
        case string:find(Item,Term) of
            nomatch -> Total;
            _Else -> Total + 1
        end
    end, 0, List) end.

% Open the file, skip the header row, and begin reading
% each row one at a time to produce a list of lists.
read_csv_file(Filename) ->
    {ok, FileHandle} = file:open(Filename, read),
    file:read_line(FileHandle), % Skip header row
    read_csv_file(FileHandle, []).

% Read each line of the CSV file and split the line by the comma
% delimeter.  Each line will be represented by a list and the file
% will be represented as a list of lists.
read_csv_file(FileHandle, Lines) ->
    Result = file:read_line(FileHandle),
    case Result of
        {ok, Line} -> read_csv_file(FileHandle, [string:split(Line,",",all)|Lines]);
        eof -> Lines
    end.

% Extract the specified column as text
extract_column_array(text, Array, ColumnId) ->
    ExtractColumn = fun(Row) -> lists:nth(ColumnId, Row) end,
    lists:map(ExtractColumn, Array);

% Extract the specified column as integers
extract_column_array(int, Array, ColumnId) ->
    ExtractColumn = fun(Row) ->
        {Result, _} = string:to_integer(lists:nth(ColumnId, Row)),
        Result
     end,
    lists:map(ExtractColumn, Array);

% Extract the specified column as floats
extract_column_array(float, Array, ColumnId) ->
    ExtractColumn = fun(Row) ->
        {Result, _} = string:to_float(lists:nth(ColumnId, Row)),
        Result
     end,
    lists:map(ExtractColumn, Array).

% Extract a column (with the specified type of text, int, or float)
% from the file and perfom the specified function on the data.
process_dataset(Filename, ColumnId, ColumnType, CalcFunction) ->
    Data = read_csv_file(Filename),
    DataColumn = extract_column_array(ColumnType, Data, ColumnId),
    Result = CalcFunction(DataColumn),
    Result.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Test Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test code for problem set 1
test_ps1() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Chain the map, filter, and foldl functions in a single line as described in the problem
    933120 = Result = lists:foldl(fun(X, Acc) -> X * Acc end, 1, lists:filter(fun(X) -> X rem 2 =:= 0 end, lists:map(fun(X) -> X * 3 end, [1,2,3,4,5,6,7,8,9,10]))),


    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    L = [2, 4, 6, 8, 10, 12],
    [12,16,20,24] = (greater_list(10))((multiply_list(2))(L)),
    [24] = (multiply_list(2))((greater_list(10))(L)),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    Multiples7 = multiples_of_list(7),
    [7,14,21,28] = Multiples7(lists:seq(1,30)),
    [42,49] = Multiples7(lists:seq(40,50)),


    ok.

% Test code for problem set 2
test_ps2() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    alert("Madison County","Winter Storm Warning","Expect 8-12 inches of Snow"),
    ((((curry3(fun alert/3))("Madison County")))("Winter Storm Warning"))("Expect 8-12 inches of Snow"),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code to curry the first parameter and test the intermediate function twice
    Alert1 = alert_intermediate("Location1"),
    Alert2 = alert_intermediate("Location2"),
    Alert1("Category1", "Message1"),
    Alert2("Category2", "Message2"),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code to curry the first and second parameter and test the intermediate function twice
    %Alert1 = alert_intermediate("Location1", "Category1"),
    %Alert2 = alert_intermediate("Location2", "Category2"),
    %Alert1("Message1"),
    %Alert2("Message2"),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code to curry the range_check and use it with a filter as described in the instructions
    Range_10_to_20 = ((curry3(fun range_check/3))(10))(20),
    Full_List_of_Numbers = [3, 15, 23, 19, 6, 16, 13, -5, -20, 30],
    [15,19,16,13] = lists:filter(Range_10_to_20, Full_List_of_Numbers),

    ok.

% Test code for problem set 3
test_ps3() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Useful lambdas for the map_filter_fold2 to use.
    Square = fun(X) -> X * X end,
    Triple = fun(X) -> 3 * X end,
    Odd = fun(X) -> X rem 2 == 1 end,
    Even = fun(X) -> X rem 2 == 0 end,
    Sum = fun(X,Y) -> X+Y end,
    Product = fun(X,Y) -> X*Y end,

    % Example not using any partial applications
    35 = (((map_filter_fold2(6))(Square))(Odd))(0, Sum),

    % Example creating and using partial application
    First10Squares = (map_filter_fold2(10))(Square),
    165 = (First10Squares(Odd))(0, Sum),
    14745600 = (First10Squares(Even))(1,Product),

    % Write and test a partial application function to obtain the first 20 triples that are even and
	% test per the instructions.
    First20TriplesOnlyEven = partial_application(20),
    330 = lists:sum(First20TriplesOnlyEven),
    219419659468800 = lists:foldl(fun(X, Acc) -> X * Acc end, 1, First20TriplesOnlyEven),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Examples not using any partial applications
    % Avg_Temp = process_dataset("weather.csv", 6, int, fun list_average/1),
    % io:format("Avg Temp = ~p~n",[Avg_Temp]), % Answer = 24.8472
    % Count_Snow = process_dataset("weather.csv", 5, text, list_text_count("Snow")),
    % io:format("Count Snow = ~p~n",[Count_Snow]), % Answer = 38

    % Test partial application to read entire dataset only once
    % Weather = process_dataset2("weather.csv"),
    % Avg_WindChill = (Weather(8, int))(fun list_average/1),
    % io:format("Avg WindChill ~p~n",[Avg_WindChill]), % Answer = 12.0
    % Avg_Pressure = (Weather(9,float))(fun list_average/1),
    % io:format("Avg Pressure ~p~n",[Avg_Pressure]), % Answer = 29.735

    % Test partial application to read the entire dataset and extract the
    % Observation column (column 5; text) only once
    % Weather_Obs = Weather(5, text),
    % Count_Windy = Weather_Obs(list_text_count("Windy")), % Answer = 19
    % io:format("Count Windy = ~p~n",[Count_Windy]),
    % Count_Mist = Weather_Obs(list_text_count("Mist")), % Answer = 7
    % io:format("Count Mist = ~p~n",[Count_Mist]),


    ok.
