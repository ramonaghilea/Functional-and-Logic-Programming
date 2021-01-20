; 9. Convert a tree of type (1) to type (2)
; 1 - ( A 2 B 0 C 2 D 0 E 0 )
; 2 - ( A (B) (C (D) (E) ) )

; (a 2 b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0)
; (A (B (C (I) ) (F (G) ) ) (D (E) (H) ) )

; rightSubtree(subtree - list of nodes starting with the first node of the left subtree
; nrNodes - nrNodes we need to parse)
; returns the part of the list of type 1 which bellngs to the right subtree
(defun rightSubtree (subtree nrNodes)
	(cond
		(( or (= (length subtree) 2) ( = nrNodes 1) )
			;(list (car subtree) )
			subtree
		)
		(t
			; nrNodes - 1 + (cadr subtree)
			(rightSubtree (cddr subtree) (- (+ nrNodes (cadr subtree) ) 1) )
		)
	)
)


; b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0
; c 1 i 0 f 1 g 0 d 2 e 0 h 0,     b 2,    2 - 1 + 2 = 3
; i 0 f 1 g 0 d 2 e 0 h 0,         b 2 c 1,     3 - 1 + 1  =3
; f 1 g 0 d 2 e 0 h 0              b 2 c 1 i 0,  3 - 1 + 0 = 2

; leftSubtree(subtree - list of nodes starting with the first node of the left subtree
; result - list, collector variable
; nrNodes - nrNodes we need to parse)
; returns the part of the list of type 1 which bellngs to the left subtree
(defun leftSubtree (subtree result nrNodes)
	(cond
		; if the initial list has only 2 elements
		( (and (= (length subtree) 2) (= nrNodes 2))
			(append result subtree)
		)
		(( = nrNodes 1)
			result
		)
		(t
			(leftSubtree (cddr subtree) (append result (list(car subtree)) (list(cadr subtree))) (- (+ nrNodes (cadr subtree) ) 1) )
		)
	)
)
	
; (leftSubtree '(E 0 F 0) () 2)
; (leftSubtree '(C 1 D 0 E 1 F 0) () 2)


; 1 - ( A 2 B 0 C 2 D 0 E 0 )
; 2 - ( A (B) (C (D) (E) ) )

; convert(tree - list representing a binary tree) - converts the binary tree from type 1 to type 2
(defun convert (tree)
	(cond
		; if the tree is empty from the beginning, return nil
		( (= (length tree) 0)
			nil
		)
		; the last 2 elements will be an atom and number 0, because it cannot have subtrees
		; return a list only with that atom
		( (= (length tree) 2 )
			(list (car tree) )
		)
		; ( (= (length tree) 1 )
			; tree
		; )
		; when the curent atom has no subtree, return a list which contains it
		; the elements on even positions is the number of subtrees of the current atom -> cadr tree
		(( = (cadr tree) 0)
			(list ( car tree ))
		)
		; when the curent atom has one subtree, return a list which contains it and the result
		; of convert (leftSubtree)
		(( = (cadr tree) 1)
			; current root has one subtree
			
			;(list (car tree) ( convert (cddr tree) ) )
			(list (car tree) ( convert (leftSubtree (cddr tree) () '2) ) )
		)
		; when the curent atom has 2 subtrees, return a list which contains it,
		; the result of convert (leftSubtree) and the result of convert (rightSubtree)
		(( = (cadr tree) 2)
			; current root has 2 subtrees
			
			;( list (car tree) ( convert (cddr tree) ) ( convert (cddddr tree) ) )
			( list (car tree) ( convert (leftSubtree (cddr tree) () '2) ) ( convert (rightSubtree (cddr tree) '2) ) )
			 ; ( list (car tree) 
			 ; ( (lambda (a) (convert (leftSubtree a () '2 )) ( convert (rightSubtree a '2) ) ) (cddr tree))
			 ; )
		)
	)
)

; (rightSubtree '(E 0 F 0) 2)
; (rightSubtree '(C 1 D 0 E 1 F 0) 2)

(format t"type 1 tree: ( A 2 B 0 C 2 D 0 E 0 ) converted to type 2 tree: ~S~%" 
		(convert '(A 2 B 0 C 2 D 0 E 0)) )
(format t"type 1 tree: ( A 2 B 0 C 1 D 0 ) converted to type 2 tree: ~S~%" 
		(convert '(A 2 B 0 C 1 D 0)) )
(format t"type 1 tree: ( A 1 B 0 ) converted to type 2 tree: ~S~%" 
		(convert '(A 1 B 0)) )
(format t"type 1 tree: ( A 0 ) converted to type 2 tree: ~S~%" 
		(convert '(A 0)) )
(format t"type 1 tree: (A 2 B 2 C 1 I 0 F 1 G 0 D 2 E 0 H 0) converted to type 2 tree: ~S~%" 
		(convert '(A 2 B 2 C 1 I 0 F 1 G 0 D 2 E 0 H 0)) )
		

		
; (convert '(A 2 B 0 C 1 D 0))
; (convert '(A 1 B 0))
; (convert '(A 0))

