; SICP site: http://mitpress.mit.edu/sicp/full-text/book/book.html
; Eli Bendersky's answers: http://eli.thegreenplace.net/category/programming/lisp/sicp/

(require "./lib.scm")

(define (my-filter predicate sequence)
  (cond ((null? sequence) null)
        ((predicate (car sequence))
         (cons (car sequence)
               (my-filter predicate (cdr sequence))))
        (else (my-filter predicate (cdr sequence)))))

(define (enumerate-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

; test date
(define test (list 1 2 3 4 5))

(define tree (list 1 (list 2 (list 3 4)) 5))

(define (sum-odd-squares tree)
  (fold-right + 0 (map square
                       (filter odd?
                               (enumerate-tree tree)))))


(define (even-fibs n)
  (fold-right cons null
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))

(define (list-fib-squares n)
  (fold-right cons null
              (map square
                   (map fib
                        (enumerate-interval 0 n)))))


; exercise 2.33 of SICP

(define (map-using-fold-right proc sequence)
  (fold-right (lambda (x y)
                (cons (proc x) y))
              null
              sequence))

(define (append-using-fold-right sequence1 sequence2)
  (fold-right cons
              sequence2
              sequence1))

(define (length-using-fold-right sequence)
  (fold-right (lambda (x y) (++ y))
              0
              sequence))

; exercise 2.34 of SICP
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+  (* higher-terms x) this-coeff) )
              0
              coefficient-sequence))

; exercise 2.35 of SICP
(define (count-leaves tree)
  (accumulate (lambda (x y) (+ y
                               (if (pair? x)
                                   (count-leaves x)
                                   1)))
              0
              tree))


; exercise 2.36 of SICP
; similar to accumulate except seq-of-sequences is a sequence of sequences,
; each of which has the same number of elements. It iteratively applies the given op
; to the each elements of the sequences.
(define (accumulate-n op init seq-of-sequences)
  (if (null? (car seq-of-sequences))
      null
      (cons (accumulate   op init (map car seq-of-sequences))
            (accumulate-n op init (map cdr seq-of-sequences)))))

; exercise 2.37 of SICP
;  let vectors: v = (v_i) be a sequence of numbers
;  let matrices m = (m_ij) be a sequence of vectors
;  so ((1 2 3) (4 5 6) (7 8 9)) is a 3x3 matrix s.t. m_33 = 9
; 	
;  implement
;     (dot-product v w) : returns the sum over i of v_i * w_i
;     (matrix-*-vector m v) : returns the vector t, where t_i = sum over j of m_ij * v_j
;     (matrix-*-matrix m n) : returns the marix p, where p_ij = sum over k of m_ik * n_kj
;     (transpose m) : returns the matrix n, where n_ij = m_ji

(define (dot-product vector wector)
  (accumulate + 0 (map * vector wector)))

(define (matrix-*-vector matrix vector)
  (map (lambda (row)
         (dot-product row vector))
       matrix))

(define (transpose matrix)
  (accumulate-n cons null matrix))

(define (matrix-*-matrix matrix natrix)
  (let ((natrix-t (transpose natrix)))
    (map (lambda (row)
           (matrix-*-vector natrix-t row))
         matrix)))

; exercise 2.38 of SICP
(define (accumulate fn initial sequence)
  (fold-right fn initial sequence))


; ex 2.39 of SICP ... not deep reverses
(define (reverse-r seq)
  (fold-right (lambda (x y)
                (append y (list x)))
              null
              seq))

(define (reverse-l seq)
  (fold-left (lambda (x y)
               (cons y x))
             null
             seq))

; given integer n > 0, find all ordered pairs of
; distinct positive integers i and j where
;  1 <= j < i <= n s.t. i + j is prime
;
; a) generate sequence of all ordered pairs of positive integers less than or equal to  n
; b) filter to select those pairs whose sum is prime
; c) then for each filtered pair, produce the triple (i, j, i + j)

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (prime-sum? pair)
  ; predicate prime? needs to reuse an impl in lib.scm
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair)
        (cadr pair)
        (+ (car pair) (cadr pair))))

(define (prime-sum-pairs-c n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap (lambda (i)
                          (map (lambda (j) (list i j))
                               (enumerate-interval 1 (-- i))))
                        (enumerate-interval 1 n)))))

; (lambda (i) (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1))))
; (enumerate-interval 1 6)

; exercise 2.40
(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map (lambda (j)
            (list i j))
          (enumerate-interval 1 (-- i))))
   (enumerate-interval 2 n)))

(define (prime-sum-pairs n)
  (map make-pair-sum  
       (filter prime-sum?
               (unique-pairs n))))

; exercise 2.41

(define (unique-triples n)
  ; Unique triples of numbers <= n
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k) (list i j k))
                             (enumerate-interval 1 (-- j))))
                      (enumerate-interval 1 (-- i))))
           (enumerate-interval 1 n)))

; exercise 2.42
; checks not horiz
(define (make-position row col)
  (cons row col))

(define (position-row pos)
  (car pos))

(define (position-col pos)
  (cdr pos))

(define (positions-equal? a b)
  (equal? a b))


(define (adjoin-position row col positions)
  (append positions
          (list (make-position row col))))

(define (attacks? a b)
  ; Both a and b are positions. This function
  ; checks if a queen in position a attacks the
  ; queen in position b.
  (let ((a-row (position-row a))
        (a-col (position-col a))
        (b-row (position-row b))
        (b-col (position-col b)))
    (cond
      ((= a-row b-row) true) ; row attack
      ((= a-col b-col) true) ; column attack
      ((= (abs (- a-col b-col)) ; diagonal attack
          (abs (- a-row b-row))) true)
      (else
       false))))

(define (safe? k positions)
  ; Is the queen in the kth column safe with
  ; respect to the queens in columns 1..k-1?
  (let ((kth-pos (list-ref positions (-- k))))
    (findf
     (lambda (pos)
       (and  (not (positions-equal? kth-pos pos))
             (attacks? kth-pos pos)))
     positions)))

(define (empty-board) '())


(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter (lambda (positions)
                  (safe? k positions))
                (flatmap (lambda (rest-of-queens)
                           (map (lambda (new-row)
                                  (adjoin-position new-row k rest-of-queens))
                                (enumerate-interval 1 board-size)))
                         (queen-cols (-- k))))))
  (queen-cols board-size))