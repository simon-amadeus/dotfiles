; Blacklight override for Rust — extends Zed's default rust highlights.
; Place at ~/.config/zed/languages/rust/highlights.scm
; Adds a @variant capture for enum variants so the "Ember" theme can tint them.
; Everything else keeps Zed's built-in captures.

(enum_variant name: (identifier) @variant)
(scoped_identifier
  path: (identifier) @type
  name: (identifier) @variant
  (#match? @type "^[A-Z]"))
(scoped_identifier
  path: (scoped_identifier name: (identifier) @type)
  name: (identifier) @variant
  (#match? @type "^[A-Z]"))
(scoped_type_identifier
  path: (identifier) @type
  name: (type_identifier) @variant
  (#match? @type "^[A-Z]"))
