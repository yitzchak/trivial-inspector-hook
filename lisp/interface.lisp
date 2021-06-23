(in-package #:trivial-inspector-hook)


(defparameter *inspector-hook* nil
"When the value of *INSPECTOR-HOOK* is non-NIL, an invocation of
INSPECT in the dynamic extent of this value results in calling the
value with the object that was originally passed to INSPECT.  The
function INSPECT delegates its work to the value of *INSPECTOR-HOOK*
this way.

*INSPECTOR-HOOK* is not rebound before calling the function denoted by
the value, i.e. the function is executed in the same dynamic environment
as at the invocation of INSPECT; this is to allow inspectors to be
defined recursively.

The return value of INSPECT is independent of the return value of the
denoted function, and remains implementation-dependent.")


(defun initialize ()
  (pushnew :inspector-hook *features*)
  (pushnew :cdr-6 *features*))


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
    (initialize)))


; Support implementations that have a hook but the input and output are also passed.
#+sbcl
(let ((sym (find-symbol "*INSPECT-FUN*"
                        "SB-IMPL")))
  (when sym
    (setf (symbol-value sym) (lambda (object input output)
                               (when *inspector-hook*
                                 (let ((*standard-input* input)
                                       (*standard-output* output))
                                   (funcall *inspector-hook* object)))))
    (initialize)))

