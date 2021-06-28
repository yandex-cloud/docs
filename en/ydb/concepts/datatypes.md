---
title: Data Types in Yandex Database (YDB) 
description: 'Yandex Database (YDB) uses YQL data types. Some of the YQL types are supported with restrictions — they can only be used in calculations, but cannot be a column type or used in a primary key. All columns, including key columns, can contain the special NULL value. The tables show the possible uses of YQL data types in YDB.'
---

# Data types in Yandex Database (YDB)

This section describes the data types that {{ ydb-short-name }} supports.

## Supported data types

{{ ydb-short-name }} uses [YQL](../yql/reference/overview.md) data types. Some YQL types have limited support: they can only be used in calculations, but can't function as column types or be used in the primary key. All columns, including key columns, may contain a special `NULL` value.

{% note warning "Значения NULL в ячейках первичного ключа" %}

Although it's possible to have composite primary key values in which some field values store `NULL`, we strongly recommend that you never do that and never store `NULL` in a primary key.

{% endnote %}

Tables 1,2, and 3 show possible ways to use YQL data types in {{ ydb-short-name }}.

## Numeric data types

<small>Table 1. Possible ways to use numeric YQL data types in {{ ydb-short-name }}</small>

| **Type** | **Explanation** | **Used<br>in queries<br>and YQL calculations** | **Used<br>as the<br>column<br>data type** | **Used in<br>primary<br>keys** | **Supports the<br>comparison<br>option** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `Bool` | standard Boolean type, `true` or `false` | Yes | Yes | Yes | Yes |
| `Int8` | Signed integer, from -2<sup>7</sup> to 2<sup>7</sup> − 1 | Yes | No | No | Yes |
| `Int16` | Signed integer, from -2<sup>15</sup> to 2<sup>15</sup> − 1 | Yes | No | No | Yes |
| `Int32` | Signed integer, from -2<sup>31</sup> to 2<sup>31</sup> − 1 | Yes | Yes | Yes | Yes |
| `Int64` | Signed integer, from -2<sup>63</sup> to 2<sup>63</sup> − 1 | Yes | Yes | Yes | Yes |
| `Uint8` | Unsigned integer, from 0 to 2<sup>8</sup> − 1 | Yes | Yes | Yes | Yes |
| `Uint16` | Unsigned integer, from 0 to 2<sup>16</sup> − 1 | Yes | No | No | Yes |
| `Uint32` | Unsigned integer, from 0 to 2<sup>32</sup> − 1 | Yes | Yes | Yes | Yes |
| `Uint64` | Unsigned integer, from 0 to 2<sup>64</sup> − 1 | Yes | Yes | Yes | Yes |
| `Float` | Real 4-byte number | Yes | Yes | No | Yes |
| `Double` | Real 8-byte number | Yes | Yes | No | Yes |
| `Decimal` | Fixed precision number, currently `Decimal(22,9)` is supported — 13 integer digits, 9 fractional digits | Yes | Yes | No | Yes |
| `DyNumber` | A binary representation of a floating-point number that preserves order | Yes | Yes | Yes | Yes |

## String data types

<small>Table 2. Possible ways to use YQL string data types in {{ ydb-short-name }}</small>

