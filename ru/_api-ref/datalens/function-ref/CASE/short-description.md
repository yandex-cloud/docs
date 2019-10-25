**Синтаксис:**<br/>`CASE expression
    WHEN value_1 THEN result_1
    [ WHEN value_2 THEN result_2
      ... ]
    ELSE default_result
END`<br/>или<br/>`CASE(
    expression,
    value_1, result_1,
  [ value_2, result_2,
    ... ]
    default_result
)`

Сравнивает выражение `expression` с последовательностью значений `value_1`, `value_2`, ... и возвращает результат для первого совпадения.
Если совпадений не найдено, то возвращает `default_result`.