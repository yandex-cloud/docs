---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Functions for dictionaries

## DictCreate {#dictcreate}

Construct an empty dictionary. Two arguments are passed: for a key and a value. Each argument specifies a string with the data type declaration or the type itself obtained using the [applicable functions](types.md). There are no dictionaries with an unknown key or value type in YQL. As a key, you can use a [primitive data type](../types/primitive.md) (except `Yson` and `Json` with an optional [nullable](../types/optional.md) flag), or their tuple with a length of at least two.

[Documentation for type description format](../misc/type_string.md).

**Examples**

```sql
SELECT DictCreate(String, Tuple<String,Double?>);
```

```sql
SELECT DictCreate(Tuple<Int32?,String>, OptionalType(DataType("String")));
```

## DictItems {#dictitems}

Get the dictionary content as a list of tuples with key-value pairs (`List<Tuplekey_type,value_type>`).

**Examples**

```sql
SELECT DictItems(AsDict(AsTuple(1, AsList("foo", "bar"))));
-- [ ( 1, [ "foo", "bar" ] ) ]
```

## DictKeys {#dictkeys}

Get a list of dictionary keys.

**Examples**

```sql
SELECT DictKeys(AsDict(AsTuple(1, AsList("foo", "bar"))));
-- [ 1 ]
```

## DictPayloads {#dictpayloads}

Get a list of dictionary values.

**Examples**

```sql
SELECT DictPayloads(AsDict(AsTuple(1, AsList("foo", "bar"))));
-- [ [ "foo", "bar" ] ]
```

## DictLookup {#dictlookup}

Get a dictionary element by its key.

**Examples**

```sql
SELECT DictLookup(AsDict(
    AsTuple(1, AsList("foo", "bar")),
    AsTuple(2, AsList("bar", "baz"))
), 1);
-- [ "foo", "bar" ]
```

## DictContains {#dictcontains}

Checking if an element in the dictionary using its key. Returns true or false.

**Examples**

```sql
SELECT DictContains(AsDict(
    AsTuple(1, AsList("foo", "bar")),
    AsTuple(2, AsList("bar", "baz"))
), 42);
-- false
```

## DictAggregate {#dictaggregate}

Apply [aggregation factory](basic.md#aggregationfactory) to the passed dictionary where each value is a list. The factory is applied separately inside each key.
If the list is empty, the aggregation result is the same as for an empty table: 0 for the `COUNT` function and `NULL` for other functions.
If the list under a certain key is empty in the passed dictionary, such a key is removed from the result.
If the passed dictionary is optional and contains `NULL`, the result is also `NULL`.

Arguments:

1. Dictionary.
2. [Aggregation factory](basic.md#aggregationfactory).

**Examples**

```sql
SELECT DictAggregate(AsDict(
    AsTuple(1, AsList("foo", "bar")),
    AsTuple(2, AsList("baz", "qwe"))), 
    AGGREGATION_FACTORY("Max"));
-- {1 : "foo", 2 : "qwe" }
```

## SetIsDisjoint {#setisjoint}

Check that the dictionary doesn't intersect by keys with a list or another dictionary.

So there are two options to make a call:

* With the `Dict<K,V1>` and `List<K>` arguments.
* With the `Dict<K,V1>` and `Dict<K,V2>` arguments.

**Examples**

```sql
SELECT SetIsDisjoint(ToSet(AsList(1, 2, 3)), AsList(7, 4)); -- true
SELECT SetIsDisjoint(ToSet(AsList(1, 2, 3)), ToSet(AsList(3, 4))); -- false
```

## SetIntersection {#setintersection}

Construct intersection between two dictionaries based on keys.

Arguments:

* Two dictionaries: `Dict<K,V1>` and `Dict<K,V2>`.
* An optional function that combines the values from the source dictionaries to construct the values of the output dictionary. If such a function has the `(K,V1,V2) -> U` type, the result type is `Dict<K,U>`. If the function is not specified, the result type is `Dict<K,Void>`, and the values from the source dictionaries are ignored.

**Examples**

```sql
SELECT SetIntersection(ToSet(AsList(1, 2, 3)), ToSet(AsList(3, 4))); -- { 3 }
SELECT SetIntersection(
    AsDict(AsTuple(1, "foo"), AsTuple(3, "bar")),
    AsDict(AsTuple(1, "baz"), AsTuple(2, "qwe")),
    ($k, $a, $b) -> { RETURN AsTuple($a, $b) });
-- { 1 : ("foo", "baz") }
```

## SetIncludes {#setincludes}

Checking that the keys of the specified dictionary include all the elements of the list or the keys of the second dictionary.

So there are two options to make a call:

* With the `Dict<K,V1>` and `List<K>` arguments.
* With the `Dict<K,V1>` and `Dict<K,V2>` arguments.

**Examples**

```sql
SELECT SetIncludes(ToSet(AsList(1, 2, 3)), AsList(3, 4)); -- false
SELECT SetIncludes(ToSet(AsList(1, 2, 3)), ToSet(AsList(2, 3))); -- true
```

## SetUnion {#setunion}

Constructs a union of two dictionaries based on keys.

Arguments:

* Two dictionaries: `Dict<K,V1>` and `Dict<K,V2>`.
* An optional function that combines the values from the source dictionaries to construct the values of the output dictionary. If such a function has the `(K,V1?,V2?) -> U` type, the result type is `Dict<K,U>`. If the function is not specified, the result type is `Dict<K,Void>`, and the values from the source dictionaries are ignored.

**Examples**

```sql
SELECT SetUnion(ToSet(AsList(1, 2, 3)), ToSet(AsList(3, 4))); -- { 1, 2, 3, 4 }
SELECT SetUnion(
    AsDict(AsTuple(1, "foo"), AsTuple(3, "bar")),
    AsDict(AsTuple(1, "baz"), AsTuple(2, "qwe")),
    ($k, $a, $b) -> { RETURN AsTuple($a, $b) });
-- { 1 : ("foo", "baz"), 2 : (null, "qwe"), 3 : ("bar", null) }
```

## SetDifference {#setdifference}

Construct a dictionary containing all the keys with their values in the first dictionary with no matching key in the second dictionary.

**Examples**

```sql
SELECT SetDifference(ToSet(AsList(1, 2, 3)), ToSet(AsList(3, 4))); -- { 1, 2 }
SELECT SetDifference(
    AsDict(AsTuple(1, "foo"), AsTuple(2, "bar")), 
    ToSet(AsList(2, 3)));
-- { 1 : "foo" }
```

## SetSymmetricDifference {#setsymmetricdifference}

Construct a symmetric difference between two dictionaries based on keys.

Arguments:

* Two dictionaries: `Dict<K,V1>` and `Dict<K,V2>`.
* An optional function that combines the values from the source dictionaries to construct the values of the output dictionary. If such a function has the `(K,V1?,V2?) -> U` type, the result type is `Dict<K,U>`. If the function is not specified, the result type is `Dict<K,Void>`, and the values from the source dictionaries are ignored.

**Examples**

```sql
SELECT SetSymmetricDifference(ToSet(AsList(1, 2, 3)), ToSet(AsList(3, 4))); -- { 1, 2, 4 }
SELECT SetSymmetricDifference(
    AsDict(AsTuple(1, "foo"), AsTuple(3, "bar")),
    AsDict(AsTuple(1, "baz"), AsTuple(2, "qwe")),
    ($k, $a, $b) -> { RETURN AsTuple($a, $b) });
-- { 2 : (null, "qwe"), 3 : ("bar", null) }
```

