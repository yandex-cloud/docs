---
title: Data Types in Yandex DataLens
description: 'DataLens uses different data sources with various field data types. To streamline the data operations, DataLens converts the source data types to its own types. This optimizes data operations. You can change the field data type in the dataset interface and in the wizard.'
---

# Data types in Yandex DataLens

{{ datalens-short-name }} uses different data sources with various field data types.

To streamline the data operations, {{ datalens-short-name }} converts the source data types to its own types.
This optimizes data operations. Learn more in [{#T}](#types-lookup-table).

You can change the field data type in the dataset interface and in the wizard.

{% note warning %}

When you load a CSV file as a data source, {{ datalens-short-name }} tries to automatically detect the types of data in its fields.
If it can't detect the data type, DataLens sets the `String` data type for the field.

You can use the dataset interface or the wizard to change the field data type.

{% endnote %}

## Geopoint {#geopoint}

A coordinate point defined by latitude and longitude. In {{ datalens-short-name }}, it's set using the function [GEOPOINT](../function-ref/GEOPOINT.md).

As the input, the function accepts the `String` and `Geocache` data types, or two values of the `Fractional number` or `String` type.
If a single string is input, it must contain a list of two numbers in JSON format.

If the source data is a string like `"[55.75222,37.61556]"`, you can use the dataset interface or wizard to change the field data type without a formula.

#### Record example {#geopoint-example}

```sql
GEOPOINT("[55.7912,37.6872]")
GEOPOINT("[55.8538,37.6312]")
```

## Geopolygon {#geopolygon}

Several coordinate points defining the polygon on the map. You can define a polygon in {{ datalens-short-name }} using the function [GEOPOLYGON](../function-ref/GEOPOLYGON.md).
The [Even-Odd](https://en.wikipedia.org/wiki/Even–odd_rule) algorithm is used to fill in the polygon. This way you can create polygons with holes.

The function accepts strings in the format `"[[[v1,v1], [v2,v2]], ..., [[vN-1,vN-1], [vN,vN]]]"`. If the source data is in this format, you can use the dataset interface or wizard to change the field data type without a formula.

#### Record example {#geopolygon-example}

```sql
/* Polygon without a hole */
GEOPOLYGON("[[[55.79421,37.65046],[55.79594,37.6513],[55.79642,37.65133],[55.7969, 37.65114],[55.79783, 37.65098],[55.78871,37.75101]]]")

/* Polygons with a hole */
GEOPOLYGON("[[[55.75,37.52],[55.75,37.68],[55.65,37.60]],[[55.79,37.60],[55.76,37.57],[55.76,37.63]]]")
GEOPOLYGON("[[[55.75,37.50],[55.80,37.60],[55.75,37.70],[55.70,37.70],[55.70,37.50]],[[55.75,37.52],[55.75,37.68],[55.65,37.60]],[[55.79,37.60],[55.76,37.57],[55.76,37.63]]]")
```

## Date {#date}

Date without specified time.

When you use date in formulas, make sure to use hash `#` around it. For example, `DATETRUNC(#2018-07-12#, "year", 5)`.

You can convert the source data type to `Date` by using the functions [DATE](../function-ref/DATE.md) and [DATE_PARSE](../function-ref/DATE_PARSE.md).

#### Record example {#date-example}

```sql
#2018-01-18#
#2015-01-01#
DATETRUNC(#2018-07-12#, "year", 5)
DATEADD(#2018-01-12#, "day", 6)
```

## Date and time {#datetime}

Date with specified time.

When you use date and time in formulas, make sure to use a hash `#` around it. For example, `DATEADD(#2018-01-12 01:02:03#, "second", 6)`.

You can convert the source data type to `Date and time` by using the functions [DATETIME](../function-ref/DATETIME.md) and [DATETIME_PARSE](../function-ref/DATETIME_PARSE.md).

#### Record example {#datetime-example}

```sql
#2018-01-12 01:08:03#
#2018-05-01T#
DATEADD(#2018-01-12 01:02:03#, "second", 6)
DATETRUNC(#2018-07-12 11:07:13#, "month", 4)
```

## Fractional number {#float}

Decimal number. The dot is used as a decimal separator.

You can convert the source data type to a `Fractional number` by using the function [FLOAT](../function-ref/FLOAT.md).

{% note warning %}

When you convert the `decimal` type to a `Fractional number`, you may lose accuracy.

{% endnote %}

#### Record example {#float-example}

```sql
1.47113
0.62024
FLOAT("34.567")
```

## Logical {#boolean}

A logical type that can be either `TRUE` or `FALSE`.

You can convert the source data type to `Logical` by using the function [BOOL](../function-ref/BOOL.md).

#### Record example {#boolean-example}

```sql
FALSE
```

## String {#string}

A string containing text. It is enclosed in single or double quotes.
If you enclose your string in one type of quotes, you can use the second quote type inside the string without escaping.
For example, `'Double quoted "example" and one " double quote.'`

You can use the following characters inside strings:

- `\n`: Line feed (LF).
- `\r`: Carriage return (CR).
- `\t`: Tab.
- `\"`: Double quote.
- `\'`: Single quote.
- `\\`: Backslash.

You can convert the source data type to `String` by using the function [STR](../function-ref/STR.md).

#### Record example {#string-example}

```sql
"String"
'String with a "substring"'
```

## Integer {#integer}

A number with no no fractional part.

You can convert the source data type to `Integer` by using the function [INT](..//function-ref/INT.md).

#### Record example {#integer-example}

```sql
42
157
```

## Data type matching table {#types-lookup-table}

When you create a dataset, {{ datalens-short-name }} converts the source data to its own type for streamlined data processing.
This helps {{ datalens-short-name }} unify the operations with data from different sources.

The table below shows how data types of different databases and {{ datalens-short-name }} internal data types correspond to one another.

| DataLens | Materialized<br/>dataset | ClickHouse | PostgreSQL | MySQL | MS SQL |
| ----- | ----- | ----- | ----- | ----- | ----- |
| **Logical** | boolean | boolean | boolean | bit | bit |
| **Date** | date | date | date | date | date |
| **Date and time** | datetime | datetime | timestamp | datetime<br/>timestamp | datetime<br/>datetime2<br/>smalldatetime<br/>datetimeoffset |
| **Fractional number** | float | float<br/>float32<br/>float64<br/>decimal<sup>*</sup> | real<br/>double precision<br/>numeric | float<br/>double<br/>numeric<br/>decimal<sup>*</sup> | float<br/>real<br/>numeric<br/>decimal<sup>*</sup> |
| **Integer** | int64 | integer<br/>int8<br/>int16<br/>int32<br/>int64<br/>uint8<br/>uint16<br/>uint32<br/>uint64 | smallint<br/>integer<br/>bigint | tinyint<br/>smallint<br/>mediumint<br/>integer<br/>bigint | tinyint<br/>smallint<br/>integer<br/>bigint |
| **String** | string | string<br/>enum8<br/>enum16 | char<br/>varchar<br/>text<br/> | tinyblob<br/>blob<br/>binary<br/>varbinary<br/>char<br/>varchar<br/>tinytext<br/>text<br/>enum | char<br/>varchar</br>text<br/>nchar<br/>nvarchar<br/>ntext<br/> |
| **Geopoint** | Set by a formula in {{ datalens-short-name }} | Set by a formula in {{ datalens-short-name }} | Set by a formula in {{ datalens-short-name }} | Set by a formula in {{ datalens-short-name }} | Set by a formula in {{ datalens-short-name }} |
| **Geopolygon** | Set by a formula in {{ datalens-short-name }} | Set by a formula in {{ datalens-short-name }} | Set by a formula in {{ datalens-short-name }} | Set by a formula in {{ datalens-short-name }} | Set by a formula in {{ datalens-short-name }} |

<sup>*</sup> You may lose accuracy when converting data.

