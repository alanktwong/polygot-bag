; --------------------------------------------------------
; complex number as rectangular type
; --------------------------------------------------------
(define (install-rectangular-package)
  ; private to package
  (define (get-real z)
    (car z))
  (define (get-imag z)
    (cdr z))
  (define (make-from-real-imag x y)
    (cons x y))
  (define (get-magnitude z)
    (sqrt (+ (square (get-real z))
             (square (get-imag z)))))
  (define (get-angle z)
    (atan (get-imag z)
          (get-real z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a))
          (* r (sin a))))
  ; add to dispatch table
  (define (tag x)
    (attach-tag 'rectangular x))
  (put 'get-real '(rectangular) get-real)
  (put 'get-imag '(rectangular) get-imag)
  (put 'get-magnitude '(rectangular) get-magnitude)
  (put 'get-angle '(rectangular) get-angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y)
         (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a)
         (tag (make-from-mag-ang r a))))
  'rectangular-installed)

; --------------------------------------------------------
; complex number as polar type
; --------------------------------------------------------
(define (install-polar-package)
  ; private to package
  (define (get-real z)
    (* (get-magnitude z)
       (cos (get-angle z))))
  (define (get-image z)
    (* (get-magnitude z)
       (sin (get-angle z))))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
  (define (get-magnitude z) (car z))
  (define (get-angle z) (cdr z))
  (define (make-from-mag-ang r a)
    (cons r a))
  ; add to dispatch table
  (define (tag x)
    (attach-tag 'polar x))
  (put 'get-real '(polar) get-real)
  (put 'get-imag '(polar) get-imag)
  (put 'get-magnitude '(polar) get-magnitude)
  (put 'get-angle '(polar) get-angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y)
         (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a)
         (tag (make-from-mag-ang r a))))
  'polar-installed)

; --------------------------------------------------------
; instaling complex-number-package
; --------------------------------------------------------
(define (install-complex-package)
  ; abstract methods which are implemented by polar or rectangular
  (define (get-real z)
    (apply-generic 'get-real z))
  (define (get-imag z)
    (apply-generic 'get-imag z))
  (define (get-magnitude z)
    (apply-generic 'get-magnitude z))
  (define (get-angle z)
    (apply-generic 'get-angle z))
 
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
 
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (get-real z1)
                            (get-real z2))
                         (+ (get-imag z1)
                            (get-imag z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (get-real z1)
                            (get-real z2))
                         (- (get-imag z1)
                            (get-imag z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (get-magnitude z1)
                          (get-magnitude z2))
                       (+ (get-angle z1)
                          (get-angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (get-magnitude z1)
                          (get-magnitude z2))
                       (- (get-angle z1)
                          (get-angle z2))))
 
  (define (tag x)
    (attach-tag 'complex x))
  (put 'get-real '(complex) get-real)
  (put 'get-imag '(complex) get-imag)
  (put 'get-magnitude '(complex) get-magnitude)
  (put 'get-angle '(complex) get-angle)
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'complex-package-installed)

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

(define (get-real z)
  ((get 'get-real '(complex)) z))
(define (get-imag z)
  ((get 'get-imag '(complex)) z))
(define (get-magnitude z)
  ((get 'get-magnitude '(complex)) z))
(define (get-angle z)
  ((get 'get-angle '(complex)) z))

