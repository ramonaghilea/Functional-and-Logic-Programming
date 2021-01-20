;Write a function that returns the greatest common divisor of all numbers in a nonlinear list.

; gcd_aux(a: atom, b: atom) - computes the geratest common divizor between a and b
(defun gcd_aux(a b)
	(cond
		((= a 0) b)
		((= b 0) a)
		(t
			(gcd_aux b ( mod a b) )
		)
	)
)

; gcd_main(l: list) - computes the gcd of all numbers in l
(defun gcd_main(l)
	(cond
		( (null l) nil)
		( (AND (numberp (car l) ) (= (length l) 1) ) (car l))
		( (AND (listp (car l)) (= (length l) 1 ) ) (gcd_main (car l) ) )
		( (numberp (car l) ) ( gcd_aux (car l) (gcd_main (cdr l) ) ) )
		( (atom (car l)) (gcd_main (cdr l) ) )
		( t
			( gcd_aux (gcd_main (car l) ) (gcd_main (cdr l) ) )
		)
	)
)


; (gcd_main '(3 (6) (9 6) 12) )
; (gcd_main '(3 a (6) (9 6)) )