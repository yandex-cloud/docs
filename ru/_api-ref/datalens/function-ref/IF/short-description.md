**Синтаксис:**<br/>`IF condition_1
    THEN result_1
[ ELSEIF condition_2
    THEN result_2
  ... ]
ELSE
    default_result
END`<br/>или<br/>`IF(
    condition_1, result_1,
  [ condition_2, result_2,
    ... ]
    default_result
)`

Проверяет последовательно логические выражения `condition_1`, `condition_2`, ... и возвращает соответсвующий результат для первого выполнения.
Если все `condition_1`, `condition_2`, ... возвращают `FALSE`, то блок возвращает `default_result`.