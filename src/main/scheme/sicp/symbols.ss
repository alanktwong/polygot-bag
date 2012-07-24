; SICP site: http://mitpress.mit.edu/sicp/full-text/book/book.html
; Eli Bendersky's answers: http://eli.thegreenplace.net/category/programming/lisp/sicp/
; git repo: http://git.wizardbook.org/wizardbook/tree/2.3.2
(define (semq item x)
  (cond ((null? x)
         false)
        ((eq? item (car x))
         x)
        (else
         (semq item (cdr x)))))

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

; sums
(define (make-sum a1 a2)
  (cond
    ((=number? a1 0)
     a2)
    ((=number? a2 0)
     a1)
    ((and (number? a2)
          (number? a1))
     (+ a1 a2))
    (else
     (list sum-symbol a1 a2))))

(define sum-symbol '+)

(define (sum? e)
  (and (pair? e)
       (eq? (car e) sum-symbol)))

(define (addend e)
  (cadr e))

(define (augend e)
  (if (> (length e) 3)
      (append (list sum-symbol) (cddr e))
      (caddr e)))

; products
(define (make-product m1 m2)
  (cond
    ((or (=number? m1 0)
         (=number? m2 0))
     0)
    ((=number? m1 1)
     m2)
    ((=number? m2 1)
     m1)
    ((and (number? m1)
          (number? m2))
     (* m1 m2))
    (else
     (list product-symbol m1 m2))))

(define (product? e)
  (and (pair? e)
       (eq? (car e) product-symbol)))

(define product-symbol '*)

(define (multiplier e)
  (cadr e))

(define (multiplicand e)
  (if (> (length e) 3)
      (append (list product-symbol) (cddr e))
      (caddr e)))

; exponents
(define (make-exponent base exp)
  (cond
    ((=number? exp 0)
     1)
    ((=number? exp 1)
     base)
    ((and (number? base)
          (number? exp))
     (expt base exp))
    ((number? exp)
     (list exponent-symbol base exp))
    (else
     (error "exp must be a number"))))

(define (exponent? e)
  (and (pair? e)
       (eq? (car e) exponent-symbol)))

(define exponent-symbol '^)

(define (base e)
  (cadr e))

(define (exponent e)
  (caddr e))

; derivatives
(define (deriv exp var)
  (cond
    ((number? exp)
     0)
    ((variable? exp)
     (if (same-variable? exp var)
         1
         0))
    ((sum? exp)
     (make-sum
      (deriv (addend exp) var)
      (deriv (augend exp) var)))
    ((product? exp)
     (make-sum
      (make-product (multiplier exp)
                    (deriv (multiplicand exp) var))
      (make-product (deriv (multiplier exp) var)
                    (multiplicand exp))))
    ((exponent? exp)
     (make-product
      (make-product
       (exponent exp)
       (make-exponent (base exp)
                      (- (exponent exp) 1)))
      (deriv (base exp) var)))
    (else
     (error "unknown expression type -- DERIV" exp))))


; for a general infix solution, see http://eli.thegreenplace.net/2007/08/30/sicp-sections-231-232/