---
title: Data Types in Yandex Database (YDB) 
description: 'Yandex Database (YDB) uses YQL data types. Some of the YQL types are supported with restrictions — they can only be used in calculations, but cannot be a column type or used in a primary key. All columns, including key columns, can contain the special NULL value. The tables show the possible uses of YQL data types in YDB.'
---

# Data types {{ ydb-name }}

{{ ydb-short-name }} uses [YQL](../yql/reference/overview.md) data types. Some YQL types have limited support: they are used only in calculations, but can't function as column types or parts of the primary key. All columns, including key columns, can contain a special `NULL`  value.

{% note warning %}

While it's possible to save `NULL` values in some composite primary key fields, we don't recommend storing `NULL` in the primary key.

{% endnote %}

## Numeric types {#numeric}

{% include [datatypes-primitive-number](../_includes/datatypes_primitive_number.md) %}

## String types {#string}

{% include [datatypes-primitive-string](../_includes/datatypes_primitive_string.md) %}

Unlike the `JSON` data type that stores the original text representation passed by the user, `JsonDocument` uses an indexed binary representation. An important difference from the point of view of semantics is that `JsonDocument` doesn't preserve formatting, the order of keys in objects, or their duplicates.

Thanks to the indexed view, `JsonDocument` lets you bypass the document model using `JsonPath` without the need to parse the full content. This improves efficiency for [JSON API](../yql/reference/builtins/json.md) operations, reducing delays and user query costs. Execution of `JsonDocument` queries can be up to several times more efficient depending on the type of load.

Due to the added redundancy, `JsonDocument` is less effective in storage. The additional storage overhead depends on the specific content, but is 20-30% of the original volume on average. Saving data in `JsonDocument` format requires additional conversion from the textual representation, which makes writing it less efficient. However, for most read-intensive scenarios that involve processing data from JSON, this data type is preferred and recommended.

{% note warning %}

