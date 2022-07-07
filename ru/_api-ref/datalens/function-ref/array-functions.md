---
title: Функции для работы с массивами
editable: false
---

# Функции для работы с массивами


## [ARR_STR](ARR_STR.md)

**Синтаксис:**`ARR_STR( array [ , delimiter [ , null_str ] ] )`

Из элементов массива `array` формирует строку, используя `delimiter` в качестве разделителя (запятая по умолчанию) и `null_str` в качестве строки, подставляемой вместо `NULL` (по умолчанию такие элементы пропускаются и в результат не попадают).

См. также [STR](STR.md)



## [ARRAY](ARRAY.md)

**Синтаксис:**`ARRAY( value_1, value_2, value_3 [ , ... ] )`

Возвращает массив, содержащий переданные элементы.



## [CONTAINS](CONTAINS_ARRAY.md)

**Синтаксис:**`CONTAINS( array, value )`

Возвращает `TRUE`, если `array` содержит `value`.



## [COUNT_ITEM](COUNT_ITEM.md)

**Синтаксис:**`COUNT_ITEM( array, value )`

Возвращает количество элементов массива `array`, равных `value`. Тип `value` должен соответствовать типу элементов `array`.



## [GET_ITEM](GET_ITEM.md)

**Синтаксис:**`GET_ITEM( array, index )`

Возвращает элемент с индексом `index` из массива `array`. Индекс должен быть целым числом. Индексы в массиве начинаются с единицы.



## [REPLACE](REPLACE_ARRAY.md)

**Синтаксис:**`REPLACE( array, old, new )`

Заменяет в массиве `array` все элементы, равные `old`, на `new`.



## [SLICE](SLICE.md)

**Синтаксис:**`SLICE( array, offset, length )`

Возвращает часть массива `array` длины `length`, начиная с индекса `offset`. Индексы в массиве начинаются с единицы.



## [STARTSWITH](STARTSWITH_ARRAY.md)

**Синтаксис:**`STARTSWITH( array_1, array_2 )`

Возвращает `TRUE`, если значения из массива `array_2` находятся в начале массива `array_1`.



## [UNNEST](UNNEST.md)

**Синтаксис:**`UNNEST( array )`

Дублирует исходную строку для каждого элемента массива `array`.


