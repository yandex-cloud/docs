**Syntax:**<br/>`CASE expression
    WHEN value_1 THEN result_1
    [ WHEN value_2 THEN result_2
      ... ]
    ELSE default_result
END`<br/>or<br/>`CASE(
    expression,
    value_1, result_1,
  [ value_2, result_2,
    ... ]
    default_result
)`

Compares `expression` to `value_1`, `value_2`, ... consecutively and returns the corresponding result for the first match. If no match is found, it returns `default_result`.