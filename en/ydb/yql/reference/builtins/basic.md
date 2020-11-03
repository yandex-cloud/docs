# Basic built-in functions

Below are the general-purpose functions. For specialized functions, there are separate articles: [aggregate](aggregation.md), [window](window.md). There are also articles for working with [lists](list.md), [dictionaries](dict.md), and [data type](types.md).

## COALESCE {#coalesce}

Iterates through the arguments from left to right and returns the first non-empty argument found. To be sure that the result is non-empty (not of an [optional type](../types/optional.md)), the rightmost argument must be of this type (often a literal is used for this). With a single argument, returns this argument unchanged.

Lets you pass potentially empty values to functions that can't handle them by themselves.

A short format using the low-priority `??` operator is available (lower than the Boolean operations). You can use the `NVL` alias.

**Examples**

```sql
SELECT COALESCE(
  maybe_empty_column,
  "it's empty!"
) FROM my_table;
```

```sql
SELECT
  maybe_empty_column ?? "it's empty!"
FROM my_table;
```

```sql
SELECT NVL(
  maybe_empty_column,
  "it's empty!"
) FROM my_table;
```

## LENGTH {#length}

Returns the length of the string in bytes. This function is also available under the `LEN` name .

**Examples**

```sql
SELECT LENGTH("foo");
```

```sql
SELECT LEN("bar");
```

{% note info %}

