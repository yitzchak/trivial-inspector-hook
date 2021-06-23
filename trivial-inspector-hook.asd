(asdf:defsystem #:trivial-inspector-hook
  :description "A simple compatibility layer CDR6"
  :author "Tarn W. Burton"
  :license "MIT"
  :components
    ((:module lisp
      :serial t
      :components
        ((:file "packages")
         (:file "interface"))))
  . #+asdf3
      (:version "0.1"
       :homepage "https://yitzchak.github.io/trivial-inspector-hook/"
       :bug-tracker "https://github.com/yitzchak/trivial-inspector-hook/issues")
    #-asdf3 ())

