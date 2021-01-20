% Generate all permutation of N (N - given) respecting the property:
% for every 2<=i<=n exists an 1<=j<=i,
% so |v(i)-v(j)|=1.

% getElement(N: int, the number given, E: int, the result) - get an
% element between 1 and N
% flow model: (i, o), (i, i)
getElement(N, N).
getElement(N, Res) :- N > 1,
                   N2 is N - 1,
                   getElement(N2, Res).

% exists(L: List, E: int) - checks if E is in list L
% flow model: (i, o), (i, i)
exists([E|_], E) :- !.
exists([_|T], E) :- exists(T, E).

% candidate(N: given N, List: List, Res: int) - generates a candidate
% for the permutation, calls getElement and then checks if it is
% already in the candidate solution(list)
% flow model: (i, i, o),(i, i, i)
candidate(N, List, Res) :- getElement(N, E),
                           \+exists(List, E),
                           Res is E.

% existsElemDifference1(NewE: int, L: List) - checks the condition of
% the problem: if for the new element, the one we want to add on
% position i, 2 <= i <= n, exists a position j, 1 <= j <= i, such that
% abs(v(i) - v(j)) == 1
% flow model: (o, i), (i, i)
existsElemDifference1(NewE, [H|_]) :- abs(H - NewE) =:= 1, !.
existsElemDifference1(NewE, [_|T]) :- existsElemDifference1(NewE, T).

% reverseList(Linit: initlai list, Res: the list in which the solution
% is created, ResFinal: the final list
% flow model: (i, i, o), (i, i, i)
reverseList([], Res, Res) :- !.
reverseList([H|T], Res, ResFinal) :- Res2 = [H | Res],
                                     reverseList(T, Res2, ResFinal).

% solution(N: int, given number, ResList: list, Len: int, Len of
% current list, T: current list) - generates a permutation of N with the
% given condition
% flow model: (i, o, i, i), (i, i, i, i)
solution(N, ResList, N, ResList) :- !.
solution(N, ResList, Len, T) :- candidate(N, T, Res),
                                             existsElemDifference1(Res, T),
                                             Len2 is Len + 1,
                                             solution(N, ResList, Len2, [Res | T]).


% permutation_main(N: int, ReversedList: the final result list
% (solution)
% flow model: (i, i, o), (i, i, i)
permutation_main(N, ReversedList) :- candidate(N, [], Res),
                             solution(N, ResList, 1, [Res]),
                             reverseList(ResList, [], ReversedList).

% permutation_all(N: int, given N, AllLists: list containing all the
% solutions
% flow model: (i, o), (i, i)
permutation_all(N, AllLists):- findall(ResList, permutation_main(N, ResList), AllLists).

