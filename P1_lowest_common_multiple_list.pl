%Write a predicate to determine the lowest common multiple of a list formed from integer numbers.


% gcd(Elem1: int, Elem2: int, Divizor: int, the divizor computed
% flow model: (I,I,O)(I,I,I)
gcd(0,Elem2,Divizor):-
    Divizor is Elem2.
gcd(Elem1,0,Divizor):-
    Divizor is Elem1.
gcd(Elem1,Elem2,Divizor):-
    Elem1 =\= 0,
    Elem2 =\= 0,
    Elem12 is mod(Elem1,Elem2),
    gcd(Elem2,Elem12, Divizor).


%lcm_list(List:list, multiple: int, the lowest common multiple of the
% elements of the list)
%flow model: (I,I)(I,O)
% The base call is with Multiple = 1 because it won't affect the
% computation. LCM(1,A) is always A
lcm_list([], 1).
lcm_list([L1|T], Multiple2):-
    lcm_list(T, Multiple),
    gcd(L1, Multiple, Gcd),
    Multiple2 is L1*Multiple / Gcd.
