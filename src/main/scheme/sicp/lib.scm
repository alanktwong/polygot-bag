; SICP site: http://mitpress.mit.edu/sicp/full-text/book/book.html
; Eli Bendersky's answers: http://eli.thegreenplace.net/category/programming/lisp/sicp/
; git repo: http://git.wizardbook.org/wizardbook/tree
; SICP wiki: http://sicp.org.ua/sicp/FrontPage
;
; --------------------------------------------------------
; lib.scm
; --------------------------------------------------------
#lang scheme

(define (square x) (* x x))

(define (++ x) (+ x 1))

(define (-- x) (- x 1))

; --------------------------------------------------------
(define (compose f g)
  (define (f*g x)
    (f (g x)))
  f*g)


(define (fib n)
  (define (iter a b count)
    (if (= count 0)
        b
        (iter (+ a b) a (- count 1))))
  (iter 1 0 n))


(define (prime? n)
  ; primality test based on miller-rabin test
  (define (even? m)
    (= (remainder m 2) 0))
  ; exponent of base modulo m
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m)) m))
          (else
           (remainder (* base (expmod base (- exp 1) m)) m))
          ))
  ; can this be refactored to reuse expmod?
  (define (expmod-miller-rabin base exp m)
    ;; Return 0 if we've discovered a ``non-trivial square-root of 1-modulo-n.''
    (cond ((= exp 0)
           1)
          ((even? exp)
           ;; I assume that we check for square roots here.
           (if (and (not (or (= base 1) (= base exp)))
                    (= (expmod base 2 m) 1))
               0
               (remainder (square (expmod base (/ exp 2) m)) m)))
          (else
           (remainder (* base (expmod base (- exp 1) m)) m))))
  ;
  (define (miller-rabin-test n)
    (define (try-it a)
      (define a-n-1-mod-n
        (expmod-miller-rabin a (- n 1) n))
      (and (not (zero? a-n-1-mod-n))
           (= a-n-1-mod-n 1)))
    (try-it (+ 1 (random (- n 1)))))
  ;
  (define (miller-rabin-prime? n times)
    (cond ((= times 0)
           #t)
          ((miller-rabin-test n)
           (miller-rabin-prime? n (- times 1)))
          (else
           #f)))
  (miller-rabin-prime? n 10))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

; --------------------------------------------------------


(define (fold-right fn initial sequence)
  ; fold-right (aka accumulate) combines the given initial value
  ; with the result of combining the elements of the sequence
  ; using the given two-place function, fn.
  (if (null? sequence)
      initial
      (fn (car sequence)
          (fold-right fn
                      initial
                      (cdr sequence)))))


(define (fold-left fn initial sequence)
  ; fold-left recursively combines the elements of the elements of the sequence
  ; with the given initial value, using the given two-place function, fn.
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (fn result (car rest))
              (cdr rest))))
  (iter initial sequence))


; exercise 2.54
(define (equals? thiz that)
  (cond
    ((and (null? thiz)
          (null? that))
     true)
    ((or (and (null? that)
              (not (null? thiz)))
         (and (null? thiz)
              (not (null? that))))
     false)
    ((and (pair? thiz)
          (pair? that))
     (and (equals? (car thiz)
                   (car that))
          (equals? (cdr thiz)
                   (cdr that))))
    ((and (symbol? thiz)
          (symbol? that))
     (eq? thiz that))
    (else
     (eq? thiz that))))


; --------------------------------------------------------
;;
;; Operation, type -> procedure
;; Dispatch table.
;;
; --------------------------------------------------------
(define *coercion-table* (make-hash))

(define (put-coercion from to proc)
  (hash-set! *coercion-table* (list from to) proc))

(define (get-coercion from to)
  (hash-ref *coercion-table* (list from to) #f))

(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) #f))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                  (cond (t1->t2
                         (apply-generic op (t1->t2 a1) a2))
                        (t2->t1
                         (apply-generic op a1 (t2->t1 a2)))
                        (else
                         (error "No method for these types" (list op type-tags))))))
              (error "No method for these types -- APPLY-GENERIC" (list op type-tags)))))))

;; below only applies to tag-based dispatch
(define (attach-tag type-tag contents)
  (if (number? contents)
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (cond ((number? datum)
         'scheme-number)
        ((pair? datum)
         (car datum))
        (else
         (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond ((number? datum) datum)
        ((pair? datum) (cdr datum))
        (else
         (error "Bad tagged datum -- CONTENTS" datum))))


(provide square
         ++
         --
         *coercion-table*
         put-coercion
         get-coercion
         *op-table*
         put
         get
         apply-generic
         attach-tag
         type-tag
         contents
         fib
         prime?
         equals?
         enumerate-interval
         fold-right
         fold-left)