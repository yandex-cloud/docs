---
title: Type conversion functions
editable: false
sourcePath: en/_api-ref/datalens/function-ref/type-conversion-functions.md
---

# Type conversion functions


## [BOOL](BOOL.md)

**Syntax:**`BOOL( expression )`

Converts the `expression` expression to Boolean type according to the following rules:

| Type                                                           | `FALSE`             | `TRUE`     |
|:---------------------------------------------------------------|:--------------------|:-----------|
| <code>Fractional number &#124; Integer</code>                  | `0`, `0.0`          | All others |
| `String`                                                       | Empty string (`""`) | All others |
| `Boolean`                                                      | `FALSE`             | `TRUE`     |
| <code>Date &#124; Datetime &#124; Datetime (deprecated)</code> | -                   | `TRUE`     |



## [DATE](DATE.md)

**Syntax:**`DATE( expression [ , timezone ] )`

Converts the `expression` expression to date format.

The date must be in the format `YYYY-MM-DD`.

If `expression` is a number, then the `timezone` option can be used to convert the date to the specified time zone.



## [DATE_PARSE](DATE_PARSE.md)

**Syntax:**`DATE_PARSE( value )`

Converts the `value` expression to date format. Unlike [DATE](DATE.md), it supports multiple formats.



## [DATETIME](DATETIME.md)

**Syntax:**`DATETIME( expression [ , timezone ] )`

Converts the `expression` expression to date and time format. When converting `Date` to `DateTime`, the time is set to '00:00:00'.
The date must be in the format `YYYY-MM-DDThh:mm:ss` or `YYYY-MM-DD hh:mm:ss`.

If `expression` is a number, then the date and time can be converted to the specified time zone when the `timezone` option is available.



## [DATETIME_PARSE](DATETIME_PARSE.md)

**Syntax:**`DATETIME_PARSE( value )`

Converts the `value` expression to date and time format. Unlike [DATETIME](DATETIME.md), it supports multiple formats.



## [DB_CAST](DB_CAST.md)

**Syntax:**`DB_CAST( expression, native_type [ , param_1 [ , param_2 ] ] )`

Converts the `expression` expression to database's native type `native_type`.

The following type casts are supported:

| Data source   | Data type                     | Native data type      | Parameters for native type   | Comment                       |
|:--------------|:------------------------------|:----------------------|:-----------------------------|:------------------------------|
| `ClickHouse`  | `Fractional number`           | `Float32`             |                              |                               |
| `ClickHouse`  | `Fractional number`           | `Float64`             |                              |                               |
| `ClickHouse`  | `Fractional number`           | `Decimal`             | `Integer`, `Integer`         |                               |
| `ClickHouse`  | `Integer`                     | `Int8`                |                              |                               |
| `ClickHouse`  | `Integer`                     | `Int16`               |                              |                               |
| `ClickHouse`  | `Integer`                     | `Int32`               |                              |                               |
| `ClickHouse`  | `Integer`                     | `Int64`               |                              |                               |
| `ClickHouse`  | `Integer`                     | `UInt8`               |                              |                               |
| `ClickHouse`  | `Integer`                     | `UInt16`              |                              |                               |
| `ClickHouse`  | `Integer`                     | `UInt32`              |                              |                               |
| `ClickHouse`  | `Integer`                     | `UInt64`              |                              |                               |
| `ClickHouse`  | `String`                      | `String`              |                              |                               |
| `PostgreSQL`  | `Array of fractional numbers` | `double precision[]`  |                              |                               |
| `PostgreSQL`  | `Array of fractional numbers` | `real[]`              |                              |                               |
| `PostgreSQL`  | `Array of fractional numbers` | `numeric[]`           | `Integer`, `Integer`         |                               |
| `PostgreSQL`  | `Array of integers`           | `smallint[]`          |                              |                               |
| `PostgreSQL`  | `Array of integers`           | `integer[]`           |                              |                               |
| `PostgreSQL`  | `Array of integers`           | `bigint[]`            |                              |                               |
| `PostgreSQL`  | `Array of strings`            | `text[]`              |                              |                               |
| `PostgreSQL`  | `Array of strings`            | `character varying[]` |                              |                               |
| `PostgreSQL`  | `Array of strings`            | `varchar[]`           |                              |                               |
| `PostgreSQL`  | `Fractional number`           | `double precision`    |                              |                               |
| `PostgreSQL`  | `Fractional number`           | `real`                |                              |                               |
| `PostgreSQL`  | `Fractional number`           | `numeric`             | `Integer`, `Integer`         |                               |
| `PostgreSQL`  | `Integer`                     | `smallint`            |                              |                               |
| `PostgreSQL`  | `Integer`                     | `integer`             |                              |                               |
| `PostgreSQL`  | `Integer`                     | `bigint`              |                              |                               |
| `PostgreSQL`  | `String`                      | `text`                |                              |                               |
| `PostgreSQL`  | `String`                      | `character`           | `Integer`                    | Alias: `char`                 |
| `PostgreSQL`  | `String`                      | `character varying`   | `Integer`                    | Alias: `varchar`              |
| `PostgreSQL`  | `String`                      | `char`                | `Integer`                    | Alias for `character`         |
| `PostgreSQL`  | `String`                      | `varchar`             | `Integer`                    | Alias for `character varying` |




