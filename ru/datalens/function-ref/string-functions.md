---
title: Строковые функции
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/string-functions.md
---

# Строковые функции


## [ASCII](ASCII.md)

**Синтаксис:**`ASCII( string )`

Возвращает числовое представление первого символа строки.



## [CHAR](CHAR.md)

**Синтаксис:**`CHAR( string )`

Преобразовывает числовое представление символа ASCII в значение.



## [CONCAT](CONCAT.md)

**Синтаксис:**`CONCAT( arg_1, arg_2, arg_3 [ , ... ] )`

Объединяет произвольное количество строк. При использовании нестроковых типов происходит преобразование в строку и объединение.



## [CONTAINS](CONTAINS.md)

**Синтаксис:**`CONTAINS( string, substring )`

Возвращает `TRUE`, если строка `string` содержит в себе подстроку `substring`. Для регистронезависимой проверки см. [ICONTAINS](ICONTAINS.md).



## [ENDSWITH](ENDSWITH.md)

**Синтаксис:**`ENDSWITH( string, substring )`

Возвращает `TRUE`, если строка `string` оканчивается на подстроку `substring`.Для регистронезависимой проверки см. [IENDSWITH](IENDSWITH.md).



## [FIND](FIND.md)

**Синтаксис:**`FIND( string, substring [ , start_index ] )`

Возвращает индекс позиции первого символа подстроки `substring` в строке `string`.

Если указан опциональный параметр `start_index`, то поиск начнется с указанной позиции.



## [ICONTAINS](ICONTAINS.md)

**Синтаксис:**`ICONTAINS( string, substring )`

Регистронезависимый вариант [CONTAINS](CONTAINS.md). Возвращает `TRUE`, если строка `string` содержит в себе подстроку `substring`.



## [IENDSWITH](IENDSWITH.md)

**Синтаксис:**`IENDSWITH( string, substring )`

Регистронезависимый вариант [ENDSWITH](ENDSWITH.md). Возвращает `TRUE`, если строка `string` оканчивается на подстроку `substring`.



## [ISTARTSWITH](ISTARTSWITH.md)

**Синтаксис:**`ISTARTSWITH( string, substring )`

Регистронезависимый вариант [STARTSWITH](STARTSWITH.md). Возвращает `TRUE`, если строка `string` начинается на подстроку `substring`.



## [LEFT](LEFT.md)

**Синтаксис:**`LEFT( string, number )`

Возвращает строку, которая содержит указанное количество символов `number` с начала строки `string`.



## [LEN](LEN.md)

**Синтаксис:**`LEN( value )`

Возвращает количество символов в строке или элементов в массиве `value`.



## [LOWER](LOWER.md)

**Синтаксис:**`LOWER( string )`

Возвращает строку `string` в нижнем регистре.



## [LTRIM](LTRIM.md)

**Синтаксис:**`LTRIM( string )`

Возвращает строку `string` без знаков пробела в начале строки.



## [REGEXP_EXTRACT](REGEXP_EXTRACT.md)

**Синтаксис:**`REGEXP_EXTRACT( string, pattern )`

Возвращает подстроку `string`, которая соответствует регулярному выражению `pattern`.



## [REGEXP_EXTRACT_NTH](REGEXP_EXTRACT_NTH.md)

**Синтаксис:**`REGEXP_EXTRACT_NTH( string, pattern, match_index )`

Возвращает подстроку `string`, которая соответствует шаблону регулярного выражения `pattern`, начиная с указанного индекса.



## [REGEXP_MATCH](REGEXP_MATCH.md)

**Синтаксис:**`REGEXP_MATCH( string, pattern )`

Возвращает `TRUE`, если в строке `string` есть подстрока, которая соответствует шаблону регулярного выражения `pattern`.



## [REGEXP_REPLACE](REGEXP_REPLACE.md)

**Синтаксис:**`REGEXP_REPLACE( string, pattern, replace_with )`

Ищет подстроку в строке `string` по шаблону регулярного выражения `pattern` и заменяет ее строкой `replace_with`.

Если подстрока не найдена, то строка не будет изменена.



## [REPLACE](REPLACE.md)

**Синтаксис:**`REPLACE( string, substring, replace_with )`

Ищет подстроку `substring` в строке `string` и заменяет ее строкой `replace_with`.

Если подстрока не найдена, то строка не будет изменена.



## [RIGHT](RIGHT.md)

**Синтаксис:**`RIGHT( string, number )`

Возвращает строку, которая содержит указанное количество символов `number` с конца строки `string`.



## [RTRIM](RTRIM.md)

**Синтаксис:**`RTRIM( string )`

Возвращает строку `string` без знаков пробела в конце строки.



## [SPACE](SPACE.md)

**Синтаксис:**`SPACE( value )`

Возвращает строку с указанным количеством пробелов.



## [SPLIT](SPLIT.md)

**Синтаксис:**`SPLIT( orig_string [ , delimiter [ , part_index ] ] )`

Разделяет `orig_string` на последовательность подстрок, используя символ разделителя `delimiter`, и возвращает подстроку, порядковый номер которой равен параметру `part_index`. Разделитель по умолчанию — запятая. Если `part_index` отрицательный, отсчет возвращаемой подстроки ведется с конца `orig_string`. Если количество подстрок меньше, чем [абсолютное значение](https://ru.wikipedia.org/wiki/Абсолютная_величина) `part_index`, возвращается пустая строка. Если не передан `part_index`, то возвращается массив подстрок (только для источников `ClickHouse`, `PostgreSQL`).



## [STARTSWITH](STARTSWITH.md)

**Синтаксис:**`STARTSWITH( string, substring )`

Возвращает `TRUE`, если строка `string` начинается на подстроку `substring`. Для регистронезависимой проверки см. [ISTARTSWITH](ISTARTSWITH.md).



## [SUBSTR](SUBSTR.md)

**Синтаксис:**`SUBSTR( string, from_index [ , length ] )`

Возвращает подстроку `string`, начиная с индекса `from_index`. Нумерация начинается с единицы.

Если указан дополнительный аргумент `length`, то будет возвращена подстрока указанной длины.



## [TRIM](TRIM.md)

**Синтаксис:**`TRIM( string )`

Возвращает строку `string` без знаков пробела в начале и конце строки.



## [UPPER](UPPER.md)

**Синтаксис:**`UPPER( string )`

Возвращает строку `string` в верхнем регистре.



## [UTF8](UTF8.md)

**Синтаксис:**`UTF8( string, old_encoding )`

Переводит кодировку строки `string` в `UTF8`.


