---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Функции для работы со списками

## ListCreate {#list-create}

Сконструировать пустой список. В единственном аргументе указывается текстовое представление описания типа данных ячейки списка, либо тип, полученный с помощью [предназначенных для этого функций](types.md). Списков с неизвестным типом ячейки в YQL не бывает.

[Документация по формату описания типа](../misc/type_string.md).

**Примеры**

```sql
SELECT ListCreate(Tuple<String,Double?>);
```

```sql
SELECT ListCreate(OptionalType(DataType("String")));
```

## AsList {#aslist}

Сконструировать список из одного или более аргументов.

**Примеры**

```sql
SELECT AsList(1, 2, 3, 4, 5);
```

## ListLength {#listlength}

Количество элементов в списке.

**Примеры**

```sql
SELECT ListLength(list_column) FROM my_table;
```

## ListCollect {#listcollect}

Преобразовать ленивый список (строится, например, функциями [ListFilter](#listfilter), [ListMap](#listmap), [ListFlatMap](#listflatmap)) в энергичный. В отличие от ленивого списка, в котором каждый повторный проход заново вычисляет его содержимое, в энергичном списке содержимое списка строится сразу ценой большего потребления памяти.

**Примеры**

```sql
SELECT ListCollect(list_column) FROM my_table;
```

## ListSort, ListSortAsc и ListSortDesc {#listsort}

Отсортировать список. По умолчанию выполняется сортировка по возрастанию (`ListSort` — алиас к `ListSortAsc`).

Аргументы:

1. Список;
2. Опциональное выражение для получения ключа сортировки из элемента списка (по умолчанию сам элемент).

**Примеры**

```sql
SELECT ListSortDesc(list_column) FROM my_table;
```

```sql
$list = AsList(
    AsTuple("x", 3),
    AsTuple("xx", 1),
    AsTuple("a", 2)
);

SELECT ListSort($list, ($x) -> {
    RETURN $x.1;
});
```

{% note info %}

Во втором примере использовалась [лямбда функция](../syntax/expressions.md#lambda).

{% endnote %}

## ListCount {#listcount}

Количество элементов в списке за вычетом пустых (`NULL`).

**Примеры**

```sql
SELECT ListCount(list_column) FROM my_table;
```

## ListExtend {#listextend}

Последовательно соединить списки с одинаковым типом элементов (конкатенация списков).

**Примеры**

```sql
SELECT ListExtend(
    list_column_1,
    list_column_2,
    list_column_3
) FROM my_table;
```

## ListZip и ListZipAll {#listzip}

По входящим спискам построить список пар, содержащих соответствующие по индексу элементы списков (`List<Tuple<first_list_element_type,second_list_element_type>>`).

Длина возвращаемого списка определяется самым коротким списком для ListZip и самым длинным — для ListZipAll.
Когда более короткий список исчерпан, в качестве пары к элементам более длинного списка подставляется пустое значение (`NULL`) соответствующего [optional типа](../types/optional.md).

**Примеры**

```sql
SELECT
    ListZip(list_column_1, list_column_2, list_column_3),
    ListZipAll(list_column_1, list_column_2)
FROM my_table;
```

## ListEnumerate {#listenumerate}

Построить список пар (`Tuple`), содержащих номер элемента и сам элемент (`List<Tuple<Uint64,list_element_type>>`).

**Примеры**
```sql
SELECT ListEnumerate(list_column) FROM my_table;
```

## ListReverse {#listreverse}

Развернуть список.

**Примеры**

```sql
SELECT ListReverse(list_column) FROM my_table;
```

## ListSkip {#listskip}

Возвращает копию списка с пропущенным указанным числом первых элементов.

Первый аргумент — исходный список, второй — сколько элементов пропустить.

**Примеры**

```sql
SELECT
    ListSkip(list_column, 3)
FROM my_table;
```

## ListTake {#listtake}

Возвращает копию списка, состоящую из ограниченного числа элементов второго списка.

Первый аргумент — исходный список, второй — не больше скольки элементов с начала оставить.

**Примеры**

```sql
SELECT ListTake(list_column, 3) FROM my_table;
```

## ListIndexOf {#listindexof}

Ищет элемент с указанным значением в списке и при первом обнаружении возвращает его индекс. Отсчет индексов начинается с 0, а в случае отсутствия элемента возвращается `NULL`.

**Примеры**

```sql
SELECT
    ListIndexOf(list_column, 123)
FROM my_table;
```

## ListMap, ListFlatMap и ListFilter {#listmap}

Применяют к каждому элементу списка указанную в качестве второго аргумента функцию. Различаются возвращаемым результатом:

* `ListMap` — возвращает список с результатами;
* `ListFlatMap` — возвращает список с результатами, но дополнительно пропускает «пустые» значения (`NULL`). В дополнение к этому, если результат для каждого элемента является списком, объединяет их (но только один уровень);
* `ListFilter` — оставляет только те элементы, для которых функция вернула `true`.

Аргументы:

1. Исходный список;
2. Функции для обработки элементов, например:
    * [Лямбда функция](../syntax/expressions.md#lambda);
    * `Module::Function` - С++ UDF;
3. Опциональные дополнительные аргументы, которые будут переданы указанной во втором аргументе функции.


## ListUniq {#listuniq}

Возвращает копию списка, в котором оставлен только уникальный набор элементов.

**Примеры**

```sql
SELECT
    ListUniq(list_column)
FROM my_table;
```

## ListAny и ListAll {#listany}

Для списка булевых значений возвращает `true`, если:

* `ListAny` — хотя бы один элемент равен `true`;
* `ListAll` — все элементы равны `true`.

В противном случае возвращает `false`.

**Примеры**

```sql
SELECT
    ListAll(bool_column),
    ListAny(bool_column)
FROM my_table;
```

## ListHas {#listhas}

Возвращает `true`, если список содержит указанный элемент, в противном случае возвращает `false`.

**Примеры**

```sql
SELECT
    ListHas(list_column, "my_needle")
FROM my_table;
```

## ListMin, ListMax, ListSum и ListAvg {#listminy}

Применяет соответствующую агрегатную функцию ко всем элементам списка числовых значений.

**Примеры**

```sql
SELECT
    ListMax(numeric_list_column) AS max,
    ListMin(numeric_list_column) AS min,
    ListSum(numeric_list_column) AS sum,
    ListAvg(numeric_list_column) AS avg
FROM my_table;
```

## ListFromRange {#listfromrange}

Генерация последовательности чисел с указанным шагом. Аналог `xrange` в Python 2, но дополнительно с поддержкой чисел с плавающей точкой.

Аргументы:

1. Начало
2. Конец
3. Шаг (опционально, по умолчанию 1)

Особенности:

* Конец не включительный, т.е. `ListFromRange(1,3) == AsList(1,2)`.
* Тип элементов результатов выбирается как наиболее широкий из типов аргументов, например результатом `ListFromRange(1, 2, 0.5)` получится список `Double`.
* Список является «ленивым», но при неправильном использовании всё равно может привести к потреблению большого объема оперативной памяти.
* Если шаг положительный и конец меньше или равен началу, то список будет пустой.
* Если шаг отрицательный и конец больше или равен началу, то список будет пустой.
* Если шаг не положительный и не отрицательный (0 или NaN), то список будет пустой.

**Примеры**

```sql
SELECT
    ListFromRange(-2, 2), -- [-2, -1, 0, 1]
    ListFromRange(2, 1, -0.5); -- [2.0, 1.5]
```

## ListReplicate {#listreplicate}

Создает список из нескольких копий указанного значения.

Обязательные аргументы:

1. Значение;
2. Число копий.

**Примеры**

```sql
SELECT ListReplicate(true, 3); -- [true, true, true]
```

## ListConcat {#listconcat}

Объединяет список строк в одну строку без разделителей.

См. [String::JoinFromList](../udf/list/string.md), если нужны разделители.

**Примеры**

```sql
SELECT
    ListConcat(string_list_column)
FROM my_table;
```

## ListExtract {#listextract}

По списку структур возвращает список содержащихся в них полей с указанным именем.

**Примеры**

```sql
SELECT
    ListExtract(struct_list_column, "MyMember")
FROM my_table;
```

## ListTakeWhile и ListSkipWhile {#listtakewhile}

`ListTakeWhile` выдает список от начала, пока предикат истинный, далее список заканчивается.

`ListSkipWhile` пропускает отрезок списка от начала, пока предикат истинный, далее выдает остаток список не обращая внимания на предикат.

Обязательные аргументы:

1. Список;
2. Предикат.

**Примеры**

```sql
$data = AsList(1, 2, 5, 1, 2, 5);

SELECT
    ListTakeWhile($data, ($x) -> {return $x <= 3}), -- [1, 2]
    ListSkipWhile($data, ($x) -> {return $x <= 3}); -- [5, 1, 2, 5]
```

## ListAggregate {#listaggregate}

Применить [фабрику агрегационных функций](basic.md#aggregationfactory) для переданного списка.
Если переданный список является пустым, то результат агрегации будет такой же, как для пустой таблицы: 0 для функции `COUNT` и `NULL` для других функций.
Если переданный список является опциональным и содержит значение `NULL`, то в результате также будет `NULL`.

Аргументы:

1. Список;
2. [Фабрика агрегационных функций](basic.md#aggregationfactory).


**Примеры**

```sql
SELECT ListAggregate(AsList(1, 2, 3), AGGREGATION_FACTORY("Sum")); -- 6
```

## ToDict и ToMultiDict {#todict}

Преобразуют список из кортежей с парами ключ-значение в словарь. В случае конфликтов по ключам во входном списке `ToDict` оставляет первое значение, а `ToMultiDict` — собирает из всех значений список.

Таким образом:

* `ToDict` из `List<Tuple<K, V>>` делает `Dict<K, V>`
* `ToMultiDict` из `List<Tuple<K, V>>` делает `Dict<K, List<V>>`

Также поддерживаются опциональные списки, что приводит к опциональному словарю в результате.

**Примеры**

```sql
SELECT
    ToDict(tuple_list_column)
FROM my_table;
```

## ToSet {#toset}

Преобразует список в словарь, в котором ключи являются уникальными элементами этого списка, а значения отсутствуют и имеют тип `Void`. Для списка `List<T>` тип результата будет `Dict<T, Void>`.
Также поддерживается опциональный список, что приводит к опциональному словарю в результате.

**Примеры**

```sql
SELECT
    ToSet(list_column)
FROM my_table;
```
