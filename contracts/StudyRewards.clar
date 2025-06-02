;; StudyRewards: Educational Achievement Tracking System
;; Version: 1.0.0

(define-data-var education-coordinator principal tx-sender)
(define-data-var knowledge-pool uint u0)
(define-data-var learning-bonus uint u75) ;; bonus points added per block
(define-data-var bonus-timestamp uint u0) ;; last block when bonuses were calculated
(define-map student-progress principal uint)

;; Helper function to ensure only the education coordinator can perform certain actions
(define-private (is-coordinator (caller principal))
  (begin
    (asserts! (is-eq caller (var-get education-coordinator)) (err u200))
    (ok true)))

;; Initialize the educational system
(define-public (launch-program (coordinator principal))
  (begin
    (asserts! (is-none (map-get? student-progress coordinator)) (err u201))
    (var-set education-coordinator coordinator)
    (ok "StudyRewards program launched")))

;; Add study sessions to the system
(define-public (record-study-sessions (sessions uint))
  (begin
    (asserts! (> sessions u0) (err u202))
    (let ((current-progress (default-to u0 (map-get? student-progress tx-sender))))
      (map-set student-progress tx-sender (+ current-progress sessions))
      (var-set knowledge-pool (+ (var-get knowledge-pool) sessions))
      (ok (+ current-progress sessions)))))

;; Calculate learning bonuses for all students
(define-public (distribute-learning-bonuses)
  (begin
    (try! (is-coordinator tx-sender))
    (let ((current-block tenure-height)
          (previous-update (var-get bonus-timestamp)))
      (asserts! (> current-block previous-update) (err u203))
      ;; Calculate bonuses based on blocks elapsed
      (let ((elapsed (- current-block previous-update))
            (total-bonus (* elapsed (var-get learning-bonus))))
        (var-set bonus-timestamp current-block)
        (var-set knowledge-pool (+ (var-get knowledge-pool) total-bonus))
        (ok total-bonus)))))

;; Claim study progress and bonuses
(define-public (claim-achievements)
  (begin
    (let ((student-achievement (default-to u0 (map-get? student-progress tx-sender))))
      (asserts! (> student-achievement u0) (err u204))
      (let ((total-progress (var-get knowledge-pool))
            (total-bonus (* (var-get learning-bonus) (- tenure-height (var-get bonus-timestamp))))
            (proportion (/ (* student-achievement u100000) total-progress)))
        ;; Update progress and calculate bonus proportion
        (let ((bonus-portion (/ (* proportion total-bonus) u100000)))
          (map-delete student-progress tx-sender)
          (var-set knowledge-pool (- (var-get knowledge-pool) student-achievement))
          (ok (+ student-achievement bonus-portion)))))))