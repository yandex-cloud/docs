---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Functions for lists

## ListCreate {#list-create}

Construct an empty list. The only argument specifies a text representation for the description of the  list cell data type or the type obtained using [relevant functions](types.md). YQL doesn't support lists with an unknown cell type.

[Documentation for type description format](../misc/type_string.md).

**Examples**

```sql
SELECT ListCreate(Tuple<String,Double?>);
```

```sql
SELECT ListCreate(OptionalType(DataType("String")));
```

## AsList {#aslist}

Construct a list based on one or more arguments.

**Examples**

```sql
SELECT AsList(1, 2, 3, 4, 5);
```

## ListLength {#listlength}

The count of items in the list.

**Examples**

```sql
SELECT ListLength(list_column) FROM my_table;
```

## ListCollect {#listcollect}

Convert a lazy list (it can be built by such functions as [ListFilter](#listfilter), [ListMap](#listmap), [ListFlatMap](#listflatmap)) to an eager list. In contrast to a lazy list, where each new pass re-calculates the list contents, in an eager list the content is built at once by consuming more memory.

**Examples**

```sql
SELECT ListCollect(list_column) FROM my_table;
```

## ListSort, ListSortAsc, and ListSortDesc {#listsort}

Sort the list. By default, the ascending sorting order is applied (`ListSort` is an alias for `ListSortAsc`).

Arguments:

1. List.
2. An optional expression to get the sort key from a list element (it's the element itself by default).

**Examples**

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

A [lambda function](../syntax/expressions.md#lambda) was used in the second example.

{% endnote %}

## ListCount {#listcount}

Number of elements in the list ignoring the `NULL` element.

**Examples**

```sql
SELECT ListCount(list_column) FROM my_table;
```

## ListExtend {#listextend}

Join the lists having the same type of elements one-by-one (list concatenation).

**Examples**

```sql
SELECT ListExtend(
    list_column_1,
    list_column_2,
    list_column_3
) FROM my_table;
```

## ListZip and ListZipAll {#listzip}

Based on the input lists, build a list of pairs containing the list elements with corresponding indexes (`List<Tuplefirst_list_element_type,second_list_element_type>`).

The length of the returned list is determined by the shortest list for ListZip and the longest list for ListZipAll.
When the shorter list is exhausted, a `NULL` value of a relevant [optional type](../types/optional.md) is paired with the elements of the longer list.

**Examples**

```sql
SELECT
    ListZip(list_column_1, list_column_2, list_column_3),
    ListZipAll(list_column_1, list_column_2)
FROM my_table;
```

## ListEnumerate {#listenumerate}

Build a list of pairs (`Tuple`) containing the element number and the element itself (`List<TupleUint64,list_element_type>`).

**Examples**

```sql
SELECT ListEnumerate(list_column) FROM my_table;
```

## ListReverse {#listreverse}

Reverse the list.

**Examples**

```sql
SELECT ListReverse(list_column) FROM my_table;
```

## ListSkip {#listskip}

Returns a copy of the list, skipping the specified number of its first elements.

The first argument specifies the source list and the second argument specifies how many elements to skip.

**Examples**

```sql
SELECT
    ListSkip(list_column, 3)
FROM my_table;
```

## ListTake {#listtake}

Returns a copy of the list containing a limited number of elements from the second list.

The first argument specifies the source list and the second argument specifies the maximum number of elements to be taken from the beginning of the list.

**Examples**

```sql
SELECT ListTake(list_column, 3) FROM my_table;
```

## ListIndexOf {#listindexof}

Searches the list for an element with the specified value and returns its index at the first occurrence. Indexes count from 0. If such element is missing, it returns `NULL`.

**Examples**

```sql
SELECT
    ListIndexOf(list_column, 123)
FROM my_table;
```

## ListMap, ListFilter, and ListFlatMap {#listmap}

Apply the function specified as the second argument to each list element. The functions differ in their returned result:

* `ListMap` returns a list with results.
* `ListFlatMap` returns a list with results, but also skips the `NULL` values. In addition to that, if the result for each element is a list, it joins the lists (but only on one level).
* `ListFilter` leaves only those elements where the function returned `true`.

Arguments:

1. Source list.
2. Functions for processing list elements, such as:
    * [Lambda function](../syntax/expressions.md#lambda).
    * `Module::Function`: C++ UDF.
3. Optional additional arguments to be passed to the function specified in the second argument.

## ListUniq {#listuniq}

Returns a copy of the list containing only distinct elements.

**Examples**

```sql
SELECT
    ListUniq(list_column)
FROM my_table;
```

## ListAny and ListAll {#listany}

Returns `true` for a list of Boolean values, if:

* `ListAny`: At least one element is `true`.
* `ListAll`: All elements are `true`.

Otherwise, it returns `false`.

**Examples**

```sql
SELECT
    ListAll(bool_column),
    ListAny(bool_column)
FROM my_table;
```

## ListHas {#listhas}

Returns `true` if the list contains the specified element. Otherwise, it returns `false`.

**Examples**

```sql
SELECT
    ListHas(list_column, "my_needle")
FROM my_table;
```

## ListMin, ListMax, ListSum, and ListAvg {#listminy}

Apply the appropriate aggregate function to all elements of the numeric list.

**Examples**

```sql
SELECT
    ListMax(numeric_list_column) AS max,
    ListMin(numeric_list_column) AS min,
    ListSum(numeric_list_column) AS sum,
    ListAvg(numeric_list_column) AS avg
FROM my_table;
```

## ListFromRange {#listfromrange}

Generate a sequence of numbers with the specified step. It's similar to `xrange` in Python 2, but additionally supports floats.

Arguments:

1. Start
2. End
3. Step (optional, 1 by default)

Specifics:

* The end is not included, i.e. `ListFromRange(1,3) == AsList(1,2)`.
* The type for the resulting elements is selected as the broadest from the argument types. For example, `ListFromRange(1, 2, 0.5)` results in a `Double` list.
* The list is "lazy", but if it's used incorrectly, it can still consume a lot of RAM.
* If the step is positive and the end is less than or equal to the start, the result list is empty.
* If the step is negative and the end is greater than or equal to the start, the result list is empty.
* If the step is neither positive nor negative (0 or NaN), the result list is empty.

**Examples**

```sql
SELECT
    ListFromRange(-2, 2), -- [-2, -1, 0, 1]
    ListFromRange(2, 1, -0.5); -- [2.0, 1.5]
```

## ListReplicate {#listreplicate}

Creates a list containing multiple copies of the specified value.

Required arguments:

1. Value.
2. Number of copies.

**Examples**

```sql
SELECT ListReplicate(true, 3); -- [true, true, true]
```

## ListConcat {#listconcat}

Concatenates a list of strings into a single string without separators.

For details, see [String::JoinFromList](../udf/list/string.md), if you want to use separators.

**Examples**

```sql
SELECT
    ListConcat(string_list_column)
FROM my_table;
```

## ListExtract {#listextract}

For a list of structures, it returns a list of contained fields having the specified name.

**Examples**

```sql
SELECT
    ListExtract(struct_list_column, "MyMember")
FROM my_table;
```

## ListTakeWhile and ListSkipWhile {#listtakewhile}

`ListTakeWhile` returns a list from the beginning while the predicate is true, then the list ends.

`ListSkipWhile` skips the list segment from the beginning while the predicate is true, then returns the rest of the list ignoring the predicate.

Required arguments:

1. List.
2. Predicate.

**Examples**

```sql
$data = AsList(1, 2, 5, 1, 2, 5);

SELECT
    ListTakeWhile($data, ($x) -> {return $x <= 3}), -- [1, 2]
    ListSkipWhile($data, ($x) -> {return $x <= 3}); -- [5, 1, 2, 5]
```

## ListAggregate {#listaggregate}

Apply the [aggregation factory](basic.md#aggregationfactory) to the passed list.
If the passed list is empty, the aggregation result is the same as for an empty table: 0 for the `COUNT` function and `NULL` for other functions.
If the passed list is optional and contains `NULL`, the result is also `NULL`.

Arguments:

1. List.
2. [Aggregation factory](basic.md#aggregationfactory).

**Examples**

```sql
SELECT ListAggregate(AsList(1, 2, 3), AGGREGATION_FACTORY("Sum")); -- 6
```

## ToDict and ToMultiDict {#todict}

Convert a list of tuples containing key-value pairs to a dictionary. In case of conflicting keys in the input list, `ToDict` leaves the first value and `ToMultiDict` builds a list of all the values.

It means that:

* `ToDict` converts `List<TupleK, V>` to `Dict<K, V>`
* `ToMultiDict` converts `List<TupleK, V>` to `Dict<K, List<V>>`

Optional lists are also supported, resulting in an optional dictionary.

**Examples**

```sql
SELECT
    ToDict(tuple_list_column)
FROM my_table;
```

## ToSet {#toset}

Converts a list to a dictionary where the keys are unique elements of this list, and values are omitted and have the type `Void`. For the `List<T>` list, the result type is `Dict<T, Void="">`.
An optional list is also supported, resulting in an optional dictionary.

**Examples**

```sql
SELECT
    ToSet(list_column)
FROM my_table;
```

