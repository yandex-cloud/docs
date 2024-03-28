---
title: Logical functions
editable: false
sourcePath: en/_api-ref/datalens/function-ref/logical-functions.md
---

# Logical functions


## [CASE](CASE.md)

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



## [IF](IF.md)

**Syntax:**<br/>`IF condition_1
    THEN result_1
[ ELSEIF condition_2
    THEN result_2
  ... ]
ELSE
    default_result
END`<br/>or<br/>`IF(
    condition_1, result_1,
  [ condition_2, result_2,
    ... ]
    default_result
)`

Checks conditional expressions `condition_1`, `result_1`, ... and returns the matching result for the first condition found to be `TRUE`. IF all conditional expressions are `FALSE`, it returns `default_result`. The expressions to be checked are set using logical operators.



## [IFNULL](IFNULL.md)

**Syntax:**`IFNULL( check_value, alt_value )`

Returns `check_value` if it's not `NULL`. Otherwise returns `alt_value`.



## [ISNULL](ISNULL.md)

**Syntax:**<br/>`ISNULL( expression )`<br/>or<br/>`expression IS [ NOT ] NULL`

Returns `TRUE` if `expression` is `NULL`, otherwise returns `FALSE`.

`expression IS NOT NULL` returns the opposite result.



## [ZN](ZN.md)

**Syntax:**`ZN( expression )`

Returns `expression` if it's not `NULL`. Otherwise returns 0.


