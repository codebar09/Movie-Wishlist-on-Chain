;; Movie Wishlist Contract
;; Allows users to add movies to their personal watchlist and retrieve them

;; Error constants
(define-constant err-already-added (err u100))

;; Map to store user's movie wishlist
;; Key: (principal), Value: (list of ASCII strings representing movie titles)
(define-map wishlist principal (list 100 (string-ascii 100)))

;; Public function to add a movie to the wishlist
(define-public (add-movie (title (string-ascii 100)))
  (let ((current (default-to (list) (map-get? wishlist tx-sender))))
    ;; Ensure the movie is not already in the wishlist
    (asserts! (is-none (iter-find? (lambda (movie) (is-eq movie title)) current)) err-already-added)
    (map-set wishlist tx-sender (append current (list title)))
    (ok true)))

;; Read-only function to retrieve a user's wishlist
(define-read-only (get-my-wishlist)
  (ok (default-to (list) (map-get? wishlist tx-sender))))