| **Type** | **Explanation** | **Used<br>in queries<br>and YQL calculations** | **Used<br>as the<br>column<br>data type** | **Used in<br>primary<br>keys** | **Supports the<br>comparison<br>option** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `String` | An arbitrary sequence of bytes | Yes | Yes | Yes | Yes |
| `Utf8` | Text encoded in [UTF-8](https://en.wikipedia.org/wiki/UTF-8) | Yes | Yes | Yes | Yes |
| `Json` | Valid [JSON](https://en.wikipedia.org/wiki/JSON) represented as text | Yes | Yes | No | No |
| `JsonDocument` | Valid [JSON](https://en.wikipedia.org/wiki/JSON) in an indexed binary representation | Yes | Yes | No | No |
| `Uuid` | A universally unique identifier [UUID](https://tools.ietf.org/html/rfc4122) | Yes | No | No | Yes |

{% note info "Ограничения на размер" %}

The maximum value size in a cell with any string data type is about 4 MB.

{% endnote %}

{% note info "Отличия Json и JsonDocument" %}

Unlike the `JSON` data type that stores the original text representation passed by the user, `JsonDocument` uses an indexed binary representation. An important difference from the point of view of semantics is that `JsonDocument` doesn't preserve formatting, the order of keys in objects, or their duplicates.

Thanks to the indexed view, `JsonDocument` lets you bypass the document model using `JsonPath` without the need to parse the full content. This helps efficiently perform operations from the [JSON API](../yql/reference/builtins/json.md), reducing delays and the cost of user queries. Execution of `JsonDocument` queries can be up to several times more efficient depending on the type of load.

Due to the added redundancy, `JsonDocument` is less effective in storage. The additional storage overhead depends on the specific content, but is 20%-30% of the original volume on average. Moreover, saving data in `JsonDocument` format requires additional conversion from text, which makes writing it somewhat less efficient. However, for most read-intensive scenarios that involve processing data from JSON, the new data type is preferred and recommended.

{% endnote %}

## Date and time

<small>Table 3. Possible ways to use date and time YQL data types in {{ ydb-short-name }}</small>

| **Type** | **Explanation** | **Used<br>in queries<br>and YQL calculations** | **Used<br>as the<br>column<br>data type** | **Used in<br>primary<br>keys** | **Supports the<br>comparison<br>option** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `Date` | Precision to the day | Yes | Yes | Yes | Yes |
| `Datetime` | Precision to the second | Yes | Yes | Yes | Yes |
| `Timestamp` | Precision to the microsecond | Yes | Yes | Yes | Yes |
| `Interval` | Precision to the microsecond, valid interval values must not exceed 24 hours | Yes | Yes | No | Yes |

## Optional values (types that allow NULL)

Any typed data in YQL, including table columns, can be either non-nullable (guaranteed value) or nullable (empty value denoted as `NULL`). These values are called "optional" (or "nullable", in SQL terms).

The most common operation for such data types is [COALESCE](../yql/reference/builtins/basic.md#coalesce), which lets you leave filled values unchanged while replacing `NULL` with the following default value.

When [you declare such data types in text format](../yql/reference/misc/type_string.md), use the question mark at the end (for example, `String?`) or the notation `Optional<...>`.

## Containers

<small>Table 4. Composite YQL data types</small>

| **Name** | **Type declaration** | **Type example** | **Explanation** |
| :--- | :--- | :--- | :--- |
| List | `List<Type>` | `List<Int32>` | A variable-length sequence consisting of same-type elements. |
| Dictionary | `Dict<KeyType, ValueType>` | `Dict<String, Int32>` | Set of key-value pairs with a fixed type of keys and values. |
| Tuple | `Tuple<Type1, ..., TypeN>` | `Tuple<Int32, Double>` | Set of unnamed fixed-length elements with types specified for all elements. |
| Structure | `Struct<Name1:Type1, ..., NameN:TypeN>` | `Struct<Name:String, Age:Int32>` | A set of named fields with specified value types, fixed at query start (must be data-independent). |
| Stream | `Stream<Type>` | `Stream<Int32>` | Single-pass iterator by same-type values, not serializable |
| Variant on tuple | `Variant<Type1, Type2>` | `Variant<Int32, String>` | A tuple known to have exactly one element filled |
| Variant on structure | `Variant<Name1:Type1, Name2:Type2>` | `Variant<value:Int32, error:String>` | A structure known to have exactly one element filled |

If necessary, you can nest containers in any combination, for example, `List<Tuple<Int32, Int32>>` (a list containing tuples as elements).

In certain contexts, optional values can also be considered a container type (`Optional<Type>`) that behaves like a list of length 0 or 1.

To implement sets, use a dictionary with `Void` - `Dict<T, Void>` type values.

