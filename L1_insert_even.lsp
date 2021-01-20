; Write a function that inserts in a linear list a given atom A after the 2nd, 4th, 6th, ... element.

; insert_even(e: atom, l: list, col: list, posit: number) - inserts atom e on even positions in list l, 
; stores the result list in col
(defun insert_even(e l col posit)
	(cond
		((null l) col)
		(  
			( = (mod posit 2) 0 ) 
			( insert_even e (cdr l) (append col (list(car l)) (list e) ) ( + posit 1) )
		)
		(t 
			( insert_even e (cdr l) (append col (list(car l)) ) ( + posit 1) )
		)
	)
)

; insert_even_main(e: atom, l: list)
(defun insert_even_main(e l)
	(insert_even e l () 1)
)

; (insert_even_main 'a '(1 1 1 1))
; (insert_even_main 'a '(1))