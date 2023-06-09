pharmacy(1,'Orteka','Moscow',89109998090).
pharmacy(2,'We Better teka','Saint Peter',89109696066).
pharmacy(3,'Nurlan pharm','Vlavikavkaz',89107797070).

medicine(11,"Spareks").
medicine(12,"Teraflu").

sells(1,11,350 ,15).
sells(2,11,390 ,8).
sells(3,11,290,3).
sells(1,12,560 ,19).
sells(2,12,960 ,29).
sells(3,12,340 ,1).

available(Pharm,Name1) :- pharmacy(Id,Pharm,Location,Phone), medicine(ID1,Name1).

searchByID(Id,Phone,Location) :- pharmacy(Id,Pharm,Location,Phone).

match(Name,Pharm1,Pharm2,Pharm3,Price1,Price2,Price3) :- medicine(ID,Name),sells(Id1,ID,Price1,Numb1),pharmacy(Id1,Pharm1,Location1,Phone1),sells(Id2,ID,Price2,Numb2), pharmacy(Id2,Pharm2,Location2,Phone2),sells(Id3,ID,Price3,Numb3), pharmacy(Id3,Pharm3,Location3,Phone3),not(Id1=Id2),not(Id1=Id3),not(Id2=Id3).

minPrice(Name,Location1,Price1) :- match(Name,Pharm1,Pharm2,Pharm3,Price1,Price2,Price3),pharmacy(Id1,Pharm1,Location1,Phone1),Price1<Price2,Price1<Price3.