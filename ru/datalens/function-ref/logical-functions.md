---
title: Логические функции
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/logical-functions.md
---

# Логические функции


## [CASE](CASE.md)

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



## [IF](IF.md)

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



## [IFNULL](IFNULL.md)

**Синтаксис:**`IFNULL( check_value, alt_value )`

Возвращает `check_value`, если оно не `NULL`. В противном случае возвращает `alt_value`.



## [ISNULL](ISNULL.md)

**Синтаксис:**<br/>`ISNULL( expression )`<br/>или<br/>`expression IS [ NOT ] NULL`

Возвращает `TRUE`, если `expression` является `NULL`. В противном случае возвращает `FALSE`.

Вариант `expression IS NOT NULL` возвращает противоположное значение.



## [ZN](ZN.md)

**Синтаксис:**`ZN( expression )`

Возвращает значение выражения `expression`, если оно не `NULL`. В противном случае возвращает 0.


