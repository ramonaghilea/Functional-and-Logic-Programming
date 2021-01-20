%b. Write a predicate to add a value v after 1-st, 2-nd, 4-th, 8-th, … element in a list.
%
%
%isPower2(Val: int, TruthVal: int) - checks if Val is a power of 2
%flow model: (I,O)(I,I)
isValPower2(0,0).
isValPower2(1,1).
isValPower2(Val,0):-
    mod(Val,2) =:= 1,
    Val =\= 0,
    Val =\= 1.
isValPower2(Val,TruthVal):-
    mod(Val,2) =:=0,
    Val =\= 0,
    Val =\= 1,
    Val2 is Val/2,
    isValPower2(Val2,TruthVal).

% addAfterPower2(Val: int - the value that needs to be added, IList:
% initial list, RList: the result list, Pos: the position of the current
% element in the list
% flow model:(I,I,O,I)(I,I,I,I)
addAfterPosPower2(_,[],[],Pos):-
    Pos3 is Pos-1,
    isValPower2(Pos3,TruthVal),
    TruthVal =:= 0.
addAfterPosPower2(Val,[],[Val],Pos):-
    Pos3 is Pos-1,
    isValPower2(Pos3,TruthVal),
    TruthVal =:= 1.
addAfterPosPower2(Val,T,RList,Pos):-
    Pos3 is Pos-1,
    isValPower2(Pos3,TruthVal),
    TruthVal =:= 1,
    Pos2 is Pos+1,
    addAfterPosPower2(Val,T,RList2,Pos2),
    RList = [Val| RList2].
addAfterPosPower2(Val,[L1|T],RList,Pos):-
    Pos3 is Pos-1,
    isValPower2(Pos3,TruthVal),
    TruthVal =:= 0,
    Pos2 is Pos+1,
    addAfterPosPower2(Val,T,RList2,Pos2),
    RList = [L1|RList2].

