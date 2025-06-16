(define-map movie-wishlist
  {user: principal}                  ;; key
  {movie: (string-utf8 100)})       ;; value

(define-data-var total-wishlist uint u0)

(define-constant err-empty-title (err u100))

;; Public: Submit a movie to the wishlist
(define-public (submit-movie (title (string-utf8 100)))
  (begin
    (asserts! (> (len title) u0) err-empty-title)
    (map-set movie-wishlist {user: tx-sender} {movie: title})
    (var-set total-wishlist (+ (var-get total-wishlist) u1))
    (ok true)))

;; Read-only: Get total number of movie wishlist submissions
(define-read-only (get-total-wishlist)
  (ok (var-get total-wishlist)))
