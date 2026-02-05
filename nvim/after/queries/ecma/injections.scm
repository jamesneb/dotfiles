; extends

; /*wgsl*/ `...`
((comment) @_wgsl_comment
  (#match? @_wgsl_comment "wgsl")
  .
  (template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "wgsl"))

