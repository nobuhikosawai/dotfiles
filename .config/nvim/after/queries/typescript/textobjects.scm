; extends
(type_alias_declaration
  value: (_) @declaration.inner) @declaration.outer
(interface_declaration) @declaration.outer

(import_statement) @statement.outer
(return_statement) @statement.outer
(expression_statement) @statement.outer
