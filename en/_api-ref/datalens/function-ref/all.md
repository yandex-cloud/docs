---
editable: false
---

# All Functions


## [Modulo (%)](OP_MOD.md)

**Syntax:**`number_1 % number_2`

Returns the remainder from dividing the first number `number_1` by the second number `number_2`.



## [Multiplication (*)](OP_MULT.md)

**Syntax:**`value_1 * value_2`

If both arguments are numbers, it returns the result by multiplying `value_1` by `value_2`.

If one of the arguments is `String` and the other is `Number (whole)`, it returns the string repeated the specified number of times.



## [Addition and concatenation (+)](OP_PLUS.md)

**Syntax:**`value_1 + value_2`

Behaves differently depending on the argument types. Possible options are listed in the table:

| Type of `value_1`   | Type of `value_2`   | Return value                                                                                                                                                                     |
|:--------------------|:--------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Number`            | `Number`            | The sum of the numbers `value_1` and `value_2`.                                                                                                                                  |
| `Date`              | `Number`            | The date that is `value_2` days greater than `value_1` (rounded down to an integer number of days).                                                                              |
| `Datetime`          | `Number`            | The date with time, `value_2` days greater than `value_1`. If `value_2` contains a fractional part, it is converted hours (`1/24`), minutes (`1/1440`), and seconds (`1/86400`). |
| `String`            | `String`            | The merging (concatenation) of strings `value_1` and `value_2`.                                                                                                                  |

Changing the order of arguments does not affect the result.



## [Subtraction (-)](OP_MINUS.md)

**Syntax:**`value_1 - value_2`

Behaves differently depending on the argument types. Possible options are listed in the table:

| Type of `value_1`   | Type of `value_2`   | Return value                                                                                                                                                                                                       |
|:--------------------|:--------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Number`            | `Number`            | The difference between the numbers `value_1` and `value_2`.                                                                                                                                                        |
| `Date`              | `Number`            | The date that is `value_2` days smaller than `value_1` (rounded down to an integer number of days).                                                                                                                |
| `Datetime`          | `Number`            | The date with time, `value_2` days smaller than `value_1`. If `value_2` contains a fractional part, it is converted to hours (`1/24`), minutes (`1/1440`), and seconds (`1/86400`).                                |
| `Date`              | `Date`              | The difference between two dates in days.                                                                                                                                                                          |
| `Datetime`          | `Datetime`          | The difference between two dates in days: the integer part — the number of whole days, the fractional part — the number of hours, minutes and seconds expressed as a fraction of the whole day (1 hour is '1/24'). |



## [Division (/)](OP_DIV.md)

**Syntax:**`number_1 / number_2`

Divides the number `number_1` by the number `number_2`.



## [Comparison](OP_COMPARISON.md)

**Syntax:**<br/>`value_1 = value_2`<br/>or<br/>`value_1 != value_2`<br/>or<br/>`value_1 < value_2`<br/>or<br/>`value_1 <= value_2`<br/>or<br/>`value_1 > value_2`<br/>or<br/>`value_1 => value_2`

Compares the value `value_1` with the value `value_2`.



## [Power (^)](OP_POWER.md)

**Syntax:**`base ^ power`

Raises `base` to the power of `power`.



## [CASE](CASE.md)

**Syntax:**<br/>`CASE expression
    WHEN value_1 THEN result_1
    [ WHEN value_2 THEN result_2
      ... ]
    ELSE default_result
END`<br/>or<br/>`CASE(
    expression,
    value_1, result_1,
  [ value_2, result_2,
    ... ]
    default_result
)`

Compares `expression` to `value_1`, `value_2`, ... consecutively and returns the corresponding result for the first match. If no match is found, it returns `default_result`.



## [IF](IF.md)

**Syntax:**<br/>`IF condition_1
    THEN result_1
[ ELSEIF condition_2
    THEN result_2
  ... ]
ELSE
    default_result
END`<br/>or<br/>`IF(
    condition_1, result_1,
  [ condition_2, result_2,
    ... ]
    default_result
)`

Checks conditional expressions `condition_1`, `result_1`, ... and returns the matching result for the first condition found to be `TRUE`. IF all conditional expressions are `FALSE`, it returns `default_result`.



## [ABS](ABS.md)

**Syntax:**`ABS( number )`

Returns the absolute value of `number`.



## [ACOS](ACOS.md)

**Syntax:**`ACOS( number )`

Returns the arccosine of `number` in radians.



