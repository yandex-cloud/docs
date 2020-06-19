---
editable: false
---

# Type conversion functions


## [BOOL](BOOL.md)

**Syntax:**`BOOL( expression )`

Converts the `expression` expression to Boolean type according to the following rules:

| Type                              | `FALSE`             | `TRUE`     |
|:----------------------------------|:--------------------|:-----------|
| `Number`                          | `0`, `0.0`          | All others |
| `String`                          | Empty string (`""`) | All others |
| `Boolean`                         | `FALSE`             | `TRUE`     |
| <code>Date &#124; Datetime</code> | -                   | `TRUE`     |



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



## [FLOAT](FLOAT.md)

**Syntax:**`FLOAT( expression )`

Converts the `expression` expression to fractional number format according to the following rules:

| Type                              | Value                                                                                                                                                                                                             |
|:----------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Number`                          | Original value.                                                                                                                                                                                                   |
| <code>Date &#124; Datetime</code> | [Unix time](https://en.wikipedia.org/wiki/Unix_time) corresponding to the date and time. If the value contains time zone data, it's used in the calculation. If the time zone is unknown, the time is set in UTC. |
| `String`                          | A number from a decimal string.                                                                                                                                                                                   |
| `Boolean`                         | `TRUE` — `1.0`, `FALSE` — `0.0`.                                                                                                                                                                                  |



## [GEOPOINT](GEOPOINT.md)

**Syntax:**`GEOPOINT( value_1 [ , value_2 ] )`

Generates a Geopoint type value. For the input, it accepts a string, a "geopoint" type value, or coordinates — latitude `value_1` and longitude `value_2`. If a single string is input, it must contain a list of two numbers (latitude and longitude) in JSON syntax.



## [GEOPOLYGON](GEOPOLYGON.md)

**Syntax:**`GEOPOLYGON( value )`

Converts the `value` expression to geopolygon format.



## [INT](INT.md)

**Syntax:**`INT( expression )`

Converts the `expression` expression to integer format according to the following rules:

| Type                              | Value                                                                                                                                                                                                             |
|:----------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Number (whole)`                  | Original value.                                                                                                                                                                                                   |
| `Number (decimal)`                | Integer part of the number (rounded down).                                                                                                                                                                        |
| <code>Date &#124; Datetime</code> | [Unix time](https://en.wikipedia.org/wiki/Unix_time) corresponding to the date and time. If the value contains time zone data, it's used in the calculation. If the time zone is unknown, the time is set in UTC. |
| `String`                          | A number from a decimal string.                                                                                                                                                                                   |
| `Boolean`                         | `TRUE` — `1`, `FALSE` — `0`.                                                                                                                                                                                      |



## [STR](STR.md)

**Syntax:**`STR( expression )`

Converts the `expression` expression to string type.


