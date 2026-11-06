
#lang frog/config

;; Called early when Frog launches. Use this to set parameters defined
;; in frog/params.
(define/contract (init)
  (-> any)
  (current-scheme/host "http://alex-1q84.github.io")
  (current-title "庭燎之光")
  (current-author "Alex-1Q84")
  ;; watch 模式（make preview）：_src 内任何文件变化（含 page-template.html
  ;; 模板）都触发重建；轮询周期 2 秒，保存后约 2~3 秒可见
  (current-rebuild? (lambda (path change-type) #t))
  (current-watch-rate 2))

;; Called once per post and non-post page, on the contents.
(define/contract (enhance-body xs)
  (-> (listof xexpr/c) (listof xexpr/c))
  ;; Here we pass the xexprs through a series of functions.
  (~> xs
      (syntax-highlight #:python-executable (if (eq? (system-type) 'windows)
                                                "python.exe"
                                                "python3")
                        #:line-numbers? #f
                        #:css-class "source")
      (auto-embed-tweets #:parents? #f)
      (add-racket-doc-links #:code? #t #:prose? #f)))

;; Called from `raco frog --clean`.
(define/contract (clean)
  (-> any)
  (void))