## [ALL_CONCAT](ALL_CONCAT.md)

**Syntax:**`ALL_CONCAT( expression [ , separator ] )`

Returns a string that contains all grouped values of `expression` delimited by `separator` (if `separator` is not specified, a comma is used).



## [AND](AND.md)

**Syntax:**`value_1 AND value_2`

Performs a Boolean join of two expressions with the `AND` condition.



## [ANY](ANY.md)

**Syntax:**`ANY( value )`

Returns one of the values of `value` from the group. This is a nondeterministic aggregation — the result may vary for the same data over multiple queries.



## [ARG_MAX](ARG_MAX.md)

**Syntax:**`ARG_MAX( value, comp )`

Returns `value` for the maximum value of `comp` in the group.



## [ARG_MIN](ARG_MIN.md)

**Syntax:**`ARG_MIN( value, comp )`

Returns `value` for the minimum value of `comp` in the group.



## [ASCII](ASCII.md)

**Syntax:**`ASCII( string )`

Returns the numeric representation of the first character of the string.



## [ASIN](ASIN.md)

**Syntax:**`ASIN( number )`

Returns the arcsine of `number` in radians.



## [ATAN](ATAN.md)

**Syntax:**`ATAN( number )`

Returns the arctangent of `number` in radians.



## [ATAN2](ATAN2.md)

**Syntax:**`ATAN2( x, y )`

Returns the arctangent in radians for the specified coordinates `x` and `y`.



## [AVG](AVG.md)

**Syntax:**`AVG( value )`

Returns the average of all values. Applicable to numeric data types as well as `Date | Datetime`.



## [AVG (window)](AVG_WINDOW.md)

