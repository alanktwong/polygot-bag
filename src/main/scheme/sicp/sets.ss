; SICP site: http://mitpress.mit.edu/sicp/full-text/book/book.html
; Eli Bendersky's answers: http://eli.thegreenplace.net/2007/09/11/sicp-section-233/
; git repo: http://git.wizardbook.org/wizardbook/tree/2.3.3

(require "./lib.scm")

; --------------------------------------------------------
; sets as unordered lists
; --------------------------------------------------------
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equals? x (car set)) true)
        (else
         (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2))
         '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else
         (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (if (null? set1)
      set2
      (adjoin-set (car set1)
                  (union-set (cdr set1) set2))))

; --------------------------------------------------------
; bags as unordered lists
; --------------------------------------------------------
(define (element-of-bag? x bag)
  (element-of-set? x bag))

(define (adjoin-bag x bag)
  (cons x bag))

(define (intersection-bag bag1 bag2)
  (cond ((or (null? bag1) (null? bag2))
         '())
        ((element-of-bag? (car bag1) bag2)
         (adjoin-bag (car bag1)
                     (intersection-bag (cdr bag1) bag2)))
        (else
         (intersection-bag (cdr bag1) bag2))))

(define (union-bag bag1 bag2)
  (if (null? bag1)
      bag2
      (append  bag1 bag2)))

; --------------------------------------------------------
; sets as ordered lists
; --------------------------------------------------------
(define (element-of-sortedset? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else
         (element-of-set? x (cdr set)))))

(define (intersection-sortedset set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-sortedset (cdr set1) (cdr set2))))
              ((< x1 x2)
               (intersection-sortedset (cdr set1) set2))
              ((> x1 x2)
               (intersection-sortedset set1 (cdr set2)))))))


(define (adjoin-sortedset x set)
  (cond ((null? set)
         (list x))
        ((= x (car set))
         set)
        ((< x (car set))
         (cons x set))
        (else
         (cons (car set)
               (adjoin-sortedset x (cdr set))))))


(define (union-sortedset set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (let ((x1 (car set1))
               (x2 (car set2))
               (cdr1 (cdr set1))
               (cdr2 (cdr set2)))
           (cond ((= x1 x2)
                  (cons x1 (union-sortedset cdr1 cdr2)))
                 ((< x1 x2)
                  (cons x1 (union-sortedset cdr1 set2)))
                 ((> x1 x2)
                  (cons x2 (union-sortedset set1 cdr2))))))))

; --------------------------------------------------------
; sets as binary tree
; --------------------------------------------------------
(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-treeset? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-treeset? x (left-branch set)))
        ((> x (entry set))
         (element-of-treeset? x (right-branch set)))))

(define (adjoin-treeset x set)
  (cond ((null? set)
         (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-treeset x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-treeset x (right-branch set))))))


(define (tree->list-1 tree)
  ; does not use an iterative/memoized recursion
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  ; does  use an iterative/memoized recursion
  ; this will perform better wrt size of tree
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))


(define (list->tree elements)
  ; turn an ordered list into a balanced tree
  (car (partial-tree elements
                     (length elements))))

(define (partial-tree elts n)
  ;; Divides list into two equal parts: left, right (the right part
  ;; getting one or two extra elements: odd, even; respectively). It
  ;; uses the first element of the right half as the root. It then
  ;; successively processes the remaining right and left parts in a
  ;; similar fashion until n = 0; at which point there is a leaf (and it
  ;; cons nil).
  ;;
  ;; What is the order of growth?
  ;; To process either given half of the tree, should be theta(log n)
  ;; (cf. binary search). Together, however, they are not worse than
  ;; theta(n), since each element must be processed.  
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))


(define (union-treeset tree1 tree2)
  (list->tree
   (union-sortedset (tree->list-2 tree1)
                    (tree->list-2 tree2))))

(define (intersection-treeset tree1 tree2)
  (list->tree
   (intersection-sortedset (tree->list-2 tree1)
                           (tree->list-2 tree2))))


;; lookup-record to mock a database
(define (make-record key value)
  (list key value))

(define record-tree
  ; hardcoded to PKs 1 3 5 7 9 11
  (make-tree (make-record 5 true)
             (make-tree (make-record 3 true)
                        (make-tree (make-record 1 true) '() '())
                        '())
             (make-tree (make-record 9 true)
                        (make-tree (make-record 7 true)
                                   '()
                                   '())
                        (make-tree (make-record 11 true)
                                   '()
                                   '()))))

(define (lookup given-key tree-of-records)
  (define (key record)
    (car record))
  (let* ((this-record (entry tree-of-records))
         (this-key (key this-record))
         (smaller-records (left-branch tree-of-records))
         (larger-records (right-branch tree-of-records)))
    (cond ((null? tree-of-records) false)
          ((equal? given-key this-key) this-record)
          ((< given-key this-key) (lookup given-key smaller-records))
          ((> given-key this-key) (lookup given-key larger-records)))))
