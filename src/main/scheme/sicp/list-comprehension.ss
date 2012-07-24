; sicp list comprehension
; list methods
(define (atom? x) (not (pair? x)))

(define (list-index items n)
  (if (= n 0)
      (car items)
      (list-index (cdr items) (- n 1))))


(define (list-size items)
  ; calculate size of items using recursive process
  (if (null? items)
      0
      (+ (list-size (cdr items)) 1)))

(define (list-size-it items)
  ; calculate size of items using iterative process
  (define (size-iter a count)
    (if (null? a)
        count
        (size-iter (cdr a) (+ count 1))))
  (size-iter items 0))

(define (list-append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1)
            (append (cdr list1) list2))))

(define (list-last items)
  (list-index items (- (list-size items) 1)))

(define (list-reverse items)
  (if (null? items)
      null
      (append (list-reverse (cdr items))
              (list (car items)))))


(define (same-parity integer . integers)
  (define predicate
    (if (even? integer) even? odd?))
  ;; decrementa -> decremenda; the things are about to be decremented,
  ;; though addressed as well, it's true.
  (define (iter predicate decremenda)
    ;; terminate list with null
    (cond ((null? decremenda)
           decremenda)
          ((predicate (car decremenda))
           (cons (car decremenda)
                 (iter predicate (cdr decremenda))))
          (else
           (iter predicate (cdr decremenda)))))
  (cons integer (iter predicate integers)))

;(define same-parity (elem . others)
;  (let ((result (list elem)))
;    (dolist (other others)
;            (when (= (rem elem 2) (rem other 2))
;              (setf result (append result (list other)))))
;    result))


(define (list-map proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (list-map proc (cdr items)))))

(define (scale-list items factor)
  (list-map (lambda (x) (* x factor))
            items))

(define (square-list items)
  (list-map (lambda (x) (* x x))
            items))

(define (list-each applicans applicanda)
  (if (null? applicanda)
      (newline)
      (begin (applicans (car applicanda))
             (list-each applicans (cdr applicanda)))))

; tree methods
(define (list-deep-reverse tree)
  (cond ((null? tree) null)
        ((pair? (car tree))
         (append (list-deep-reverse (cdr tree))
                 (list (list-deep-reverse (car tree)))))
        (else
         (append (list-deep-reverse (cdr tree))
                 (list (car tree))))))


(define (fringe tree)
  ; why not just call this "leaves"?
  (cond ((null? tree) null)
        ((atom? tree) (list tree))
        (else
         (append (fringe (car tree))
                 (fringe (cdr tree))))))

(define (count-leaves tree)
  (cond ((null? tree) 0)
        ((atom? tree) 1)
        (else (+ (count-leaves (car tree))
                 (count-leaves (cdr tree))))))


; mobile
(define (make-mobile left right)
  ; left and right must be branches
  (list left right))

(define (left-branch mobile)
  (first mobile))

(define (right-branch mobile)
  (second mobile))

(define (make-branch length structure)
  ; structure must be either a weight or another binary mobile
  (list length structure))

(define (branch-length branch)
  (first branch))

(define (branch-structure branch)
  (second branch))

(define (is-structure-weight? structure)
  (atom? structure))

(define (weight-of-branch branch)
  (let ((struct (branch-structure branch)))
    (if (is-structure-weight? struct)
        struct
        (weight-of-mobile struct))))

(define (weight-of-mobile mobile)
  (+  (weight-of-branch (left-branch  mobile))
      (weight-of-branch (right-branch mobile))))

(define (torque-of-branch branch)
  (* (branch-length branch)
     (weight-of-branch branch)))

(define (is-branch-balanced? branch)
  ; A branch is balanced either
  ; (a) when it has a structure that's a simple weight, or
  ; (b) when the structure is a balanced mobile
  (let ((struct (branch-structure branch)))
    (or (is-structure-weight? struct)
        (is-mobile-balanced? struct))))

(define (is-mobile-balanced? mobile)
  ; A mobile is balanced when
  ; (a) the torque of its left branch equals the torque of its right branch, and
  ; (b) the left branch is balanced, and
  ; (c) the right branch is balanced
  (let ((lb (left-branch mobile))
        (rb (right-branch mobile)))
    (and (= (torque-of-branch lb) (torque-of-branch rb))
         (is-branch-balanced? lb)
         (is-branch-balanced? rb))))

(define (scale-tree tree factor)
  (list-map (lambda (sub-tree)
              (if (pair? sub-tree)
                  (scale-tree sub-tree factor)
                  (* sub-tree factor)))
            tree))

;(define (square-tree tree)
;  (list-map (lambda (sub-tree)
;              (if (pair? sub-tree)
;                  (square-tree sub-tree)
;                  (* sub-tree sub-tree)))
;            tree))


(define (tree-map proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map proc sub-tree)
             (proc sub-tree)))
       tree))

(define (square-tree tree)
  (define (square x) (* x x))
  (tree-map square tree))

(define (subsets s)
  (define nil (quote ()))
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x))
                          rest)))))

; test data
(define t0 (list (list 1 2) (list 3 4)))

(define b1 (make-branch 1 2))
(define b2 (make-branch 2 1))
(define b3 (make-branch 5 6))
(define b4 (make-branch 6 5))

(define m0 (make-mobile b1 b2))
(define m1 (make-mobile b3 b4))

(define b5 (make-branch 10 m0))
(define b6 (make-branch 10 m1))

(define m2 (make-mobile b5 b6))

