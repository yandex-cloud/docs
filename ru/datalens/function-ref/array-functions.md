---
title: Функции для работы с массивами
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/array-functions.md
---

# Функции для работы с массивами


## [ARR_AVG](ARR_AVG.md)

**Синтаксис:**`ARR_AVG( array )`

Возвращает среднее значение элементов в массиве `array`.



## [ARR_MAX](ARR_MAX.md)

**Синтаксис:**`ARR_MAX( array )`

Возвращает значение максимального элемента в массиве `array`.



## [ARR_MIN](ARR_MIN.md)

**Синтаксис:**`ARR_MIN( array )`

Возвращает значение минимального элемента в массиве `array`.



## [ARR_PRODUCT](ARR_PRODUCT.md)

**Синтаксис:**`ARR_PRODUCT( array )`

Возвращает произведение элементов массива `array`.



## [ARR_REMOVE](ARR_REMOVE.md)

**Синтаксис:**`ARR_REMOVE( array, value )`

Удаляет из массива `array` все элементы, равные `value`.



## [ARR_STR](ARR_STR.md)

**Синтаксис:**`ARR_STR( array [ , delimiter [ , null_str ] ] )`

Из элементов массива `array` формирует строку, используя `delimiter` в качестве разделителя (запятая по умолчанию) и `null_str` в качестве строки, подставляемой вместо `NULL` (по умолчанию такие элементы пропускаются и в результат не попадают).

См. также [STR](STR.md)



## [ARR_SUM](ARR_SUM.md)

**Синтаксис:**`ARR_SUM( array )`

Возвращает сумму элементов в массиве `array`.



## [ARRAY](ARRAY.md)

**Синтаксис:**`ARRAY( value_1, value_2, value_3 [ , ... ] )`

Возвращает массив, содержащий переданные элементы.



## [CAST_ARR_FLOAT](CAST_ARR_FLOAT.md)

**Синтаксис:**`CAST_ARR_FLOAT( array )`

Приводит массив `array` к массиву дробных значений. Правила преобразования аналогичны функции [FLOAT](FLOAT.md).



## [CAST_ARR_INT](CAST_ARR_INT.md)

**Синтаксис:**`CAST_ARR_INT( array )`

Приводит массив `array` к массиву целых чисел. Правила преобразования аналогичны функции [INT](INT.md).



## [CAST_ARR_STR](CAST_ARR_STR.md)

**Синтаксис:**`CAST_ARR_STR( array )`

Приводит массив `array` к массиву строк. Правила преобразования аналогичны функции [STR](STR.md).



## [CONTAINS](CONTAINS_ARRAY.md)

**Синтаксис:**`CONTAINS( array, value )`

Возвращает `TRUE`, если `array` содержит `value`.



## [CONTAINS_ALL](CONTAINS_ALL.md)

**Синтаксис:**`CONTAINS_ALL( array_1, array_2 )`

Возвращает `TRUE`, если `array_1` содержит все элементы `array_2`.



## [CONTAINS_ANY](CONTAINS_ANY.md)

**Синтаксис:**`CONTAINS_ANY( array_1, array_2 )`

Возвращает `TRUE`, если `array_1` содержит хотя бы один элемент из `array_2`.



## [CONTAINS_SUBSEQUENCE](CONTAINS_SUBSEQUENCE.md)

**Синтаксис:**`CONTAINS_SUBSEQUENCE( array_1, array_2 )`

Возвращает `TRUE`, если `array_2` является непрерывной подпоследовательностью `array_1`. Другими словами, возвращает `TRUE` исключительно если `array1 = prefix + array2 + suffix`.



## [COUNT_ITEM](COUNT_ITEM.md)

**Синтаксис:**`COUNT_ITEM( array, value )`

Возвращает количество элементов массива `array`, равных `value`. Тип `value` должен соответствовать типу элементов `array`.



## [GET_ITEM](GET_ITEM.md)

**Синтаксис:**`GET_ITEM( array, index )`

Возвращает элемент с индексом `index` из массива `array`. Индекс должен быть целым числом. Индексы в массиве начинаются с единицы. Возвращает последний элемент из массива, если значение `index` равно `-1`.



## [LEN](LEN_ARRAY.md)

**Синтаксис:**`LEN( value )`

Возвращает количество элементов в массиве `value`.



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


