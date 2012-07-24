; SICP site: http://mitpress.mit.edu/sicp/full-text/book/book.html
; Eli Bendersky's answers: http://eli.thegreenplace.net/2007/09/09/sicp-section-24/
; git repo: http://git.wizardbook.org/wizardbook/tree/2.4
; http://docs.plt-scheme.org/guide/hash-tables.html
;
#lang scheme ; be sure dr.scheme is running 'Module'
(require "./lib.scm")

;;
;; Operation, type -> procedure
;; Dispatch table.
;;
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
          (error "No method for these types -- APPLY-GENERIC"
                 (list op type-tags))))))

;; below only applies to tag-based dispatch
(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))
; --------------------------------------------------------
; complex number as rectangular type
; --------------------------------------------------------
(define (install-rectangular-package)
  ; private to package
  (define (real-part z)
    (car z))
  (define (imaginary-part z)
    (cdr z))
  (define (make-from-real-imag x y)
    (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imaginary-part z)))))
  (define (angle z)
    (atan (imaginary-part z)
          (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a))
          (* r (sin a))))
  ; add to dispatch table
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imaginary-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag '(rectangular)
       (lambda (x y)
         (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang '(rectangular)
       (lambda (r a)
         (tag (make-from-mag-ang r a))))
  'rectangular-installed)

; --------------------------------------------------------
; complex number as polar type
; --------------------------------------------------------
(define (install-polar-package)
  ; private to package
  (define (real-part z)
    (* (magnitude z)
       (cos (angle z))))
  (define (imaginary-part z)
    (* (magnitude z)
       (sin (angle z))))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a)
    (cons r a))
  ; add to dispatch table
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imaginary-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag '(polar)
       (lambda (x y)
         (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang '(polar)
       (lambda (r a)
         (tag (make-from-mag-ang r a))))
  'polar-installed)

(install-polar-package)
(install-rectangular-package)

; make public interface
(define (get-real z)
  (apply-generic 'real-part z))

(define (get-imag z)
  (apply-generic 'imag-part z))

(define (get-magnitude z)
  (apply-generic 'magnitude z))

(define (get-angle z)
  (apply-generic 'angle z))

(define (make-from-real-imag x y)
  ((get 'make-from-real-imag '(rectangular)) x y))

(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang '(polar)) r a))

; --------------------------------------------------------
; symbolic differentiation
; --------------------------------------------------------
; variables
(define (variable? e)
  (symbol? e))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp)
       (number? num)
       (= exp num)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var)
             1
             0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))

(define (operator exp)
  (car exp))

(define (operands exp)
  (cdr exp))


; 2.73a ... number? and variable? are predicates operating directly on built-in types
;   so they cannot be added to data-directed dispatch

(define (install-deriv-package)
  ;; internal procedures
  (define (make-sum a1 a2)
    (list '+ a1 a2))
  (define (sum? e)
    (and (pair? e)
         (eq? (car e) '+)))
  (define (addend e)
    (car e))
  (define (augend e)
    (cadr e))
 
  (define (make-product m1 m2)
    (list '* m1 m2))
  (define (multiplier e)
    (car e))  
  (define (multiplicand e)
    (cadr e))
 
  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))
 
  (define (deriv-product exp var)
    (make-sum
     (make-product (multiplier exp)
                   (deriv (multiplicand  exp) var))
     (make-product (deriv (multiplier  exp) var)
                   (multiplicand exp))))
 
  ;; interface to the rest of the system
  (put 'deriv '+ deriv-sum)
  (put 'deriv '* deriv-product)
  'deriv-installed)