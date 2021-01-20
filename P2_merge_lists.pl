% a.Merge two sorted lists with removing the double values.
% b.For a heterogeneous list, formed from integer numbers and list of
% numbers, merge all sublists with removingthe double values.


% removeDuplicates(L: initial list, Res: the list after removing the
% duplicate elements)
% flow model: (i, o) (i, i)
removeDuplicates([], []) :- !.
removeDuplicates([H, H, H| T], Res) :- !,
                                       removeDuplicates([H, H| T], Res).
removeDuplicates([H, H | T], Res) :- !,
                                     removeDuplicates(T, Res2),
                                     Res = [H | Res2].
removeDuplicates([H | T], Res) :- !,
                                  removeDuplicates(T, Res2),
                                  Res = [H | Res2].

% mergeLists(L1: sorted list, L2: sorted list, Res: the resulted list)
% after merging L1 and L2
% flow model: (i, i, o) (i, i, i)
mergeLists([], L2, L2) :- !.
mergeLists(L1, [], L1) :- !.
mergeLists([H1 | T1], [H2 | T2], Res) :- H1 =:= H2,
                                         !,
                                         mergeLists(T1, T2, Res2),
                                         Res = [H1 | Res2].
mergeLists([H1 | T1], [H2 | T2], Res) :- H1 < H2,
                                         !,
                                         mergeLists(T1, [H2|T2], Res2),
                                         Res = [H1 | Res2].
mergeLists([H1 | T1], [H2 | T2], Res) :- !,
                                         mergeLists([H1|T1], T2, Res2),
                                         Res = [H2 | Res2].

% mergeLists([1, 2, 4, 7, 10], [1, 3, 4, 6, 10], Res).
% mergeLists([1, 2, 4, 7, 10], [1, 3, 4, 6, 10], [1, 2, 3, 4, 6, 7, 10]).


% mergeListsMain(L1: sorted list, L2: sorted list, Res: the resulted
% lits merging L1 and L2) - L1 and L2 may contain duplicates
% flow model:(i, i, o) (i, i, i)
mergeListsMain(L1, L2, Res) :- removeDuplicates(L1, ResL1),
                               removeDuplicates(L2, ResL2),
                               mergeLists(ResL1, ResL2, ResFinal),
                               Res = ResFinal.


% For a heterogeneous list, formed from integer numbers and list of numbers, merge
% all sublists with removingthe double values.

% mergeSublists(L: heterogeneous list, Res: the resulted list after
% merging the sublists from L with removing the double values
% flow model: (i, o) (i, i)
mergeSublists([], []) :- !.
mergeSublists([H | T], Res) :- is_list(H),
                               !,
                               mergeSublists(T, Res2),
                               mergeListsMain(H, Res2, ResLists),
                               Res = ResLists.
mergeSublists([_| T], Res) :- !,
                               mergeSublists(T, Res).

% mergeSublists([1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8], R).
% mergeSublists([1, 4, 5, [1, 4, 6], 3, 5, 8], R).
% mergeSublists([1, 4, 5, 3, 5, 8], R).
% mergeSublists([], R).


% checks if the element E is divisible by 5
divisible(E) :- E mod 5 =:= 0.

