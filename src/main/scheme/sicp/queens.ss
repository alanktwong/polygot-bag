; queens.ss


(define (safe? k queens)
  (define (problem-horiz? k-queen-row queens num-at)
    (cond
      ; we've tried them all
      ((eq? queens null) #f)
      ; this is comparing against itself
      ((= k num-at) #f)
      ; the row of current queen is the same as kth queen
      ((= k-queen-row (car queens)) #t)
      (else
       (problem-horiz? k-queen-row
                       (cdr queens)
                       (++ num-at)))))
  (define (problem-diag? k-row k-col queens num-at)
    ; (display k-row) (display " ") (display k-col)
    ; (display queens) (display num-at) (display "\n")
    (let ((queen-top-diag-at-k (+ (car queens) (- k-col num-at)))
          (queen-bot-diag-at-k (- (car queens) (- k-col num-at))))
      ; (display queen-top-diag-at-k) (display " ") (display queen-bot-diag-at-k) (display "\n")
      (cond
        ; we've tried them all
        ((eq? queens null) #f)
        ; this is comparing against itself, thus tried all previous
        ((= k num-at) #f)
        ((or (= k-row queen-top-diag-at-k)
             (= k-row queen-bot-diag-at-k)) #t)
        (else (problem-diag? k-row k-col
                             (cdr queens)
                             (+ 1 num-at))))))
  (and (not (problem-horiz? (list-ref queens (-- k))
                            queens 1))
       (not (problem-diag? (list-ref queens (-- k))
                           k queens 1))))

(define (adjoin-position row col rest-of-queens)
  ; cheats a little bit, given that the col is implicit to the ordering
  (append rest-of-queens (list row)))

(define (queens board-size)
  (define empty-board '())
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions)
           (safe? k positions))
         (flatmap ; for all second lists within the main list, flatten
          (lambda (rest-of-queens) ; for each possibility
            (map (lambda (new-row) ; for each new row
                   (adjoin-position new-row k rest-of-queens)) ;add this row to each possibility
                 (enumerate-interval 1 board-size)))
          (queen-cols (-- k)))))) ; this is all possibilities
  (queen-cols board-size))