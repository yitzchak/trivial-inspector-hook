(in-package #:trivial-inspector-hook)


(defparameter *inspector-hook* nil)


; Support implementations that have an existing hook.
#+(or abcl ccl clasp ecl)
(let ((sym (find-symbol #+(or abcl clasp ecl) "*INSPECTOR-HOOK*"
                        #+ccl "*DEFAULT-INSPECTOR-UI-CREATION-FUNCTION*"
                        #+mezzano "*INSPECT-HOOK*"
                        ; The package
                        #+(or abcl clasp ecl) "EXT"
                        #+ccl "INSPECTOR"
                        #+mezzano "MEZZANO.EXTENSIONS")))
  (when sym
    (shadowing-import sym "TRIVIAL-INSPECTOR-HOOK")
    (export (find-symbol "*INSPECTOR-HOOK*" "TRIVIAL-INSPECTOR-HOOK"))
    (pushnew :inspector-hook *features*)
    (pushnew :cdr-6 *features*)))


; Support implementations that have a hook but the input and output are also passed.
#+sbcl
(let ((sym (find-symbol "*INSPECT-FUN*"
                        "SB-IMPL")))
  (when sym
    (setf (symbol-value sym) (lambda (object input output)
                               (declare (ignore input output))
                               (when *inspector-hook*
                                 (funcall *inspector-hook* object))))
    (pushnew :inspector-hook *features*)
    (pushnew :cdr-6 *features*)))

