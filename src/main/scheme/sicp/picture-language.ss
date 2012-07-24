; picture-language.ss

; SICP site: http://mitpress.mit.edu/sicp/full-text/book/book.html
; git repo: http://git.wizardbook.org/wizardbook/tree/2.2.4
(require "./lib.scm")

; segment
(define (make-segment start-x start-y end-x end-y)
  (list (make-vect start-x start-y) (make-vect end-x end-y)))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cadr segment))

; vector
(define (make-vect x y)
  (list x y))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cadr vect))

(define (comb-vect v1 v2 op)
  (let ((x1 (xcor-vect v1))
        (y1 (ycor-vect v1))
        (x2 (xcor-vect v2))
        (y2 (ycor-vect v2)))
    (make-vect (op x1 x2) (op y1 y2))))

(define (sub-vect v1 v2)
  (comb-vect v1 v2 -))

(define (add-vect v1 v2)
  (comb-vect v1 v2 +))

(define (scale-vect scalar vect)
  (let ((vectorized-scalar (make-vect scalar scalar)))
    (comb-vect vectorized-scalar vect *)))

; frame
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

(define (origin-frame frame)
  (car frame))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define unit-frame
  (make-frame (make-vect 0. 0.)
              (make-vect 1. 0.)
              (make-vect 0. 1.)))


(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
         (make-frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))

; painters
(define outline (list (make-segment 0 0 0 1)
                      (make-segment 0 1 1 1)
                      (make-segment 1 1 1 0)
                      (make-segment 1 0 0 0)))

(define x (list (make-segment 0 0 1 1)
                (make-segment 0 1 1 0)))

(define diamond (list (make-segment 0.5 0 1 0.5)
                      (make-segment 1 0.5 0.5 1)
                      (make-segment 0.5 1 0 0.5)
                      (make-segment 0 0.5 0.5 0)))

(define wave (list (make-segment 0 0.86 0.18 0.64)
                   (make-segment 0.18 0.64 0.32 0.66)
                   (make-segment 0.32 0.66 0.38 0.66)
                   (make-segment 0.32 0.66 0.34 0.86)
                   (make-segment 0.32 0.86 0.42 1)
                   (make-segment 0.62 1 0.66 0.86)
                   (make-segment 0.66 0.86 0.62 0.66)
                   (make-segment 0.62 0.66 0.76 0.66)
                   (make-segment 0.76 0.66 1 0.36)
                   (make-segment 1 0.16 0.62 0.46)
                   (make-segment 0.62 0.46 0.66 0)
                   (make-segment 0.54 0 0.46 0.28)
                   (make-segment 0.46 0.28 0.41 0)
                   (make-segment 0.32 0 0.34 0.52)
                   (make-segment 0.34 0.52 0.32 0.64)
                   (make-segment 0.32 0.64 0.18 0.46)
                   (make-segment 0.18 0.46 0 0.66)))


; identity
(define (identity painter)
  (transform-painter painter
                     (make-vect 0. 0.)
                     (make-vect 1. 0.)
                     (make-vect 0. 1.)))
                 	
; below
(define (below painter1 painter2)
  (let ((split-point (make-vect 0. .5)))
    (let ((paint-bottom
           (transform-painter painter1
                              (make-vect 0. 0.)
                              (make-vect 1. 0.)
                              split-point))
          (paint-top
           (transform-painter painter2
                              split-point
                              (make-vect 1. .5)
                              (make-vect 0. 1.))))
      (lambda (frame)
        (paint-bottom frame)
        (paint-top frame)))))


(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           (transform-painter painter1
                              (make-vect 0. 0.)
                              split-point
                              (make-vect 0. 1.)))
          (paint-right
           (transform-painter painter2
                              split-point
                              (make-vect 1. 0.)
                              (make-vect 0.5 1.))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

; flip vertically
(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0. 1.)
                     (make-vect 1. 1.)
                     (make-vect 0. 0.)))

; flip horizontally
(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1. 0.)
                     (make-vect 0. 0.)
                     (make-vect 1. 1.)))