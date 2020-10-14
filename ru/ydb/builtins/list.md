# Функции для работы со списками

## ListCreate {#listcreate}

Сконструировать пустой список. В единственном аргументе указывается строка с описанием типа данных ячейки списка, либо сами типом, полученным с помощью [предназначенных для этого функций](types.md).

[Документация по формату описания типа](../misc/type_string.md).

**Примеры:**

```sql
SELECT ListCreate("Tuple<String,Double?>");
```
```sql
SELECT ListCreate(OptionalType(DataType("String")));
```

## AsList {#aslist}

Сконструировать список из 1 или более аргументов.

**Примеры:**
```sql
SELECT AsList(1, 2, 3, 4, 5);
```

## ListLength {#listlength}

Количество элементов в списке.

**Примеры:**
```sql
SELECT ListLength(list_column) FROM my_table;
```
## ListSort, ListSortAsc и ListSortDesc {#listsort-listsortasc-listsortdesc}
<a name="listsort"></a><a name="listsortasc"></a><a name="listsortdesc"></a>

Отсортировать список. По умолчанию выполняется сортировка по возрастанию (ListSort — алиас ListSortAsc).

Аргументы:

1. Список;
2. Опциональное выражение для получения ключа сортировки из элемента списка (по умолчанию сам элемент).

**Примеры:**
```sql
SELECT ListSortDesc(list_column) FROM my_table;
```
```sql
$list = AsList(
    AsTuple("x", 3),
    AsTuple("xx", 1),
    AsTuple("a", 2)
);

SELECT ListSort($list, ($x) -> {RETURN $x.1;});
```

## ListCount {#listcount}

Количество элементов в списке за вычетом пустых (`NULL`).

**Примеры:**
```sql
SELECT ListCount(list_column) FROM my_table;
```

## ListExtend {#listextend}

Последовательно соединить списки с одинаковым типом элементов (конкатенация списков).

**Примеры:**
```sql
SELECT ListExtend(
    list_column_1,
    list_column_2,
    list_column_3
) FROM my_table;
```

## ListZip и ListZipAll {#listzip-listzipall}

По входящим спискам построить список пар (Tuple), содержащих соответствующие по индексу элементы списков.

Длина возвращаемого списка определяется самым коротким списком для ListZip и самым длинным — для ListZipAll.
Когда более короткий список исчерпан, в качестве пары к элементам более длинного списка подставляется пустое значение (`NULL`) соответствующего optional-типа.

**Примеры:**
```sql
SELECT
    ListZip(list_column_1, list_column_2, list_column_3),
    ListZipAll(list_column_1, list_column_2)
FROM my_table;
```

## ListEnumerate {#listenumerate}

Построить список пар (Tuple), содержащих номер элемента и сам элемент.

**Примеры:**
```sql
SELECT ListEnumerate(list_column) FROM my_table;
```

## ListReverse {#listreverse}

Развернуть список.

**Примеры:**
```sql
SELECT ListReverse(list_column) FROM my_table;
```

## ListSkip {#listskip}

Возвращает копию списка с пропущенным некоторым числом первых элементов.

Первый аргумент — исходный список, второй — сколько элементов пропустить.

**Примеры:**
```sql
SELECT
    ListSkip(list_column, 3)
FROM my_table;
```

## ListTake {#listtake}

Возвращает копию списка, состоящую из ограниченного числа элементов второго списка. Первый аргумент — исходный список, второй — не больше сколько элементов с начала оставить.

**Примеры:**
```sql
SELECT ListTake(list_column, 3) FROM my_table;
```

## ListIndexOf {#listindexof}

Ищет элемент с указанным значением в списке и при первом обнаружении возвращает его индекс. Отсчет индексов начинается с 0, а в случае отсутствия элемента возвращается `NULL`.

**Примеры:**
```sql
SELECT
    ListIndexOf(list_column, 123)
FROM my_table;
```

## ListMap, ListFlatMap и ListFilter {#listmap-listflatmap-listfilter}

Применяют к каждому элементу списка указанную в качестве второго аргумента функцию. Различаются возвращаемым результатом:

* ListMap — возвращает список с результатами;
* ListFlatMap — возвращает список с результатами, но дополнительно пропускает «пустые» значения (NULL optional-типа). В дополнение к этому, если результат для каждого элемента является списком, объединяет их (но только один уровень).
* ListFilter — оставляет только те элементы, для которых функция вернула true.

Аргументы:

