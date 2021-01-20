; Write a function to get from a given list the list of all atoms, on any
; level, but reverse order. Example:
; (((A B) C) (D E)) ==> (E D C B A)


; reverse_aux(l: list to be reversed, col: result list, collector variable)
(defun reverse_aux(l col)
	(cond
		((null l) col)
		( (atom (car l) ) (reverse_aux (cdr l) (cons (car l) col ) ) )
		( t ( reverse_aux (cdr l) (append (reverse_aux (car l) () ) col ) ) )
	)
)

; reverse_main(l: list to be reversed)
(defun reverse_main( l )
	(reverse_aux l () )
)

;(reverse_main '(((A B) C) (D E)) )
; (reverse_main '((1)) )