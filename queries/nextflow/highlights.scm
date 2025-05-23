(comment) @comment
(#set! "italic" true)
(#set! "foreground" "#808080")

(identifier) @identifier
(dotted_identifier) @identifier
(string) @string
(number_literal) @number

(script)
  (script_string) @string

(declaration) @keyword
(function_call) @function
(closure) @function
(juxt_function_call) @function
