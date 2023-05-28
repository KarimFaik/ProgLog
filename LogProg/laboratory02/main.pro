% Copyright

implement main
    open core, stdio, file

domains
    units = few; alot; enough.

class facts - phirmaDb
    pharmacy : (integer Id, string PharmName, string Location, integer Phone, real Budget).
    medicine : (integer Ids, string MedName).
    sells : (integer Id, integer Ids, integer Price, units Qnt).

class facts
    sum : (real Sum) single.

clauses
    sum(0).

class predicates
    available : (string Phar, string Name1) nondeterm anyflow.
    searchByID : (integer Id, integer Phone, string Location) nondeterm anyflow.
    match : (string Name, string Phar1, string Phar2, string Phar3, string Phar4, integer Price1, integer Price2, integer Price3, integer Price4)
        nondeterm anyflow.
    budget_summary : () failure anyflow.

clauses
    available(Pharm, Name1) :-
        pharmacy(Id, Pharm, Location, Phone, Budget),
        medicine(ID1, Name1).

    searchByID(Id, Phone, Location) :-
        pharmacy(Id, Phar, Location, Phone, Budget).

    match(Name, Phar1, Phar2, Phar3, Phar4, Price1, Price2, Price3, Price4) :-
        medicine(ID, Name),
        sells(Id1, ID, Price1, Numb1),
        pharmacy(Id1, Phar1, Location1, Phone1, Budget1),
        sells(Id2, ID, Price2, Numb2),
        pharmacy(Id2, Phar2, Location2, Phone2, Budget2),
        sells(Id3, ID, Price3, Numb3),
        pharmacy(Id3, Phar3, Location3, Phone3, Budget3),
        sells(Id4, ID, Price4, Numb4),
        pharmacy(Id4, Phar4, Location4, Phone4, Budget4),
        not(Id1 = Id2),
        not(Id1 = Id3),
        not(Id1 = Id4),
        not(Id2 = Id3),
        not(Id2 = Id4),
        not(Id3 = Id4).

    budget_summary() :-
        pharmacy(Id, PharmName, Location, Phone, Budget),
        sum(Sum),
        assert(sum(Sum + Budget)),
        fail.

    run() :-
        console::init(),
        reconsult("..\\consultfile.txt", phirmaDb),
        fail.

    run() :-
        available(P, T),
        stdio::write("Medicine :", T, "available at pharmacy called", P, "\n"),
        fail.

    run() :-
        searchByID(Y, X, Z),
        stdio::write(Y, X, Z, " Those are details of pharmacy", "\n"),
        fail.

    run() :-
        match(M, M1, M2, M3, M4, M11, M22, M33, M44),
        stdio::write("Medicine :", M, " Available at:", M1, M2, M3, M4, "with prices", M11, M22, M33, M44, "\n"),
        fail.

    run() :-
        budget_summary().

    run() :-
        sum(Sum),
        stdio::write("Summary budget is ", Sum, "\n"),
        fail.

    run() :-
        stdio::write("End test\n").

end implement main

goal
    console::run(main::run).
