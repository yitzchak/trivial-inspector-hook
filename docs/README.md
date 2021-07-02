# trivial-inspector-hook

A simple compatability library for `*inspector-hook*` of [CDR-6][].

## Usage

A single symbol `*inspector-hook*` is exported from the `trivial-inspector-hook`
package that follows the sematics of [CDR-6][]. This is symbol is also
available via the package nicknames of `tih` and `inspector-hook`.

If the current lisp implementation supports CDR-6 then `:cdr-6` and
`:inspector-hook` will be present in `*features*`.

## Supported Implementations

Recent versions of ABCL, ACL, CCL, CLASP, ECL, Mezzano, and SBCL all support
[CDR-6][] in some way. If the implemntation exports a symbol with a different
name other than `*inspector-hook*` then a function is installed the 
implementation's hook that calls `trivial-inspector-hook:*inspector-hook*` if 
set.

[CDR-6]: https://common-lisp.net/project/cdr/document/6/index.html
