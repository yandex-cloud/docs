# Optional (nullable)

Any typed data in YQL, including table columns, can be either non-nullable (guaranteed value) or nullable (empty value denoted as `NULL`). These values are called "optional" (or "nullable", in SQL terms).

The most common operation for such data types is [COALESCE](../builtins/basic.md#coalesce). COALESCE lets you leave the filled values unchanged while replacing `NULL` with the default value that follows.

When [you declare such data types in the text format](../misc/type_string.md), use the question mark at the end (for example, `String?`) or the notation `Optional<...>`.

{% note info %}

`Optional` (nullable) isn't a property of a data type or column, but a  [container](containers.md) type, where containers can be arbitrarily nested in each other. For example, a column with the type `Optional<Optional<Boolean>>` can accept 4 values: `NULL` of the overarching container, `NULL` of the inner container, `TRUE`, and `FALSE`. The above-declared type differs from `List<List<Boolean>>`, because it uses `NULL` as an empty list, and you can't put more than one non-null element in it. You can also use `Optional<Optional<T>>` as a key lookup in the dictionary (`Dict(k,v)`) with `Optional<T>` values. Using this type of result data, you can distinguish between a `NULL` value in the dictionary and a missing key.

{% endnote %}

