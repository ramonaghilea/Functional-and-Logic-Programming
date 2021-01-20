

; Write a function that computes the sum of even numbers and the decrease the sum of odd numbers,
; at any level of a list.


; sumEvenOdd (l - list) - computes the sum of all even numbers and decrease the sum of odd numbers
(defun sumEvenOdd (l)
	(cond
		( ( and (numberp l) (= (mod l 2) 0) )
			; even number, add it to the sum
			l
		)
		( ( and (numberp l) (= (mod l 2) 1) )
			; odd number, subtract it form the sum
			(- 0 l)
		)
		( (listp l)
			; list, apply the function to all its elements
			(apply #'+ (mapcar #'sumEvenOdd l))
		)
		(t
			; non-numerical atom, return 0
			0
		)
	)
)

(terpri)
(format t"list: ( A 2 B 0 3 ) result: ~S~%" 
		(sumEvenOdd '( A 2 B 0 3 )) )
(format t"list: ( A 2 B 0 (3 6) ) result: ~S~%" 
		(sumEvenOdd '( A 2 B 0 (3 6) )) )
(format t"list: ( A 2 B 0 (3 (3)) (5) ) result: ~S~%" 
		(sumEvenOdd '( A 2 B 0 (3 (3)) (5) ) ))
(format t"list: ( A ) result: ~S~%" 
		(sumEvenOdd '( A )) )
(format t"list: ( 10 ) result: ~S~%" 
		(sumEvenOdd '( 10 )) )
(format t"list: ( 9 ) result: ~S~%" 
		(sumEvenOdd '( 9 )) )
(format t"list: ( ) result: ~S~%" 
		(sumEvenOdd '( )) )
(terpri)