## [FLOAT](FLOAT.md)

**Syntax:**`FLOAT( expression )`

Converts the `expression` expression to fractional number format according to the following rules:

| Type                                                           | Value                                                                                                                                                                                                             |
|:---------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <code>Fractional number &#124; Integer</code>                  | Original value.                                                                                                                                                                                                   |
| <code>Date &#124; Datetime &#124; Datetime (deprecated)</code> | [Unix time](https://en.wikipedia.org/wiki/Unix_time) corresponding to the date and time. If the value contains time zone data, it's used in the calculation. If the time zone is unknown, the time is set in UTC. |
| `String`                                                       | A number from a decimal string.                                                                                                                                                                                   |
| `Boolean`                                                      | `TRUE` — `1.0`, `FALSE` — `0.0`.                                                                                                                                                                                  |



## [GENERICDATETIME](GENERICDATETIME.md)

**Syntax:**`GENERICDATETIME( expression [ , timezone ] )`

Converts the `expression` expression to date and time format. When converting `Date` to `DateTime`, the time is set to '00:00:00'.
The date must be in the format `YYYY-MM-DDThh:mm:ss` or `YYYY-MM-DD hh:mm:ss`.

The date and time can be converted to the specified time zone when the `timezone` option is available.



## [GENERICDATETIME_PARSE](GENERICDATETIME_PARSE.md)

**Syntax:**`GENERICDATETIME_PARSE( value )`

Converts the `value` expression to date and time format. Unlike [GENERICDATETIME](GENERICDATETIME.md), it supports multiple formats.



## [GEOPOINT](GEOPOINT.md)

**Syntax:**`GEOPOINT( value_1 [ , value_2 ] )`

Generates a Geopoint type value. For the input, it accepts a string, a "geopoint" type value, or coordinates — latitude `value_1` and longitude `value_2`. If a single string is input, it must contain a list of two numbers (latitude and longitude) in JSON syntax.



## [GEOPOLYGON](GEOPOLYGON.md)

**Syntax:**`GEOPOLYGON( value )`

Converts the `value` expression to geopolygon format.



## [INT](INT.md)

**Syntax:**`INT( expression )`

Converts the `expression` expression to integer format according to the following rules:

| Type                                                           | Value                                                                                                                                                                                                             |
|:---------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Integer`                                                      | Original value.                                                                                                                                                                                                   |
| `Fractional number`                                            | Integer part of the number (rounded down).                                                                                                                                                                        |
| <code>Date &#124; Datetime &#124; Datetime (deprecated)</code> | [Unix time](https://en.wikipedia.org/wiki/Unix_time) corresponding to the date and time. If the value contains time zone data, it's used in the calculation. If the time zone is unknown, the time is set in UTC. |
| `String`                                                       | A number from a decimal string.                                                                                                                                                                                   |
| `Boolean`                                                      | `TRUE` — `1`, `FALSE` — `0`.                                                                                                                                                                                      |



## [STR](STR.md)

**Syntax:**`STR( expression )`

Converts the `expression` expression to string type.