**Syntax:**`AVG( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the average of all values. Applicable to numeric data types.



## [AVG_IF](AVG_IF.md)

**Syntax:**`AVG_IF( expression, condition )`

Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.



## [AVG_IF (window)](AVG_IF_WINDOW.md)

**Syntax:**`AVG_IF( expression, condition [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.



## [BETWEEN](BETWEEN.md)

**Syntax:**`value [ NOT ] BETWEEEN low AND high`

Returns `TRUE` if `value` is in the range from `low` to `high`.

The option `value NOT BETWEEEN low AND high` returns the opposite value.



## [BOLD](BOLD.md)

**Syntax:**`BOLD( text )`

Stylizes the passed text in bold font.



## [BOOL](BOOL.md)

**Syntax:**`BOOL( expression )`

Converts the `expression` expression to Boolean type according to the following rules:

| Type                              | `FALSE`             | `TRUE`     |
|:----------------------------------|:--------------------|:-----------|
| `Number`                          | `0`, `0.0`          | All others |
| `String`                          | Empty string (`""`) | All others |
| `Boolean`                         | `FALSE`             | `TRUE`     |
| <code>Date &#124; Datetime</code> | -                   | `TRUE`     |



## [CEILING](CEILING.md)

**Syntax:**`CEILING( number )`

Rounds the value up to the nearest integer.



## [CHAR](CHAR.md)

**Syntax:**`CHAR( string )`

Converts the numeric representation of an ASCII character to a value.



## [CONCAT](CONCAT.md)

**Syntax:**`CONCAT( arg_1, arg_2, arg_3 [ , ... ] )`

Merges any number of strings. When non-string types are used, they're converted to strings and then merged.



## [CONTAINS](CONTAINS.md)

**Syntax:**`CONTAINS( string, substring )`

Returns `TRUE` if `string` contains `substring`. For case-insensitive searches, see [ICONTAINS](ICONTAINS.md).



## [COS](COS.md)

**Syntax:**`COS( number )`

Returns the cosine of `number` in radians.



## [COT](COT.md)

**Syntax:**`COT( number )`

Returns the cotangent of `number` in radians.



## [COUNT](COUNT.md)

**Syntax:**`COUNT(  [ value ] )`

Returns the number of items in the group.



## [COUNT (window)](COUNT_WINDOW.md)

**Syntax:**`COUNT(  [ value ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the number of items in the specified window.



## [COUNT_IF](COUNT_IF.md)

**Syntax:**`COUNT_IF( condition )`

Returns the number of items in the group meeting the `condition` condition.



## [COUNT_IF (window)](COUNT_IF_WINDOW.md)

**Syntax:**`COUNT_IF( expression, condition [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the number of items in the specified window meeting the `expression` condition.



## [COUNTD](COUNTD.md)

**Syntax:**`COUNTD( value )`

Returns the number of unique values in the group.

See also [COUNTD_APPROX](COUNTD_APPROX.md).



## [COUNTD_APPROX](COUNTD_APPROX.md)

**Syntax:**`COUNTD_APPROX( value )`

Returns the approximate number of unique values in the group. Faster than [COUNTD](COUNTD.md), but doesn't guarantee accuracy.



## [COUNTD_IF](COUNTD_IF.md)

**Syntax:**`COUNTD_IF( expression, condition )`

Returns the number of unique values in the group that meet the `condition` condition.

See also [COUNTD_APPROX](COUNTD_APPROX.md).



## [DATE](DATE.md)

**Syntax:**`DATE( expression [ , timezone ] )`

Converts the `expression` expression to date format.

The date must be in the format `YYYY-MM-DD`.

If `expression` is a number, then the `timezone` option can be used to convert the date to the specified time zone.



## [DATE_PARSE](DATE_PARSE.md)

**Syntax:**`DATE_PARSE( value )`

Converts the `value` expression to date format. Unlike [DATE](DATE.md), it supports multiple formats.



## [DATEADD](DATEADD.md)

**Syntax:**`DATEADD( datetime [ , unit [ , number ] ] )`

Returns the date obtained by adding `unit` in the amount of `number` to the specified date `datetime`.

The `number` argument is an integer. It can be negative.
The `unit` argument takes the following values:
- `"year"`,
- `"month"`,
- `"day"`,
- `"hour"`,
- `"minute"`,
- `"second"`.



## [DATEPART](DATEPART.md)

**Syntax:**`DATEPART( datetime, unit [ , firstday ] )`

Returns a part of the date as an integer.

Depending on the argument, `unit` returns the following values:
- `"year"` — the year number (see [YEAR](YEAR.md)),
- `"month"` — the number of the month in the year (see [MONTH](MONTH.md)),
- `"week"` — the number of the week in the year according to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) (see [WEEK](WEEK.md)),
- `"dayofweek"`, `"dow"` — the number of the day of the week (see [DAYOFWEEK](DAYOFWEEK.md)),
`"day"` — the number of the day in the month (see [DAY](DAY.md)),
- `"hour"` — the number of the hour in the day (see [HOUR](HOUR.md)),
- `"minute"` — the number of the minute in the hour (see [MINUTE](MINUTE.md)),
- `"second"` — the number of the second in the minute (see [SECOND](SECOND.md)).

If you select `"dayofweek"`, you can use the additional parameter `firstday` to specify the first day of the week (Monday by default). Learn more about this parameter in the [DAYOFWEEK](DAYOFWEEK.md) function description.




## [DATETIME](DATETIME.md)

**Syntax:**`DATETIME( expression [ , timezone ] )`

Converts the `expression` expression to date and time format. When converting `Date` to `DateTime`, the time is set to '00:00:00'.
The date must be in the format `YYYY-MM-DDThh:mm:ss` or `YYYY-MM-DD hh:mm:ss`.

If `expression` is a number, then the date and time can be converted to the specified time zone when the `timezone` option is available.



## [DATETIME_PARSE](DATETIME_PARSE.md)

**Syntax:**`DATETIME_PARSE( value )`

Converts the `value` expression to date and time format. Unlike [DATETIME](DATETIME.md), it supports multiple formats.



## [DATETRUNC](DATETRUNC.md)

**Syntax:**`DATETRUNC( datetime, unit [ , number ] )`

Rounds `datetime` down to the given `unit`. If optional `number` is given, then the value is rounded down to a `number` multiple of `unit` (omitting `number` is the same as `number = 1`).

Supported units:
- `"second"`,
- `"minute"`,
- `"hour"`,
- `"day"` (acts as the day of the year if `number` is specified),
- `"week"`,
- `"month"`,
- `"year"`.



## [DAY](DAY.md)

**Syntax:**`DAY( datetime )`

Returns the number of the day in the month of the specified date `datetime`.



## [DAYOFWEEK](DAYOFWEEK.md)

**Syntax:**`DAYOFWEEK( datetime [ , firstday ] )`

Returns the day of the week according to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601).
- Monday — 1.
- Sunday — 7.

If the additional parameter `firstday` is specified, this day is considered the first day of the week. Valid values:
- `"Monday"`, `"Mon"` — Monday;
- `"Tuesday"`. `"Tue"` — Tuesday;
- `"Wednesday"`, `"Wed"` — Wednesday;
- `"Thursday"`, `"Thu"` — Thursday;
- `"Friday"`, `"Fri"` — Friday;
- `"Saturday"`, ` "Sat"` — Saturday;
- `"Sunday"`, `"Sun"` — Sunday.




## [DB_CAST](DB_CAST.md)

**Syntax:**`DB_CAST( expression, native_type [ , param_1 [ , param_2 ] ] )`

Converts the `expression` expression to database's native type `native_type`.

The following type casts are supported:

| Data source   | Data type          | Native data type    | Parameters for native type         | Comment                       |
|:--------------|:-------------------|:--------------------|:-----------------------------------|:------------------------------|
| `ClickHouse`  | `Number (decimal)` | `Float32`           |                                    |                               |
| `ClickHouse`  | `Number (decimal)` | `Float64`           |                                    |                               |
| `ClickHouse`  | `Number (decimal)` | `Decimal`           | `Number (whole)`, `Number (whole)` |                               |
| `ClickHouse`  | `Number (whole)`   | `Int8`              |                                    |                               |
| `ClickHouse`  | `Number (whole)`   | `Int16`             |                                    |                               |
| `ClickHouse`  | `Number (whole)`   | `Int32`             |                                    |                               |
| `ClickHouse`  | `Number (whole)`   | `Int64`             |                                    |                               |
| `ClickHouse`  | `String`           | `String`            |                                    |                               |
| `PostgreSQL`  | `Number (decimal)` | `double precision`  |                                    |                               |
| `PostgreSQL`  | `Number (decimal)` | `real`              |                                    |                               |
| `PostgreSQL`  | `Number (decimal)` | `numeric`           | `Number (whole)`, `Number (whole)` |                               |
| `PostgreSQL`  | `Number (whole)`   | `smallint`          |                                    |                               |
| `PostgreSQL`  | `Number (whole)`   | `integer`           |                                    |                               |
| `PostgreSQL`  | `Number (whole)`   | `bigint`            |                                    |                               |
| `PostgreSQL`  | `String`           | `text`              |                                    |                               |
| `PostgreSQL`  | `String`           | `character`         | `Number (whole)`                   | Alias: `char`                 |
| `PostgreSQL`  | `String`           | `character varying` | `Number (whole)`                   | Alias: `varchar`              |
| `PostgreSQL`  | `String`           | `char`              | `Number (whole)`                   | Alias for `character`         |
| `PostgreSQL`  | `String`           | `varchar`           | `Number (whole)`                   | Alias for `character varying` |




## [DEGREES](DEGREES.md)

**Syntax:**`DEGREES( radians )`

Converts radians to degrees.



## [DIV](DIV.md)

**Syntax:**`DIV( number_1, number_2 )`

Divides `number_1` by `number_1`. The result is rounded down to the nearest integer.



## [ENDSWITH](ENDSWITH.md)

**Syntax:**`ENDSWITH( string, substring )`

Returns `TRUE` if `string` ends in `substring`. For case-insensitive searches, see [IENDSWITH](IENDSWITH.md).



## [EXP](EXP.md)

**Syntax:**`EXP( number )`

Returns the result of raising the number 'e' to the power of `number`.



## [FIND](FIND.md)

**Syntax:**`FIND( string, substring [ , start_index ] )`

Returns the index of the position of the first character of the substring `substring` in the string `string`.

If the `start_index` option is specified, the search starts from the specified position.



## [FLOAT](FLOAT.md)

**Syntax:**`FLOAT( expression )`

Converts the `expression` expression to fractional number format according to the following rules:

| Type                              | Value                                                                                                                                                                                                             |
|:----------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Number`                          | Original value.                                                                                                                                                                                                   |
| <code>Date &#124; Datetime</code> | [Unix time](https://en.wikipedia.org/wiki/Unix_time) corresponding to the date and time. If the value contains time zone data, it's used in the calculation. If the time zone is unknown, the time is set in UTC. |
| `String`                          | A number from a decimal string.                                                                                                                                                                                   |
| `Boolean`                         | `TRUE` — `1.0`, `FALSE` — `0.0`.                                                                                                                                                                                  |



## [FLOOR](FLOOR.md)

**Syntax:**`FLOOR( number )`

Rounds the value down to the nearest integer.



## [GEOCODE](GEOCODE.md)

**Syntax:**`GEOCODE( address )`

Converts `address` to its geographical coordinates.

{{ datalens-short-name }} caches the function result. When the function is invoked again, {{ datalens-short-name }} doesn't perform geocoding. The cache lifetime is 30 days.After 30 days, {{ datalens-short-name }} automatically invokes `GEOCODE` to convert addresses in the dataset.



## [GEOINFO](GEOINFO.md)

**Syntax:**`GEOINFO( address, scale )`

Converts `address` to geographical name corresponding to the specified `scale`.

Possible values for `scale` parameter:
- `"country"`,
- `"country_code"`,
- `"region"`,
- `"locality"`.



## [GEOPOINT](GEOPOINT.md)

**Syntax:**`GEOPOINT( value_1 [ , value_2 ] )`

Generates a Geopoint type value. For the input, it accepts a string, a "geopoint" type value, or coordinates — latitude `value_1` and longitude `value_2`. If a single string is input, it must contain a list of two numbers (latitude and longitude) in JSON syntax.



## [GEOPOLYGON](GEOPOLYGON.md)

**Syntax:**`GEOPOLYGON( value )`

Converts the `value` expression to geopolygon format.



## [GREATEST](GREATEST.md)

**Syntax:**`GREATEST( value_1, value_2, value_3 [ , ... ] )`

Returns the greatest value.

See also [LEAST](LEAST.md).

Depending on the specified data type, it returns:
- The greatest number.
- The last string in alphabetical order.
- The latest date.
- `TRUE` when selecting between `TRUE` and `FALSE` for Boolean type.



## [HOUR](HOUR.md)

**Syntax:**`HOUR( datetime )`

Returns the number of the hour in the day of the specified date and time `datetime`. When the date is specified without time, it returns `0`.



## [ICONTAINS](ICONTAINS.md)

**Syntax:**`ICONTAINS( string, substring )`

Case-insensitive version of [CONTAINS](CONTAINS.md). Returns `TRUE` if `string` contains `substring`.



## [IENDSWITH](IENDSWITH.md)

**Syntax:**`IENDSWITH( string, substring )`

Case-insensitive version of [ENDSWITH](ENDSWITH.md). Returns `TRUE` if `string` ends in `substring`.



## [IFNULL](IFNULL.md)

**Syntax:**`IFNULL( check_value, alt_value )`

Returns `check_value` if it's not `NULL`. Otherwise returns `alt_value`.



## [IN](IN.md)

**Syntax:**`item [ NOT ] IN (<list>)`

Checks whether the value matches at least one of the values listed in `IN(...)`.

The option `item NOT IN (<`list`>)` returns the opposite value.



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



## [IS FALSE](ISFALSE.md)

**Syntax:**`value IS [ NOT ] FALSE`

Checks whether the `value` value is false (`FALSE`).

The `value IS NOT FALSE` option returns the opposite value.



## [ISNULL](ISNULL.md)

**Syntax:**<br/>`ISNULL( expression )`<br/>or<br/>`expression IS [ NOT ] NULL`

Returns `TRUE` if `expression` is `NULL`, otherwise returns `FALSE`.

`expression IS NOT NULL` returns the opposite result.



## [ISTARTSWITH](ISTARTSWITH.md)

**Syntax:**`ISTARTSWITH( string, substring )`

Case-insensitive version of [STARTSWITH](STARTSWITH.md). Returns `TRUE`  if `string` starts with `substring`.



## [IS TRUE](ISTRUE.md)

**Syntax:**`value IS [ NOT ] TRUE`

Checks whether the value of `value` is true (`TRUE`).

The `value IS NOT TRUE` option returns the opposite value.



## [ITALIC](ITALIC.md)

**Syntax:**`ITALIC( text )`

Stylizes the passed text in cursive font.



## [LEAST](LEAST.md)

**Syntax:**`LEAST( value_1, value_2, value_3 [ , ... ] )`

Returns the smallest value.

See also [GREATEST](GREATEST.md).

Depending on the specified data type, it returns:
- The smallest number.
- The first string in alphabetical order.
- The earliest date.
- `FALSE` when selecting between `TRUE` and `FALSE` for Boolean type.



## [LEFT](LEFT.md)

**Syntax:**`LEFT( string, number )`

Returns a string that contains the number of characters specified in `number` from the beginning of the string `string`.



## [LEN](LEN.md)

**Syntax:**`LEN( string )`

Returns the number of characters in the string `string`.



## [LIKE](LIKE.md)

**Syntax:**`string_1 [ NOT ] LIKE string_2`

Matches the string `string_1` to the template `string_2` and returns `TRUE` on match.
You can specify the value in `string_2` or use the `%` character to match a string of any length.

The `string_1 NOT LIKE` option returns the opposite value.



## [LN](LN.md)

**Syntax:**`LN( number )`

Returns the natural logarithm of the number `number`. Returns 'NULL' if the number is less than or equal to 0.



## [LOG](LOG.md)

**Syntax:**`LOG( value, base )`

Returns the logarithm of `value` to base `base`. Returns 'NULL' if the number `value` is less than or equal to 0.



## [LOG10](LOG10.md)

**Syntax:**`LOG10( number )`

Returns the logarithm of the number `number` to base 10. Returns 'NULL' if the number is less than or equal to 0.



## [LOWER](LOWER.md)

**Syntax:**`LOWER( string )`

Returns the string `string` in lowercase.



## [LTRIM](LTRIM.md)

**Syntax:**`LTRIM( string )`

Returns the string `string` without spaces at the beginning of the string.



## [MARKUP](MARKUP.md)

**Syntax:**`MARKUP( arg_1, arg_2, arg_3 [ , ... ] )`

Merges marked up text pieces. Can also be used for converting strings to marked up text.



## [MAVG (window)](MAVG.md)

**Syntax:**`MAVG( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the moving average of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md).

See also [AVG](AVG.md), [RAVG](RAVG.md).



## [MAX](MAX.md)

**Syntax:**`MAX( value )`

Returns the maximum value.

If `value`:
- number — Returns the largest number.
- date — Returns the latest date.
- string — Returns the last value in the alphabetic order.




## [MAX (window)](MAX_WINDOW.md)

**Syntax:**`MAX( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the maximum value.

If `value`:
- number — Returns the largest number.
- date — Returns the latest date.
- string — Returns the last value in the alphabetic order.




## [MCOUNT (window)](MCOUNT.md)

**Syntax:**`MCOUNT( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the moving count of (non-`NULL`) values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [COUNT](COUNT.md), [RCOUNT](RCOUNT.md).



## [MEDIAN](MEDIAN.md)

**Syntax:**`MEDIAN( value )`

Returns the median value.



## [MIN](MIN.md)

**Syntax:**`MIN( value )`

Returns the minimum value.

If `value`:
- number — Returns the smallest number.
- date — Returns the earliest date.
- string — Returns the first value in the alphabetic order.




## [MIN (window)](MIN_WINDOW.md)

**Syntax:**`MIN( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the minimum value.

If `value`:
- number — Returns the smallest number.
- date — Returns the earliest date.
- string — Returns the first value in the alphabetic order.




## [MINUTE](MINUTE.md)

**Syntax:**`MINUTE( datetime )`

Returns the number of the minute in the hour of the specified date `datetime`. When the date is specified without time, it returns `0`.



## [MMAX (window)](MMAX.md)

**Syntax:**`MMAX( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the moving maximum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MAVG](MAVG.md).

See also [MAX](MAX.md), [RMAX](RMAX.md).



## [MMIN (window)](MMIN.md)

**Syntax:**`MMIN( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the moving minimum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [MIN](MIN.md), [RMIN](RMIN.md).



## [MONTH](MONTH.md)

**Syntax:**`MONTH( datetime )`

Returns the number of the month in the year of the specified date `datetime`.



## [MSUM (window)](MSUM.md)

**Syntax:**`MSUM( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the moving sum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [SUM](SUM.md), [RSUM](RSUM.md).



## [Negation (-)](OP_NEGATION.md)

**Syntax:**`-value`

Returns the number `value` with the opposite sign.



## [NOT](OP_NOT.md)

**Syntax:**`NOT value`

Inverts a Boolean value.



## [NOW](NOW.md)

**Syntax:**`NOW()`

Returns the current date and time, depending on the data source and connection type:
- For a direct connection, the function returns the server date and time of the source.
- On materialization, the function returns the UTC+3 date and time.




## [OR](OR.md)

**Syntax:**`value_1 OR value_2`

Performs a Boolean join of two expressions with the `OR` condition.



## [PI](PI.md)

**Syntax:**`PI()`

Returns PI. The accuracy depends on the data source.



## [POWER](POWER.md)

**Syntax:**`POWER( base, power )`

Raises `base` to the power of `power`.



## [QUANTILE](QUANTILE.md)

**Syntax:**`QUANTILE( value, quant )`

Returns the precise `quant`-level quantile (`quant` should be in range from 0 to 1).



## [QUANTILE_APPROX](QUANTILE_APPROX.md)

**Syntax:**`QUANTILE_APPROX( value, quant )`

Returns the approximate `quant`-level quantile (`quant` should be in range from 0 to 1).



## [RADIANS](RADIANS.md)

**Syntax:**`RADIANS( degrees )`

Converts `degrees` degrees to radians.



## [RANK (window)](RANK.md)

**Syntax:**`RANK( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value used for sorting have the same rank. If the first two rows both have rank of `1`, then the next row (if it features a different value) will have rank `3`, so, in effect, it is rank with gaps.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RANK_DENSE (window)](RANK_DENSE.md)

**Syntax:**`RANK_DENSE( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value used for sorting have the same rank. If the first two rows both have rank of `1`, then the next row (if it features a different value) will have rank `2`, (rank without gaps).

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RANK_PERCENTILE (window)](RANK_PERCENTILE.md)

**Syntax:**`RANK_PERCENTILE( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the relative rank (from `0` to `1`) of the current row if ordered by the given argument. Calculated as `(RANK(...) - 1) / (row count) `.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md).



## [RANK_UNIQUE (window)](RANK_UNIQUE.md)

**Syntax:**`RANK_UNIQUE( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value have different rank values. This means that rank values are sequential and different for all rows, always increasing by `1` for the next row.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RAVG (window)](RAVG.md)

**Syntax:**`RAVG( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the average of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md).

See also [AVG](AVG.md), [MAVG](MAVG.md).



## [RCOUNT (window)](RCOUNT.md)

**Syntax:**`RCOUNT( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the count of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RMIN](RMIN.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

See also [COUNT](COUNT.md), [MCOUNT](MCOUNT.md).



## [REGEXP_EXTRACT](REGEXP_EXTRACT.md)

**Syntax:**`REGEXP_EXTRACT( string, pattern )`

Returns the substring `string` that matches the regular expression pattern `pattern`.



## [REGEXP_EXTRACT_NTH](REGEXP_EXTRACT_NTH.md)

**Syntax:**`REGEXP_EXTRACT_NTH( string, pattern, match_index )`

Returns a substring `string` that matches the regular expression pattern `pattern` starting from the specified index.



## [REGEXP_MATCH](REGEXP_MATCH.md)

**Syntax:**`REGEXP_MATCH( string, pattern )`

Returns 'TRUE' if the string `string` has a substring that matches the regular expression pattern `pattern`.



## [REGEXP_REPLACE](REGEXP_REPLACE.md)

**Syntax:**`REGEXP_REPLACE( string, pattern, replace_with )`

Searches for a substring in the string `string` using the regular expression pattern `pattern` and replaces it with the string `replace_with`.

If the substring is not found, the string is not changed.



## [REPLACE](REPLACE.md)

**Syntax:**`REPLACE( string, substring, replace_with )`

Searches for the substring `substring` in the string `string` and replaces it with the string `replace_with`.

If the substring is not found, the string is not changed.



## [RIGHT](RIGHT.md)

**Syntax:**`RIGHT( string, number )`

Returns a string that contains the number of characters specified in `number` from the end of the string `string`.



## [RMAX (window)](RMAX.md)

**Syntax:**`RMAX( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the maximum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RAVG](RAVG.md).

See also [MAX](MAX.md), [MMAX](MMAX.md).



## [RMIN (window)](RMIN.md)

**Syntax:**`RMIN( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the minimum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

See also [MIN](MIN.md), [MMIN](MMIN.md).



## [ROUND](ROUND.md)

**Syntax:**`ROUND( number [ , precision ] )`

Rounds the number `number` to the number of decimal digits specified in `precision`.
If the number `precision` is omitted, `number` is rounded to the nearest integer.



## [RSUM (window)](RSUM.md)

**Syntax:**`RSUM( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the sum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

See also [SUM](SUM.md), [MSUM](MSUM.md).



## [RTRIM](RTRIM.md)

**Syntax:**`RTRIM( string )`

Returns the string `string` without spaces at the end of the string.



## [SECOND](SECOND.md)

**Syntax:**`SECOND( datetime )`

Returns the number of the second in the minute of the specified date `datetime`. When the date is specified without time, it returns `0`.



## [SIGN](SIGN.md)

**Syntax:**`SIGN( number )`

Returns the sign of the number `number`:
- `-1` if the number is negative.
`0` if the number is zero.
- `1` if the number is positive.



## [SIN](SIN.md)

**Syntax:**`SIN( number )`

Returns the sine of `number` in radians.



## [SPACE](SPACE.md)

**Syntax:**`SPACE( value )`

Returns a string with the specified number of spaces.



## [SPLIT](SPLIT.md)

**Syntax:**`SPLIT( orig_string, delimiter, part_index )`

Returns a substring from `orig_string` using the `delimiter` delimiter character to divide the string into a sequence of `part_index` parts.



## [SQRT](SQRT.md)

**Syntax:**`SQRT( number )`

Returns the square root of the specified number.



## [SQUARE](SQUARE.md)

**Syntax:**`SQUARE( number )`

Returns the number `number` raised to the power of 2.



## [STARTSWITH](STARTSWITH.md)

**Syntax:**`STARTSWITH( string, substring )`

Returns `TRUE` if `string` starts with `substring`. For case-insensitive searches, see [ISTARTSWITH](ISTARTSWITH.md).



## [STDEV](STDEV.md)

**Syntax:**`STDEV( value )`

Returns the statistical standard deviation of all values in the expression based on a selection from the population.



## [STDEVP](STDEVP.md)

**Syntax:**`STDEVP( value )`

Returns the statistical standard deviation of all values in the expression based on the biased population.



## [STR](STR.md)

**Syntax:**`STR( expression )`

Converts the `expression` expression to string type.



## [SUBSTR](SUBSTR.md)

**Syntax:**`SUBSTR( string, from_index [ , length ] )`

Returns the substring `string` starting from the index `from_index`.

If an additional argument `length` is specified, a substring of the specified length is returned.



## [SUM](SUM.md)

**Syntax:**`SUM( value )`

Returns the sum of all expression values. Applicable to numeric data types only.



## [SUM (window)](SUM_WINDOW.md)

**Syntax:**`SUM( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the sum of all expression values. Applicable to numeric data types only.



## [SUM_IF](SUM_IF.md)

**Syntax:**`SUM_IF( expression, condition )`

Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.



## [SUM_IF (window)](SUM_IF_WINDOW.md)

**Syntax:**`SUM_IF( expression, condition [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.



## [TAN](TAN.md)

**Syntax:**`TAN( number )`

Returns the tangent of `number` in radians.



## [TODAY](TODAY.md)

**Syntax:**`TODAY()`

Returns the current date, depending on the data source and connection type:
- For a direct connection, the function returns the server date and time of the source.
- On materialization, the function returns the UTC+3 date and time.




## [TOP_CONCAT](TOP_CONCAT.md)

**Syntax:**`TOP_CONCAT( expression, amount [ , separator ] )`

Returns a string that contains top `amount` grouped values of `expression` delimited by `separator` (if `separator` is not specified, a comma is used).



## [TOPONYM_TO_GEOPOINT](TOPONYM_TO_GEOPOINT.md)

**Syntax:**`TOPONYM_TO_GEOPOINT( name )`

Converts the name of a geographical entity (country, region, city) `name` to the `Geopoint` type.



## [TOPONYM_TO_GEOPOLYGON](TOPONYM_TO_GEOPOLYGON.md)

**Syntax:**`TOPONYM_TO_GEOPOLYGON( name )`

Converts the name of a geographical entity (country, region, city) `name` to the `Geopolygon` type.



## [TRIM](TRIM.md)

**Syntax:**`TRIM( string )`

Returns the string `string` without spaces at the beginning or end of the string.



## [UPPER](UPPER.md)

**Syntax:**`UPPER( string )`

Returns the string `string` in uppercase.



## [URL](URL.md)

**Syntax:**`URL( address, text )`

Wraps `text` into a hyperlink to URL `address`.



## [UTF8](UTF8.md)

**Syntax:**`UTF8( string, old_encoding )`

Converts the `string` string encoding to `UTF8`.



## [VAR](VAR.md)

**Syntax:**`VAR( value )`

Returns the statistical variance of all values in an expression based on a selection from the population.



## [VARP](VARP.md)

**Syntax:**`VARP( value )`

Returns the statistical variance of all values in an expression across the entire population.



## [WEEK](WEEK.md)

**Syntax:**`WEEK( value )`

The number of the week according to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601). The first week is the week that contains the first Thursday of the year or January 4th.



## [YEAR](YEAR.md)

**Syntax:**`YEAR( datetime )`

Returns the year number in the specified date `datetime`.



## [ZN](ZN.md)

**Syntax:**`ZN( expression )`

Returns `expression` if it's not `NULL`. Otherwise returns 0.


