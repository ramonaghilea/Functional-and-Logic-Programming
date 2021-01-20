;d) Write a function that determines the number of occurrences of a given atom in a nonlinear list.

;freq(e: atom, l: list) - computes the number of occurences of atom e in list l
(defun freq(e l)
	(cond
		( (null l) 0)
		( ( AND (atom (car l)) (equal e (car l)) ) ( + 1 (freq e (cdr l) ) ) )
		( (atom (car l ) ) ( freq e (cdr l ) ) )
		( t (+ (freq e (car l) ) (freq e (cdr l) ) ) )
	)
)

; (freq 'a '(a b c d (a a)) )
; (freq 'a '(a b c 3 4 d (a a)) )