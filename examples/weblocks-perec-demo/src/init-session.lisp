;;;;; -*- mode: common-lisp;   common-lisp-style: modern;    coding: utf-8; -*-
;;;;;

(in-package :weblocks-perec-demo)




(defwebapp weblocks-perec-demo
    :description "A web application based on Weblocks"
    :init-user-session	'init-user-session :public-files-cache-time 100000
    :dependencies '((:stylesheet "suggest")))



;; ;; Application dependencies
;; (setf *application-public-dependencies*
;;       (append (public-files-relative-paths
;; 	       '(:stylesheet . "suggest"))
;; 	      *application-public-dependencies*))

;; Define callback function to initialize new sessions. The function
;; initializes a sandbox store for the new user and sets up a
;; continuation flow. It then renders the initial page.
;;
;; After the initial page answers, INIT-USER-SESSION sets
;; RENDER-HEADER as a prefix for the main composite so that header is
;; seen on all pages (similar behavior could be accomplished by
;; placing this function into the layout made by MAKE-MAIN-PAGE, but
;; this would prevent the header from being displayed in some cases
;; like dialogs invoked with JavaScript turned off).
;;
;; The control is then passed to main page. The main page is never
;; expected to answer.


(defun init-user-session (comp)
  (with-flow comp
    (yield (make-widget #'initial-page))
    (setf (widget-prefix-fn comp) #'render-header)
    (yield (make-main-page))))

