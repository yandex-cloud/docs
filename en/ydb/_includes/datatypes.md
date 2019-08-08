# Data types

{{ ydb-short-name }} uses YQL data types. Some YQL types have limited support: they can only be used in calculations, but can't function as column types or be used in the primary key. All columns, including key columns, can contain a special NULL value.

{% note alert %}

Although it is possible to store NULL in some fields of a composite primary key, you should never do this.

{% endnote %}

The tables below show possible ways to use YQL data types in {{ ydb-short-name }}.

## Numeric {#numeric}

| Type | Explanation | Used in YQL<br/>queries and<br/>calculations<br/> | Used as<br/>a type<br/>of column data | Used in<br/>primary<br/>keys | Supports the<br/>comparison<br/>option |
| ----- | ----- | ----- | ----- | ----- | ----- |
| **Bool** | Boolean value | Yes | Yes | Yes | Yes |
| **Int8** | Signed integer (from –2<sup>7</sup> to 2<sup>7</sup>–1) | Yes | No | No | Yes |
| **Int16** | Signed integer (from –2<sup>15</sup> to 2<sup>15</sup>–1) | Yes | No | No | Yes |
| **Int32** | Signed integer (from –2<sup>31</sup> to 2<sup>31</sup>–1) | Yes | Yes | Yes | Yes |
| **Int64** | Signed integer (from –2<sup>63</sup> to 2<sup>63</sup>–1) | Yes | Yes | Yes | Yes |
| **Uint8** | Unsigned integer (from 0 to 2<sup>8</sup>–1) | Yes | Yes | Yes | Yes |
| **Uint16** | Unsigned integer (from 0 to 2<sup>16</sup>–1) | Yes | No | No | Yes |
| **Uint32** | Unsigned integer (from 0 to 2<sup>32</sup>–1) | Yes | Yes | Yes | Yes |
| **Uint64** | Unsigned integer (from 0 to 2<sup>64</sup>–1) | Yes | Yes | Yes | Yes |
| **Float** | Floating-point number | Yes | Yes | No | Yes |
| **Decimal** | Fixed precision number, **Decimal(22,9)** is supported — 13 integer digits, 9 fractional digits | Yes | Yes | No | Yes |
| **Double** | Double-precision number | Yes | Yes | No | Yes |

## String {#string}

| Type | Explanation | Used in YQL<br/>queries and<br/>calculations<br/> | Used as<br/>a type<br/>of column data | Used in<br/>primary<br/>keys | Supports the<br/>comparison<br/>option |
| ----- | ----- | ----- | ----- | ----- | ----- |
| **String** | Can contain any binary data | Yes | Yes | Yes | Yes |
| **Utf8** | Contains text in&nbsp;UTF-8 encoding | Yes | Yes | Yes | Yes |
| **Json** | Contains JSON | Yes | Yes | No | No |
| **Yson** | Contains YSON | Yes | Yes | No | No |
| **Uuid** | Contains UUID | Yes | No | No | Yes |

The maximum value size in a cell with any string data type is about 4 MB.

## Date and time {#datetime}

| Type | Explanation | Used in YQL<br/>queries and<br/>calculations<br/> | Used as<br/>a type<br/>of column data | Used in<br/>primary<br/>keys | Supports the<br/>comparison<br/>option |
| ----- | ----- | ----- | ----- | ----- | ----- |
| **Date** | Precision to the day | Yes | No | No | Yes |
| **Datetime** | Precision to the second | Yes | No | No | Yes |
| **Timestamp** | Precision to the microsecond | Yes | No | No | Yes |
| **Interval** | Precision to the microsecond, valid interval values must not exceed 24 hours | Yes | No | No | Yes |
| **TzDate** | Precision to the day, contains a time zone label | Yes | No | No | Yes |
| **TzDatetime** | Precision to the second, contains a time zone label | Yes | No | No | Yes |
| **TzTimestamp** | Precision to the microsecond, contains a time zone label | Yes | No | No | Yes |

## Optional (nullable) {#nullable}

Any typed data in YQL, including table columns, can be either non-nullable (guaranteed value) or nullable (empty value denoted as `NULL`). These values are called "optional" (or "nullable", in SQL terms).

The most common operation for such data types is COALESCE, which lets you leave filled values unchanged while replacing `NULL` with the following default value.

In text format, optional types are marked by a question mark at the end (for example, `String?`) or as `Optional<...>`.

## Containers {#containers}

| Name | Type&nbsp;declaration | Type&nbsp;example | Explanation |
| ----- | ----- | ----- | ----- |
| List | `List<Type>` | `List<Int32>` | A variable-length sequence consisting of same type elements |
| Dictionary | `Dict<KeyType,ValueType>` | `Dict<String,Int32>` | Set of key—value pairs with a fixed type of keys and values |
| Tuple | `Tuple<Type1,...,TypeN>` | `Tuple<Int32,Double>` | Set of unnamed fixed-length elements with types specified for all elements |
| Structure | `Struct<Name1:Type1,...,NameN:TypeN>` | `Struct<Name:String,Age:Int32>` | A set of named fields with specified value types, fixed at query start (must be data-independent) |
| Stream | `Stream<Type>` | `Stream<Int32>` | Single-pass iterator by same-type values, not serializable |
| Variant on tuple | `Variant<Type1,Type2>` | `Variant<Int32,String>` | A tuple known to have exactly one element filled |
| Variant on structure | `Variant<Name1:Type1,Name2:Type2>` | `Variant<value:Int32,error:String>` | A structure known to have exactly one element filled |

If necessary, you can nest containers in any combination, for example, `List<Tuple<Int32,Int32>>` (a list containing tuples as elements).

In certain contexts, optional values can also be considered a container type (`Optional<Type>`) that behaves like a list of length 0 or 1.

To implement sets, use a dictionary with `Void` — `Dict<T, Void>` type values.