1. Исходный список.
2. Функции для обработки элементов, например:

  * [Лямбда функция](../syntax/extensions.md#lambda);
  * `Module::Function` - С++ UDF;
  * `"foo"` — функция из поддерживаемых [s-expressions](../s_expressions/functions.md), например `">"` или `"ToString"`;
{% if yt %}  * [Python UDF](../udf/python.md), [JavaScript UDF](../udf/javascript.md) или любое другое вызываемое значение.{% endif %}
3. Опциональные дополнительные аргументы, которые будут переданы указанной во втором аргументе функции.

Некоторые функции из [s-expressions](../s_expressions/functions.md) ожидают в качестве дополнительного аргумента атом. В SQL-синтаксисе его проще всего создать с помощью встроенной функции `AsAtom`.

**Примеры:**
```sql
$callable = Python::test("(Int64)->Bool", "def test(i): return i % 2");
SELECT
    ListMap(list_column, ($x) -> { RETURN $x > 2; }),
    ListFlatMap(list_column, My::Udf, 0),
    ListFilter(list_column, $callable)
FROM my_table;
```

## ListUniq {#listuniq}

Возвращает копию списка, в котором оставляет только уникальный набор элементов.

**Примеры:**
```sql
SELECT
    ListUniq(list_column)
FROM my_table;
```

## ListAny и ListAll {#listany-listall}

Для списка булевых значений возвращает true, если:

* `ListAny` — хотя бы один элемент равен true;
* `ListAll` — все элементы равны true.
В противном случае возвращает false.

**Примеры:**
```sql
SELECT
    ListAll(bool_column),
    ListAny(bool_column)
FROM my_table;
```

## ListHas {#listhas}

Содержит ли список указанный элемент.

**Примеры:**
```sql
SELECT
    ListHas(list_column, "my_needle")
FROM my_table;
```

## ListMin, ListMax, ListSum и ListAvg {#listmin-listmax-listsum-listavg}

Применяет соответствующую агрегатную функцию ко всем элементам списка числовых значений.

**Примеры:**
```sql
SELECT
    ListMax(numeric_list_column) AS max,
    ListMin(numeric_list_column) AS min,
    ListSum(numeric_list_column) AS sum,
    ListAvg(numeric_list_column) AS avg
FROM my_table;
```

## ListFromRange {#listfromrange}

Генерация последовательности чисел с указанным шагом. Аналог xrange в Python 2, но дополнительно с поддержкой чисел с плавающей точкой.

Аргументы:

1. Начало
2. Конец
3. Шаг <span class="gray;">(опционально, по умолчанию 1)</span>

Особенности:

* Конец не включительный, т.е. `ListFromRange(1,3) == AsList(1,2)`.
* Тип элементов результатов выбирается как наиболее широкий из типов аргументов, например результатом `ListFromRange(1, 2, 0.5)` получится список `Double`.
* Список является «ленивым», но при неправильном использовании всё равно может привести к потреблению большого объема оперативной памяти.
* Если шаг положительный и конец меньше или равен началу, то список будет пустой.
* Если шаг отрицательный и конец больше или равен началу, то список будет пустой.
* Если шаг не положительный и не отрицательный <span class="gray;">(0 или NaN)</span>, то список будет пустой.

**Примеры:**
```sql
SELECT
    ListFromRange(-2, 2), -- [-2, -1, 0, 1]
    ListFromRange(2, 1, -0.5); -- [2.0, 1.5]
```

## ListReplicate {#listreplicate}

Создает список из нескольких копий указанного значения.

Обязательные аргументы:

1. значение;
2. число копий.

**Примеры:**
```sql
SELECT ListReplicate(true, 3); -- [true, true, true]
```

## ListConcat {#listconcat}

Объединяет список строк в одну строку без разделителей.

См. [String::JoinFromList](../udf/list/string.md), если нужны разделители.

**Примеры:**
```sql
SELECT
    ListConcat(string_list_column)
FROM my_table;
```

## ListExtract {#listextract}

По списку структур возвращает список содержащихся в них полей с указанным именем.

**Примеры:**
```sql
SELECT
    ListExtract(struct_list_column, "MyMember")
FROM my_table;
```

## ListTakeWhile / ListSkipWhile {#listtakewhile-listskipwhile}

`ListTakeWhile` — выдает список от начала, пока предикат истинный, далее список заканчивается.
`ListSkipWhile` — пропускает отрезок списка от начала, пока предикат истинный, далее выдает остаток список не обращая внимания на предикат.

Обязательные аргументы:

1. список;
2. предикат.

**Примеры:**
```sql
$data = AsList(1, 2, 5, 1, 2, 5);

SELECT
    ListTakeWhile($data, ($x) -> {return $x <= 3}), -- [1, 2]
    ListSkipWhile($data, ($x) -> {return $x <= 3}); -- [5, 1, 2, 5]
```

## ToDict / ToMultiDict {#todict-tomultidict}

Преобразуют список из кортежей с парами ключ-значение в словарь. В случае конфликтов по ключам во входном списке `ToDict` оставляет первое значение, а `ToMultiDict` — собирает из всех значений список.

Таким образом:

* `ToDict` из `List<Tuple<K, V>>` делает `Dict<K, V>`
* `ToMultiDict` из `List<Tuple<K, V>>` делает `Dict<K, List<V>>`

**Примеры:**
```sql
SELECT
    ToDict(tuple_list_column)
FROM my_table;
```