To store numbers (JSON Number) in `JsonDocument` and perform arithmetic operations on them in the [JSON API](../yql/reference/builtins/json.md), the [Double](https://en.wikipedia.org/wiki/Double-precision_floating-point_format) type is used. Precision might be lost when non-standard representations of numbers are used in the source JSON document.

{% endnote %}

## Date and time {#datetime}

{% include [datatypes-primitive-datetime](../_includes/datatypes_primitive_datetime.md) %}

## Optional types {#optional}

{% include [datatypes-optional](../_includes/datatypes-optional.md) %}

Optional data types are [container](#containers) types that can be arbitrarily nested into each other or other containers.

When you search the dictionary (`Dict(k,v)`) using the `Optional<T>` type value, the search result is `Optional<Optional<T>>`.

Example query:

```sql
$dict = {"a":1, "b":null};
$found = $dict["b"];
select if($found is not null, unwrap($found), -1);
```

Result:

```text
# column0
0 null
```

## Containers {#containers}

{% include [datatypes-containers](../_includes/datatypes-containers.md) %}

If necessary, you can nest containers in any combination. For example, `List<TupleInt32, Int32>` (a list containing tuples as elements).

[In certain contexts, optional values](#optional) can also be considered a container type (`Optional<Type>`) that behaves as a list of length `0` or `1`.

To implement sets, use a dictionary with `Void` — `Dict<T, Void>` type values.

To access the container elements, use [dot or curly brackets](../yql/reference/syntax/expressions.md#items-access), depending on the container type.

## Special data types {#special}

{% include [datatypes-special](../_includes/datatypes-special.md) %}

## {{ ydb-short-name }} data representation in JSON format {#type-json}

### Bool {#bool}

Boolean value.

* Type in JSON: `bool`.
* Sample {{ ydb-short-name }} value: `true`.
* Sample JSON value: `true`.

### Int8, Int16, Int32, Int64 {#int}

Signed integer types.

* Type in JSON: `number`.
* Sample {{ ydb-short-name }} value: `123456`, `-123456`.
* Sample JSON value: `123456`, `-123456`.

### Uint8, Uint16, Uint32, Uint64 {#uint}

Unsigned integer types.

* Type in JSON: `number`.
* Sample {{ ydb-short-name }} value: `123456`.
* Sample JSON value: `123456`.

### Float {#float}

Real 4-byte number.

* Type in JSON — `number`.
* Sample {{ ydb-short-name }} value: `0.12345679`.
* Sample JSON value: `0.12345679`.

### Double {#double}

Real 8-byte number.

* Type in JSON: `number`.
* Sample {{ ydb-short-name }} value: `0.12345678901234568`.
* Sample JSON value: `0.12345678901234568`.

### Decimal {#decimal}

Fixed-precision number. Only Decimal(22, 9) is supported.

* Type in JSON: `string`.
* Sample {{ ydb-short-name }} value: `-320.789`.
* Sample JSON value: `"-320.789"`.

### String {#string}

Binary strings. Encoding algorithm depending on the byte value:

* [0-31] — `\u00XX` (6 characters denoting the Unicode character code).
* [32-126] — as is. These are readable single-byte characters that don't need to be escaped.
* [127-255] — `\u00XX`.

Decoding is a reverse process. Character codes in `\u00XX`, maximum 255.

* Type in JSON: `string`.
* Sample {{ ydb-short-name }} value: A sequence of 4 bytes:
  * 5 `0x05`: A control character.
  * 10 `0x0a`: The `\n` newline character.
  * 107 `0x6b`: The `k` character.
  * 255 `0xff`: The `ÿ` character in Unicode.
* Sample JSON value: `"\u0005\nk\u00FF"`.

### Utf8, Json, Uuid {#utf}

String types in UTF-8. Such strings are represented in JSON as strings with JSON characters escaped: `\\`, `\"`, `\n`, `\r`, `\t`, `\f`.

* Type in JSON: `string`.

* Sample {{ ydb-short-name }} value: C++ code:

  ```c++
  "Escaped characters: "
  "\\ \" \f \b \t \r\n"
  "Non-escaped characters: "
  "/ ' < > & []() ".
  ```

* Sample JSON value: `"Escaped characters: \\ \" \f \b \t \r\nNon-escaped characters: / ' < > & []() "`.

### Date {#date}

Date. Uint64, unix time days.

* Type in JSON: `string`.
* Sample {{ ydb-short-name }} value: `18367`.
* Sample JSON value: `"2020-04-15"`.

### Datetime {#datetime}

Date and time. Uint64, unix time seconds.

* Type in JSON: `string`.
* Sample {{ ydb-short-name }} value: `1586966302`.
* Sample JSON value: `"2020-04-15T15:58:22Z"`.

### Timestamp {#timestamp}

Date and time. Uint64, unix time microseconds.

* Type in JSON: `string`.
* Sample {{ ydb-short-name }} value: `1586966302504185`.
* Sample JSON value: `"2020-04-15T15:58:22.504185Z"`.

### Interval {#interval}

Time interval. Int64, precision to the microsecond, the interval values must not exceed 24 hours.

* Type in JSON: `number`.
* Sample {{ ydb-short-name }} value: `123456`, `-123456`.
* Sample JSON value: `123456`, `-123456`.

### Optional {#optional}

Means that the value can be `null`. If the value is `null`, then in JSON it's also `null`. If the value is not `null`, then the JSON value is expressed as if the type isn't `Optional`.

* Type in JSON is missing.
* Sample {{ ydb-short-name }} value: `null`.
* Sample JSON value: `null`.

### List {#list}

List. An ordered set of values of a given type.

* Type in JSON: `array`.
* Sample {{ ydb-short-name }} value:
  * Type: `List<Int32>`.
  * Value: `1, 10, 100`.
* Sample JSON value: `[1,10,100]`.

### Stream {#stream}

Stream. Single-pass iterator by same-type values,

* Type in JSON: `array`.
* Sample {{ ydb-short-name }} value:
  * Type: `Stream<Int32>`.
  * Value: `1, 10, 100`.
* Sample JSON value: `[1,10,100]`.

### Struct {#struct}

Structure. An unordered set of values with the specified names and type.

* Type in JSON: `object`.
* Sample {{ ydb-short-name }} value:
  * Type: `Struct<'Id':Uint32,'Name':String,'Value':Int32,'Description':Utf8?>`;
  * Value: `"Id":1,"Name":"Anna","Value":-100,"Description":null`.
* Sample JSON value: `{"Id":1,"Name":"Anna","Value":-100,"Description":null}`.

### Tuple {#tuple}

Tuple. An ordered set of values of the set types.

* Type in JSON: `array`.
* Sample {{ ydb-short-name }} value:
  * Type: `Tuple<Int32??,Int64???,String??,Utf8???>`;
  * Value: `10,-1,null,"Some string"`.
* Sample JSON value: `[10,-1,null,"Some string"]`.

### Dict {#dict}

Dictionary. An unordered set of key-value pairs. The type is set both for the key and the value. It's written in JSON to an array of arrays including two items.

* Type in JSON: `array`.
* Sample {{ ydb-short-name }} value:
  * Type: `Dict<Int64,String>`.
  * Value: `1:"Value1",2:"Value2"`.
* Sample JSON value: `[[1,"Value1"],[2,"Value2"]]`.

