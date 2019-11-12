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

Checks conditional expressions `condition_1`, `result_1`, ... and returns the matching result for the first condition found to be `TRUE`. IF all conditional expressions are `FALSE`, it returns `default_result`.