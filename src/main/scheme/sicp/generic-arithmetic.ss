; SICP site: http://mitpress.mit.edu/sicp/full-text/book/book.html
; Eli Bendersky's answers: http://eli.thegreenplace.net/2007/09/14/sicp-section-251/
; git repo: http://git.wizardbook.org/wizardbook/tree/2.5.1
; http://docs.plt-scheme.org/guide/hash-tables.html
;
#lang scheme ; be sure dr.scheme is running 'Module'
(require "./lib.scm")

; generic arithmetic
(define (add x y)
  (apply-generic 'add x y))

(define (sub x y)
  (apply-generic 'sub x y))

(define (mul x y)
  (apply-generic 'mul x y))

(define (div x y)
  (apply-generic 'div x y))

; --------------------------------------------------------
; install scheme-number-package
; --------------------------------------------------------
(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'make '(scheme-number)
       (lambda (x) (tag x)))
  'scheme-number-package-installed)

(define (make-scheme-number n)
  ((get 'make '(scheme-number)) n))



(install-scheme-number-package)
(install-rational-package)

(install-rectangular-package)
(install-polar-package)
(install-complex-package)

(define (scheme-number->complex n)
  (make-complex-from-real-imag (contents n) 0))

(put-coercion 'scheme-number 'complex scheme-number->complex)