﻿implement main
    open core, stdio, file

domains
    country = russia; poland; usa; venez.

class facts - pharmacyDb
    team : (integer Id, string PharmCall, country Country, string PharmTown, real Budget).
    player : (integer MedicNumber, string Medicname, integer Id).
    place : (string Town).
    result : (integer Res1, integer Res2).

class predicates
    length : (A*) -> integer N.
    el_sum : (real* List) -> real Sum.
    laverage : (real* List) -> real Average determ.
    max : (real* List, real Max [out]) nondeterm.
    min : (real* List, real Min [out]) nondeterm.

clauses
    length([]) = 0.
    length([_ | T]) = length(T) + 1.

    el_sum([]) = 0.
    el_sum([H | T]) = el_sum(T) + H.

    laverage(L) = el_sum(L) / length(L) :-
        length(L) > 0.

    max([Max], Max).

    max([H1, H2 | T], Max) :-
        H1 >= H2,
        max([H1 | T], Max).

    max([H1, H2 | T], Max) :-
        H1 <= H2,
        max([H2 | T], Max).

    min([Min], Min).

    min([H1, H2 | T], Min) :-
        H1 <= H2,
        min([H1 | T], Min).

    min([H1, H2 | T], Min) :-
        H1 >= H2,
        min([H2 | T], Min).

class predicates
    print_list : (integer*) nondeterm.
    print_list : (string*) nondeterm.
    print_list : (main::pharmacyDb*) nondeterm.
    team_compound : (string PharmName) -> main::pharmacyDb* PharmComp nondeterm.
    budgetsum : () -> real Sum determ.
    budgetmax : () -> real Max nondeterm.
    budgetmin : () -> real Min nondeterm.

clauses
    team_compound(PharmName) = PharmComp :-
        team(Id, PharmName, _, _, _),
        !,
        PharmComp = [ medic(MedicN, Name, Id) || medic(MedicN, Name, Id) ].

    print_list([X | Y]) :-
        write(X),
        nl,
        print_list(Y).

    budgetsum() = Sum :-
        Sum = el_sum([ Budget || pharm(_, _, _, _, Budget) ]).

    budgetmax() = Res :-
        max([ Budget || pharm(_, _, _, _, Budget) ], Max),
        Res = Max,
        !.
    budgetmin() = Res :-
        min([ Budget || pharm(_, _, _, _, Budget) ], Min),
        Res = Min,
        !.
%budget_max()

clauses
    run() :-
        file::consult("../consultfile.txt", pharmacyDb),
        fail.
    run() :-
        PList = team_compound("Pharm2"),
        write(PList),
        nl,
        write("Printing list..."),
        nl,
        print_list(PList),
        write("Printing finished"),
        nl,
        fail.
    run() :-
        write("Budget sumary:", budgetsum()),
        nl,
        write("Max budget:", budgetmax()),
        nl,
        write("Min budget:", budgetmin()),
        nl,
        fail.
    run() :-
        stdio::write("End test\n").

end implement main

goal
    console::runUtf8(main::run).