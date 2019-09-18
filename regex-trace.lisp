(cl:in-package #:regex-trace)

(defmacro regex-trace (&optional regex &rest rest)
  "Trace functions whose names match REGEX."
  (if regex
      `(regex-trace-or-untrace ,regex trace ,@rest)
      `(trace ,@rest)))

(defmacro regex-untrace (&optional regex &rest rest)
  "Untrace functions whose names match REGEX."
  (if regex
      `(regex-trace-or-untrace ,regex untrace ,@rest)
      `(untrace ,@rest)))

(defmacro regex-trace-or-untrace (regex action &rest rest)
  (assert (member action '(trace untrace)))
  (let (trace-forms)
    (do-all-symbols (symbol)
      (let ((symbol-name (symbol-name symbol)))
        (when (and (fboundp symbol)
                   (not (macro-function symbol))
                   (cl-ppcre:scan regex symbol-name))
          (pushnew `(,action ,symbol ,@rest)
                   trace-forms :test #'equalp))))
    `(progn
       ,@trace-forms
       (values))))