You can use the function [Unicode::GetLength](../udf/list/unicode.md) to calculate the length of a string in Unicode characters. <br><br>To get the number of elements in the list, use the function [ListLength](list.md#listlength).

{% endnote %}

## SUBSTRING {#substring}

Returns a substring.

Required arguments:

* Source string;
* Position: The offset from the beginning of the string in bytes (integer).

Optional arguments:

* Substring length: The number of bytes starting from the specified position (an integer, defaults to "up to the end of the source string").

If the specified position and length are beyond the string, returns an empty string.

**Examples**

```sql
SELECT SUBSTRING("abcdefg", 3, 1); -- d
```

```sql
SELECT SUBSTRING("abcdefg", 3); -- defg
```

## IF {#if}

Checks the condition: `IF(condition_expression, then_expression, else_expression)`.

A simplified alternative is [CASE WHEN ... THEN ... ELSE ... END](../syntax/expressions.md#case).

You may omit the `else_expression` argument. In this case, if the condition is false (`condition_expression` returned `false`), an empty value is returned with the type corresponding to `then_expression` and allowing for `NULL`. Hence, the result will have an [optional data type](../types/optional.md).

**Examples**

```sql
SELECT
  IF(foo > 0, bar, baz) AS bar_or_baz,
  IF(foo > 0, foo) AS only_positive_foo
FROM my_table;
```

## NANVL {#nanvl}

Replaces the values `NaN` (not a number) in the expressions that have the type `Float`, `Double`, or [Optional](../types/optional.md).

Arguments:

1. The expression where you want to make a replacement.
2. The value to replace `NaN`.

If one of the arguments is  `Double`, the result is`Double`, otherwise, it's `Float`. If one of the arguments is `Optional`, then the result is `Optional`.

**Examples**

```sql
SELECT
  NANVL(double_column, 0.0)
FROM my_table;
```

## Random, RandomNumber, RandomUuid {#random}

Generates a pseudorandom number:

* `Random`: A floating point number (Double) from 0 to 1.
* `RandomNumber`: An integer from the complete Uint64 range.
* `RandomUuid`: [Uuid version 4](https://tools.ietf.org/html/rfc4122#section-4.4).

No arguments are used for random number generation: they are only needed to control the time of the call. A new random number is returned at each call. Therefore:

* If Random is called again within a **same query** and with a same set of arguments, the same set of random numbers is returned. Keep in mind that we mean the arguments themselves (i.e., the text between parentheses) rather than their values.
* Calling of Random with the same set of arguments in **different queries** returns different sets of random numbers.

Use cases:

* `SELECT RANDOM(1);`: Get one random value for the entire query and use it multiple times (to get multiple random values, you can pass various constants of any type).
* `SELECT RANDOM(1) FROM table;`: The same random number for each row in the table.
* `SELECT RANDOM(1), RANDOM(2) FROM table;`: Two random numbers for each row of the table, all the numbers in each of the columns are the same.
* `SELECT RANDOM(some_column) FROM table;`: Different random numbers for each row in the table.
* `SELECT RANDOM(some_column), RANDOM(some_column) FROM table;`: Different random numbers for each row of the table, but two identical numbers within the same row.
* `SELECT RANDOM(some_column), RANDOM(other_column) FROM table;`: Two columns, with different numbers in both.

**Examples**

```sql
SELECT
    Random(key) -- [0, 1)
FROM my_table;
```

```sql
SELECT
    RandomNumber(key) -- [0, Max<Uint64>)
FROM my_table;
```

```sql
SELECT
    RandomUuid(key) -- Uuid version 4
FROM my_table;
```

```sql
SELECT
    RANDOM(column) AS rand1,
    RANDOM(column) AS rand2, -- same as rand1
    RANDOM(column, 1) AS randAnd1, -- different from rand1/2
    RANDOM(column, 2) AS randAnd2 -- different from randAnd1
FROM my_table;
```

## CurrentUtcDate, CurrentUtcDatetime, and CurrentUtcTimestamp {#currentutcdate}

Getting the current date and/or time in UTC. The result data type is specified at the end of the function name.

The arguments are optional and work same as [RANDOM](#random).

**Examples**

```sql
SELECT CurrentUtcDate();
```

```sql
SELECT CurrentUtcTimestamp(TableRow()) FROM my_table;
```

## MAX_OF, MIN_OF, GREATEST, and LEAST {#max-min}

Returns the minimum or maximum among N arguments. Those functions let you replace the SQL standard statement `CASE WHEN a < b THEN a ELSE b END` that would be too sophisticated for N more than two.

The argument types must be mutually castable and accept `NULL`.

`GREATEST` is a synonym for `MAX_OF` and `LEAST` is a synonym for `MIN_OF`.

**Examples**

```sql
SELECT MIN_OF(1, 2, 3);
```

## AsTuple, AsStruct, AsList, AsDict, AsListStrict, and AsDictStrict {#as-container}

Creates containers of the applicable types.

Specifics:

* The container elements are passed in arguments. Hence, the number of elements in the resulting container is equal to the number of arguments passed, except when the dictionary keys repeat.
* `AsTuple` and `AsStruct` can be called without arguments, and also the arguments can have different types.
* The field names in `AsStruct` are set using `AsStruct(field_value AS field_name)`.
* Creating a list requires at least one argument to output the element types. To create an empty list, use the function [ListCreate](list.md#listcreate).
* To create a dictionary, you need at least one argument to output the element types. To create an empty dictionary, use the function [DictCreate](dict.md#listcreate).
* `AsList` outputs the common type of elements in the list. A type error is raised in the case of incompatible types.
* `AsDict` separately outputs the common types for keys and values. A type error is raised in the case of incompatible types.
* `AsListStrict` and `AsDictStrict` require the same type for their arguments.
* `AsDict` and `AsDictStrict` expect `Tuple` of two elements as arguments (key and value, respectively). If the keys repeat, only the value for the first key remains in the dictionary.

**Examples**

```sql
SELECT
  AsTuple(1, 2, "3") AS tuplevar,
  AsStruct(
    1 AS a,
    2 AS b,
    "3" AS c
  ) AS structvar,
  AsList(1, 2, 3) AS listvar,
  AsDict(
    AsTuple("a", 1),
    AsTuple("b", 2),
    AsTuple("c", 3)
  ) AS dictvar;
```

## AsTagged and Untag {#as-tagged}

Wraps the value in the [Tagged data type](../types/special.md) with the specified label, preserving the physical data type. `Untag`: The reverse operation.

Required arguments:

1. Value of any type.
2. Tag name.

Returns a copy of the value from the first argument with the specified tag in the data type.

Examples of use cases:

* Returns to the client's web interface the media files from BASE64-encoded strings.
* Prevent passing of invalid values at the boundaries of UDF calls.
* Additional refinements at the level of returned columns types.

The MIME types supported by the web interface and tags with the same names:

* image/jpeg
* image/png
* image/gif
* image/webp
* image/svg
* image/svg+xml
* audio/mp4
* audio/webm
* video/mp4
* video/webm

It also supports clickable links and displaying of media player for the linked content. Use the following tags to support them:

* url
* imageurl
* audiourl
* videourl

The web interface supports extended syntax for some tags.

### Link with any text {#url-struct}

To create a nice link with any text in the output, wrap in the `url` tag the structure `Struct<href:String?,text:String?,title:String?>`.

**Examples**

```sql
SELECT AsTagged(
    AsStruct(
        "https://yandex.ru/" AS href,
        "Yandex main page" AS text,
        "Yandex" AS title
    ),
    "url"
);
```

### Image with the specified size {#set-size-image}

To limit the image size, wrap in the `image/*` and `imageurl` tags the structure  `Struct<src:String,width:Int64?,height:Int64?,maxWidth:Int64?,maxHeight:Int64>`.

Here the `src` field is required, all the sizes are optional and are set in pixels.

**Examples**

```sql
SELECT AsTagged(
    AsStruct(
        "https://avatars.yandex-team.ru/get-yablog/id1166620212013/normal" AS src,
        200 AS maxWidth,
        200 AS maxHeighgitt
    ),
    "imageurl"
);
```

## TableRow {#tablerow}

Getting the entire table row as a structure. No arguments.

**Examples**

```sql
SELECT TableRow() FROM my_table;
```

## Ensure, EnsureType, and EnsureConvertibleTo {#ensure}

Checking for the user conditions:

* `Ensure`: Checking whether the predicate is true at query execution.
* `EnsureType`: Checking that the expression type exactly matches the specified type.
* `EnsureConvertibleTo`: A soft check of the expression type (with the same rules as for implicit type conversion).

If the check fails, the entire query fails.

Arguments:

1. An expression that will result from a function call if the check is successful. It's also checked for the data type in the corresponding functions.
2. Ensure uses a Boolean predicate that is checked for being `true`. The other functions use the data type that can be obtained using the [relevant functions](types.md) or a string literal with the [text description of the type](../misc/type_string.md).
3. An optional string with an error comment to be included in the overall error message when the query is complete. The data itself can't be used for type checks, since the data check is performed at query validation (or can be an arbitrary expression in the case of Ensure).

To check the conditions based on the final calculation result, it's convenient to combine Ensure with [DISCARD SELECT](../syntax/discard.md).

**Examples**

```sql
SELECT Ensure(
    value,
    value < 100,
    "value out or range"
) AS value FROM my_table;
```

```sql
SELECT EnsureType(
    value,
    TypeOf(other_value),
    "expected value and other_value to be of same type"
) AS value FROM my_table;
```

```sql
SELECT EnsureConvertibleTo(
    value,
    "Double?",
    "expected value to be numeric"
) AS value FROM my_table;
```

## Creating literals of primitive types based on a string literal {#data-type-literals}

Unlike `CAST("myString" AS MyType)`:

* The check for literal's castability to the desired type occurs at validation.
* The result is non-optional.

For the data types `Date`, `Datetime`, `Timestamp`, and `Interval`, literals are supported only in the format corresponding to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601). `Interval` has the following differences from the standard:

* It supports the negative sign for shifts to the past.
* Microseconds can be expressed as fractional parts of seconds.
* You can't use the units of measurement exceeding one day.
* The options with the beginning/end of the interval and with repetitions, are not supported.

{% include notitle [Десятичные типы](../../../_includes/decimal_args.md) %}

**Examples**

```sql
 SELECT
  Bool("true"),
  Uint8("0"),
  Int32("-1"),
  Uint32("2"),
  Int64("-3"),
  Uint64("4"),
  Float("-5"),
  Double("6"),
  Decimal("1.23", 5, 2), -- up to 5 decimal digits, with 2 after the decimal point
  String("foo"),
  Utf8("Hello"),
  Yson("<a=1>[3;%false]"),
  Json(@@{"a":1,"b":null}@@),
  Date("2017-11-27"),
  Datetime("2017-11-27T13:24:00Z"),
  Timestamp("2017-11-27T13:24:00.123456Z"),
  Interval("P1DT2H3M4.567890S"),
  Uuid("f9d5cc3f-f1dc-4d9c-b97e-766e57ca4ccb");
```

## Access to the metadata of the current operation {#metadata}

When you run YQL operations via the web interface or API, you get access to the following information:

* `CurrentOperationId`: The private ID of the operation.
* `CurrentOperationSharedId`: The public ID for the operation.
* `CurrentAuthenticatedUser`: The username of the current user.

No arguments.

If this data is missing, for example, when you run operations in the embedded mode, the functions return a string.

**Examples**

```sql
SELECT
    CurrentOperationId(),
    CurrentOperationSharedId(),
    CurrentAuthenticatedUser();
```

## ToBytes and FromBytes {#tobytes}

Conversion of [primitive data types](../types/primitive.md) to a string with their binary representation and back. Numbers are represented in the [little endian](https://en.wikipedia.org/wiki/Endianness#Little-endian) format.

**Examples**

```sql
SELECT
    ToBytes(7), -- "\u0007\u0000\u0000\u0000"
    FromBytes(
        "\xd2\x02\x96\x49\x00\x00\x00\x00",
        Uint64
    ); -- 1234567890ul
```

## ByteAt {#byteat}

Getting the byte value inside a string at an index counted from the beginning of the string. If an invalid index is specified, `NULL` is returned.

Arguments:

1. String: `String` or `Utf8`.
2. Index: `Uint32`.

**Examples**

```sql
SELECT
    ByteAt("foo", 0), -- 102
    ByteAt("foo", 1), -- 111
    ByteAt("foo", 9); -- NULL
```

## TestBit, ClearBit, SetBit, and FlipBit {#testbit}

Test, clear, set, or flip a bit in an unsigned number based on the specified sequence number of the bit.

Arguments:

1. An unsigned number that's subject to the operation. `TestBit` is also implemented for strings.
2. Number of the bit.

`TestBit` returns `true/false`. The other functions return a copy of their first argument with the corresponding conversion.

**Examples**

```sql
SELECT
    TestBit(1u, 0), -- true
    SetBit(8u, 0); -- 9
```

## Abs {#abs}

The absolute value of the number.

**Examples**

```sql
SELECT Abs(-123); -- 123
```

## Just {#just}

Change the data type of the value to an [optional](../types/optional.md) type derived from the current data type (for example, `T` becomes `T?`).

The reverse operation is [Unwrap](#unwrap).

**Examples**

```sql
SELECT
  Just("my_string"); --  String?
```

## Unwrap {#unwrap}

Converting the [optional](../types/optional.md) value of the data type to the relevant non-optional type, raising a runtime error if the data is `NULL`. It means that `T?` becomes `T`.

Arguments:

1. Value to be converted.
2. An optional string with a comment for the error text.

Reverse operation is [Just](#just).

**Examples**

```sql
$value = Just("value");

SELECT Unwrap($value, "Unexpected NULL for $value");
```

## Nothing {#nothing}

Create an empty value for the specified [optional](../types/optional.md) data type.

**Examples**

```sql
SELECT
  Nothing(ParseType("String?")); -- an empty (NULL) value with the String? type
```

For more information about `ParseType` and other functions for data types, see [Data types](types.md).

## AGGREGATION_FACTORY {#aggregationfactory}

Create a factory of [aggregate functions](aggregation.md) to separately describe the methods of aggregation and data types subject to aggregation.

Arguments:

1. A string in double quotes with the name of an aggregate function, for example ["MIN"](aggregation.md#min).
2. Optional parameters of the aggregate function that are data-independent. For example, the percentile value in [PERCENTILE](aggregation.md#percentile).

The resulting factory can be used as the second parameter of the [AGGREGATE_BY](aggregation.md#aggregateby) function.
If the aggregate function is applied to two columns instead of one, as, for example, [MIN_BY](aggregation.md#minby), then the first argument of [AGGREGATE_BY](aggregation.md#aggregateby) passes a `Tuple` of two values. See more details in the description of the applicable aggregate function.

**Examples**

```sql
$factory = AGGREGATION_FACTORY("MIN");
SELECT
    AGGREGATE_BY (value, $factory) AS min_value -- apply the MIN aggregation to the "value" column
FROM my_table;
```

## LIKELY {#likely}

Lets you hint the optimizer that the Boolean value in the argument will most often be `true`. At the moment, this hint is only used while selecting the [JOIN](../syntax/join.md) execution strategy.

## GROUPING {#grouping}

Lets you distinguish the subtotal from `NULL` in the aggregated source data. For more information, see the documentation for [ROLLUP, CUBE, and GROUPING SETS](../syntax/group_by.md#rollup).

