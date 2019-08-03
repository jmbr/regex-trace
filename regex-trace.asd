(cl:defpackage #:regex-trace-system
  (:use #:common-lisp #:asdf))

(cl:in-package #:regex-trace-system)

(defsystem #:regex-trace
  :description "Trace macro with regular expression support."
  :author "Juan M. Bello Rivas <jmbr@superadditive.com>"
  :licence "X11"
  :depends-on (#:cl-ppcre)
  :serial t
  :components ((:file "package")
               (:file "regex-trace"))
  :in-order-to ((test-op (test-op "regex-trace/tests"))))

(delete-package *package*)
