---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/all.md
---

# All Functions


## [Modulo (%)](OP_MOD.md)

**Syntax:**`number_1 % number_2`

Returns the remainder from dividing the first number `number_1` by the second number `number_2`.



## [Multiplication (*)](OP_MULT.md)

**Syntax:**`value_1 * value_2`

If both arguments are numbers, it returns the result by multiplying `value_1` by `value_2`.

If one of the arguments is `String` and the other is `Integer`, it returns the string repeated the specified number of times.



## [Addition and concatenation (+)](OP_PLUS.md)

**Syntax:**`value_1 + value_2`

Behaves differently depending on the argument types. Possible options are listed in the table:

| Type of `value_1`                                                                         | Type of `value_2`                                                                         | Return value                                                                                                                                                                     |
|:------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <code>Fractional number &#124; Integer</code>                                             | <code>Fractional number &#124; Integer</code>                                             | The sum of the numbers `value_1` and `value_2`.                                                                                                                                  |
| `Date`                                                                                    | <code>Fractional number &#124; Integer</code>                                             | The date that is `value_2` days greater than `value_1` (rounded down to an integer number of days).                                                                              |
| `Datetime`                                                                                | <code>Fractional number &#124; Integer</code>                                             | The date with time, `value_2` days greater than `value_1`. If `value_2` contains a fractional part, it is converted hours (`1/24`), minutes (`1/1440`), and seconds (`1/86400`). |
| `String`                                                                                  | `String`                                                                                  | The merging (concatenation) of strings `value_1` and `value_2`.                                                                                                                  |
| <code>Array of fractional numbers &#124; Array of integers &#124; Array of strings</code> | <code>Array of fractional numbers &#124; Array of integers &#124; Array of strings</code> | The merging (concatenation) of arrays `value_1` and `value_2`.                                                                                                                   |

Changing the order of arguments does not affect the result.



## [Subtraction (-)](OP_MINUS.md)

**Syntax:**`value_1 - value_2`

Behaves differently depending on the argument types. Possible options are listed in the table:

| Type of `value_1`                             | Type of `value_2`                             | Return value                                                                                                                                                                                                       |
|:----------------------------------------------|:----------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <code>Fractional number &#124; Integer</code> | <code>Fractional number &#124; Integer</code> | The difference between the numbers `value_1` and `value_2`.                                                                                                                                                        |
| `Date`                                        | <code>Fractional number &#124; Integer</code> | The date that is `value_2` days smaller than `value_1` (rounded down to an integer number of days).                                                                                                                |
| `Datetime`                                    | <code>Fractional number &#124; Integer</code> | The date with time, `value_2` days smaller than `value_1`. If `value_2` contains a fractional part, it is converted to hours (`1/24`), minutes (`1/1440`), and seconds (`1/86400`).                                |
| `Date`                                        | `Date`                                        | The difference between two dates in days.                                                                                                                                                                          |
| `Any`                                         | `Any`                                         | The difference between two dates in days: the integer part — the number of whole days, the fractional part — the number of hours, minutes and seconds expressed as a fraction of the whole day (1 hour is '1/24'). |
| `Datetime`                                    | `Datetime`                                    | The difference between two dates in days: the integer part — the number of whole days, the fractional part — the number of hours, minutes and seconds expressed as a fraction of the whole day (1 hour is '1/24'). |



## [Division (/)](OP_DIV.md)

**Syntax:**`number_1 / number_2`

Divides the number `number_1` by the number `number_2`.



## [Comparison](OP_COMPARISON.md)

**Syntax:**<br/>`value_1 = value_2`<br/>or<br/>`value_1 != value_2`<br/>or<br/>`value_1 < value_2`<br/>or<br/>`value_1 <= value_2`<br/>or<br/>`value_1 > value_2`<br/>or<br/>`value_1 >= value_2`

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

Checks conditional expressions `condition_1`, `result_1`, ... and returns the matching result for the first condition found to be `TRUE`. IF all conditional expressions are `FALSE`, it returns `default_result`. The expressions to be checked are set using logical operators.



## [ABS](ABS.md)

**Syntax:**`ABS( number )`

Returns the absolute value of `number`.



## [ACOS](ACOS.md)

**Syntax:**`ACOS( number )`

Returns the arccosine of `number` in radians.



## [AGO](AGO.md)

**Syntax:**<br/>`AGO( measure, date_dimension [ , unit [ , number ] ] )`<br/>or<br/>`AGO( measure, date_dimension [ , unit [ , number ] ]
     [ BEFORE FILTER BY ... ]
     [ IGNORE DIMENSIONS ... ]
   )`

Re-evaluate `measure` for a date/time with a given offset.
The `date_dimension` argument is the dimension along which the offset is made.
The `number` argument sets the offset in units of the `unit` argument. Set as an integer. It may take negative values. The default value is `1`.
The `unit` argument sets the unit for `number`. It may take the following values:
- `"year"`;
- `"month"`;
- `"week"`;
- `"day"` (default value);
- `"hour"`;
- `"minute"`;
- `"second"`.

Can also be used as `AGO( measure, date_dimension, number )`. In this case, the `unit` argument takes the `"day"` value.

See also [AT_DATE](AT_DATE.md), [LAG](LAG.md).



## [ALL_CONCAT](ALL_CONCAT.md)

**Syntax:**<br/>`ALL_CONCAT( expression [ , separator ] )`<br/>or<br/>`ALL_CONCAT( expression [ , separator ]
            [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
            [ BEFORE FILTER BY ... ]
          )`

Returns a string that contains all unique values of `expression` delimited by `separator` (if `separator` is not specified, a comma is used).



## [AND](AND.md)

**Syntax:**`value_1 AND value_2`

Performs a Boolean join of two expressions with the `AND` condition.



## [ANY](ANY.md)

**Syntax:**<br/>`ANY( value )`<br/>or<br/>`ANY( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns one of the values of `value` from the group. This is a nondeterministic aggregation — the result may vary for the same data over multiple queries.



## [ARG_MAX](ARG_MAX.md)

**Syntax:**<br/>`ARG_MAX( value, expression_to_maximize )`<br/>or<br/>`ARG_MAX( value, expression_to_maximize
         [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
         [ BEFORE FILTER BY ... ]
       )`

Returns `value` for the maximum value of `expression_to_maximize` in the group. If multiple values of `value` match the maximum value of `expression_to_maximize`, then the first one encountered is returned. This makes the function non-deterministic.



## [ARG_MIN](ARG_MIN.md)

**Syntax:**<br/>`ARG_MIN( value, expression_to_minimize )`<br/>or<br/>`ARG_MIN( value, expression_to_minimize
         [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
         [ BEFORE FILTER BY ... ]
       )`

Returns `value` for the minimum value of `expression_to_minimize` in the group. If multiple values of `value` match the minimum value of `expression_to_minimize`, then the first one encountered is returned. This makes the function non-deterministic.



## [ARR_AVG](ARR_AVG.md)

**Syntax:**`ARR_AVG( array )`

Returns the average of elements in the `array`.



## [ARR_MAX](ARR_MAX.md)

**Syntax:**`ARR_MAX( array )`

Returns the greatest of elements in the `array`.



## [ARR_MIN](ARR_MIN.md)

**Syntax:**`ARR_MIN( array )`

Returns the least of elements in the `array`.



## [ARR_PRODUCT](ARR_PRODUCT.md)

**Syntax:**`ARR_PRODUCT( array )`

Returns the product of elements in the `array`.



## [ARR_REMOVE](ARR_REMOVE.md)

**Syntax:**`ARR_REMOVE( array, value )`

Removes all `array` elements equal to `value`.



## [ARR_STR](ARR_STR.md)

**Syntax:**`ARR_STR( array [ , delimiter [ , null_str ] ] )`

Concatenates elements of the array `array` using `delimiter` as a delimiter (comma by default) and `null_str` as a `NULL` string (`NULL` items are skipped by default).

See also [STR](STR.md)



## [ARR_SUM](ARR_SUM.md)

**Syntax:**`ARR_SUM( array )`

Returns the sum of elements in the `array`.



## [ARRAY](ARRAY.md)

**Syntax:**`ARRAY( value_1, value_2, value_3 [ , ... ] )`

Returns an array containing the passed values.



## [ASCII](ASCII.md)

**Syntax:**`ASCII( string )`

Returns the numeric representation of the first character of the string.



## [ASIN](ASIN.md)

**Syntax:**`ASIN( number )`

Returns the arcsine of `number` in radians.



## [AT_DATE](AT_DATE.md)

**Syntax:**<br/>`AT_DATE( measure, date_dimension, date_expr )`<br/>or<br/>`AT_DATE( measure, date_dimension, date_expr
         [ BEFORE FILTER BY ... ]
         [ IGNORE DIMENSIONS ... ]
       )`

Re-evaluate `measure` for a date/time specified by `date_expr`. It allows to get the measure at the beginning and at the end of a period, or for the specified date.
The `date_dimension` argument is the dimension along which the offset is made.

You can use the following as the `date_expr` argument:

* Certain date.
* Function [TODAY](TODAY.md) to obtain the current date.
* Functions to calculate date and time.

See also [AGO](AGO.md), [LAG](LAG.md).



## [ATAN](ATAN.md)

**Syntax:**`ATAN( number )`

Returns the arctangent of `number` in radians.



## [ATAN2](ATAN2.md)

**Syntax:**`ATAN2( x, y )`

Returns the arctangent in radians for the specified coordinates `x` and `y`.



## [AVG](AVG.md)

**Syntax:**<br/>`AVG( value )`<br/>or<br/>`AVG( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns the average of all values. Applicable to numeric data types as well as `Date`.



## [AVG (window)](AVG_WINDOW.md)

**Syntax:**<br/>`AVG( value
     TOTAL | WITHIN ... | AMONG ...
   )`<br/>or<br/>`AVG( value
     TOTAL | WITHIN ... | AMONG ...
     [ BEFORE FILTER BY ... ]
   )`

Returns the average of all values. Applicable to numeric data types.



## [AVG_IF](AVG_IF.md)

**Syntax:**<br/>`AVG_IF( expression, condition )`<br/>or<br/>`AVG_IF( expression, condition
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.



## [AVG_IF (window)](AVG_IF_WINDOW.md)

**Syntax:**<br/>`AVG_IF( expression, condition
        TOTAL | WITHIN ... | AMONG ...
      )`<br/>or<br/>`AVG_IF( expression, condition
        TOTAL | WITHIN ... | AMONG ...
        [ BEFORE FILTER BY ... ]
      )`

Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.



## [BETWEEN](BETWEEN.md)

**Syntax:**`value [ NOT ] BETWEEN low AND high`

Returns `TRUE` if `value` is in the range from `low` to `high` inclusive.

The option `value NOT BETWEEN low AND high` returns the opposite value.



## [BOLD](BOLD.md)

**Syntax:**`BOLD( text )`

Stylizes the passed text in bold font.



## [BOOL](BOOL.md)

**Syntax:**`BOOL( expression )`

Converts the `expression` expression to Boolean type according to the following rules:

| Type                                          | `FALSE`             | `TRUE`     |
|:----------------------------------------------|:--------------------|:-----------|
| <code>Fractional number &#124; Integer</code> | `0`, `0.0`          | All others |
| `String`                                      | Empty string (`""`) | All others |
| `Boolean`                                     | `FALSE`             | `TRUE`     |
| <code>Date &#124; Datetime</code>             | -                   | `TRUE`     |



## [BR](BR.md)

**Syntax:**`BR()`

Adds a line break.



## [CAST_ARR_FLOAT](CAST_ARR_FLOAT.md)

**Syntax:**`CAST_ARR_FLOAT( array )`

Converts `array` to an array of fractional numbers. The conversion rules are the same as for [FLOAT](FLOAT.md).



## [CAST_ARR_INT](CAST_ARR_INT.md)

**Syntax:**`CAST_ARR_INT( array )`

Converts `array` to an array of integers. The conversion rules are the same as for [INT](INT.md).



## [CAST_ARR_STR](CAST_ARR_STR.md)

**Syntax:**`CAST_ARR_STR( array )`

Converts `array` to an array of strings. The conversion rules are the same as for [STR](STR.md).



## [CEILING](CEILING.md)

**Syntax:**`CEILING( number )`

Rounds the value up to the nearest integer.



## [CHAR](CHAR.md)

**Syntax:**`CHAR( string )`

Converts the numeric representation of an ASCII character to a value.



## [COLOR](COLOR.md)

**Syntax:**`COLOR( text, color )`

Enables specifying the color for the provided text.

We recommend using the [color variables](https://preview.gravity-ui.com/uikit/iframe.html?args=&id=colors--texts&viewMode=story) from the [Gravity UI](https://gravity-ui.com/) palette to specify colors. Such colors are easily discernible with both the light and dark theme.

You can also specify the color in any web format, such as HEX, keyword (e.g., `green`), RGB, etc. In this case, however, we cannot guarantee that the colors will be discernible.



## [COMPARE](COMPARE.md)

**Syntax:**`COMPARE( left, right, epsilon )`

Returns:
* 0 if `left` and `right` differs by not more than `epsilon`.
* -1 if `left` is less than `right` by more than `epsilon`.
* 1 if `left` is greater than `right` by more than `epsilon`.



## [CONCAT](CONCAT.md)

**Syntax:**`CONCAT( arg_1, arg_2, arg_3 [ , ... ] )`

Merges any number of strings. When non-string types are used, they're converted to strings and then merged.



## [CONTAINS (array)](CONTAINS_ARRAY.md)

**Syntax:**`CONTAINS( array, value )`

Returns `TRUE` if `array` contains `value`.



## [CONTAINS (string)](CONTAINS.md)

**Syntax:**`CONTAINS( string, substring )`

Returns `TRUE` if `string` contains `substring`. For case-insensitive searches, see [ICONTAINS](ICONTAINS.md).



## [CONTAINS_ALL](CONTAINS_ALL.md)

**Syntax:**`CONTAINS_ALL( array_1, array_2 )`

Returns `TRUE` if `array_1` contains all elements of `array_2`.



## [CONTAINS_ANY](CONTAINS_ANY.md)

**Syntax:**`CONTAINS_ANY( array_1, array_2 )`

Returns `TRUE` if `array_1` contains any elements of `array_2`.



## [CONTAINS_SUBSEQUENCE](CONTAINS_SUBSEQUENCE.md)

**Syntax:**`CONTAINS_SUBSEQUENCE( array_1, array_2 )`

Returns `TRUE` if `array_2` is a continuous subsequence of `array_1`. In other words, returns `TRUE` if and only if `array1 = prefix + array2 + suffix`.



## [COS](COS.md)

**Syntax:**`COS( number )`

Returns the cosine of `number` in radians.



## [COT](COT.md)

**Syntax:**`COT( number )`

Returns the cotangent of `number` in radians.



## [COUNT](COUNT.md)

**Syntax:**<br/>`COUNT(  [ value ] )`<br/>or<br/>`COUNT(  [ value ]
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )`

Returns the number of items in the group.

Can be used with constants, such as `COUNT(1)` or `COUNT()`. If the chart does not use other measures and dimensions, the result of such an expression will always be `1`. This is because the function does not include any fields, so {{ datalens-short-name }} accesses no source tables in the query.



## [COUNT (window)](COUNT_WINDOW.md)

**Syntax:**<br/>`COUNT(  [ value ]
       TOTAL | WITHIN ... | AMONG ...
     )`<br/>or<br/>`COUNT(  [ value ]
       TOTAL | WITHIN ... | AMONG ...
       [ BEFORE FILTER BY ... ]
     )`

Returns the number of items in the specified window.



## [COUNT_IF](COUNT_IF.md)

**Syntax:**<br/>`COUNT_IF( condition )`<br/>or<br/>`COUNT_IF( condition
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )`

Returns the number of items in the group meeting the `condition` condition.



## [COUNT_IF (window)](COUNT_IF_WINDOW.md)

**Syntax:**<br/>`COUNT_IF( expression, condition
          TOTAL | WITHIN ... | AMONG ...
        )`<br/>or<br/>`COUNT_IF( expression, condition
          TOTAL | WITHIN ... | AMONG ...
          [ BEFORE FILTER BY ... ]
        )`

Returns the number of items in the specified window meeting the `expression` condition.



## [COUNT_ITEM](COUNT_ITEM.md)

**Syntax:**`COUNT_ITEM( array, value )`

Returns the number of elements in the array `array` equal to `value`. The type of `value` must match the type of the `array` elements.



## [COUNTD](COUNTD.md)

**Syntax:**<br/>`COUNTD( value )`<br/>or<br/>`COUNTD( value
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Returns the number of unique values in the group.

See also [COUNTD_APPROX](COUNTD_APPROX.md).



## [COUNTD_APPROX](COUNTD_APPROX.md)

**Syntax:**<br/>`COUNTD_APPROX( value )`<br/>or<br/>`COUNTD_APPROX( value
               [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
               [ BEFORE FILTER BY ... ]
             )`

Returns the approximate number of unique values in the group. Faster than [COUNTD](COUNTD.md), but doesn't guarantee accuracy.



## [COUNTD_IF](COUNTD_IF.md)

**Syntax:**<br/>`COUNTD_IF( expression, condition )`<br/>or<br/>`COUNTD_IF( expression, condition
           [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
           [ BEFORE FILTER BY ... ]
         )`

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
- `"year"`;
- `"month"`;
- `"day"`;
- `"hour"`;
- `"minute"`;
- `"second"`.



## [DATEPART](DATEPART.md)

**Syntax:**`DATEPART( datetime, unit [ , firstday ] )`

Returns a part of the date as an integer.

Depending on the argument, `unit` returns the following values:
- `"year"` — the year number (see [YEAR](YEAR.md));
- `"quarter"` — the number of the quarter (from `1` to `4`) of the year (see [QUARTER](QUARTER.md));
- `"month"` — the number of the month in the year (see [MONTH](MONTH.md));
- `"week"` — the number of the week in the year according to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) (see [WEEK](WEEK.md));
- `"dayofweek"`, `"dow"` — the number of the day of the week (see [DAYOFWEEK](DAYOFWEEK.md));
- `"day"` — the number of the day in the month (see [DAY](DAY.md));
- `"hour"` — the number of the hour in the day (see [HOUR](HOUR.md));
- `"minute"` — the number of the minute in the hour (see [MINUTE](MINUTE.md));
- `"second"` — the number of the second in the minute (see [SECOND](SECOND.md)).

If you select `"dayofweek"`, you can use the additional parameter `firstday` to specify the first day of the week (Monday by default). Learn more about this parameter in the [DAYOFWEEK](DAYOFWEEK.md) function description.




## [DATETIME](DATETIME.md)

**Syntax:**`DATETIME( expression [ , timezone ] )`

Converts the `expression` expression to date and time format. When converting `Date` to `DateTime`, the time is set to '00:00:00'.
The date must be in the format `YYYY-MM-DDThh:mm:ss` or `YYYY-MM-DD hh:mm:ss`.
Numeric values are rendered as time in [Unix time](https://en.wikipedia.org/wiki/Unix_time) format or equal to the number of seconds elapsed since 00:00:00 on January 1, 1970, less the adjustments for leap seconds.

The date and time can be converted to the specified [time zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List) when the `timezone` option is available. The `timezone` parameter must be specified in `Region/Data_Zone` format.



## [DATETIME_PARSE](DATETIME_PARSE.md)

**Syntax:**`DATETIME_PARSE( value )`

Converts the `value` expression to date and time format. Unlike [DATETIME](DATETIME.md), it supports multiple formats. The expression is processed on the {{ CH }} source side. For more information on the supported formats, see the relevant {{ CH }} [documentation](https://clickhouse.com/docs/en/sql-reference/functions/type-conversion-functions#parsedatetime32besteffort).



## [DATETRUNC](DATETRUNC.md)

**Syntax:**`DATETRUNC( datetime, unit [ , number ] )`

Rounds `datetime` down to the given `unit`. If optional `number` is given, then the value is rounded down to a `number` multiple of `unit` (omitting `number` is the same as `number = 1`).

Supported units:
- `"second"`;
- `"minute"`;
- `"hour"`;
- `"day"` (acts as the day of the year if `number` is specified);
- `"week"`;
- `"month"`;
- `"quarter"`;
- `"year"`.

When using a function with three arguments, it is processed on the {{ CH }} side by the [toStartOfInterval function](https://clickhouse.com/docs/en/sql-reference/functions/date-time-functions#tostartofinterval). Rounding is done relative to a specific point in time, as detailed in the table in the function description. For example:
```
DATETRUNC(#2018-07-12 11:07:13#, "month", 4) = #2018-05-01 00:00:00#
```

For the `unit` argument set to `month`, rounding starts from `1900-01-01`. There are 1,422 months between `2018-07-12` and `1900-01-01`. Rounding this value to the nearest number divisible by 4 (the `number` argument), we get 1,420 months. Thus, adding 1,420 months to `1900-01-01` gives us `2018-05-01`.



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

| Data source   | Data type                     | Native data type      | Parameters for native type   | Comment                       |
|:--------------|:------------------------------|:----------------------|:-----------------------------|:------------------------------|
| `ClickHouse`  | `Date`                        | `Date`                |                              |                               |
| `ClickHouse`  | `Date`                        | `Date32`              |                              |                               |
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




## [DEGREES](DEGREES.md)

**Syntax:**`DEGREES( radians )`

Converts radians to degrees.



## [DIV](DIV.md)

**Syntax:**`DIV( number_1, number_2 )`

Divides `number_1` by `number_2`. The result is rounded down to the nearest integer.



## [DIV_SAFE](DIV_SAFE.md)

**Syntax:**`DIV_SAFE( numerator, denominator [ , fallback_value ] )`

Divides `numerator` by `denominator`. Returns `fallback_value` if division by zero occurs. If the number `fallback_value` is omitted, it is assumed to be `NULL`.
The result is rounded down to the nearest integer.



## [ENDSWITH](ENDSWITH.md)

**Syntax:**`ENDSWITH( string, substring )`

Returns `TRUE` if `string` ends in `substring`. For case-insensitive searches, see [IENDSWITH](IENDSWITH.md).



## [EXP](EXP.md)

**Syntax:**`EXP( number )`

Returns the result of raising the number 'e' to the power of `number`.



## [FDIV_SAFE](FDIV_SAFE.md)

**Syntax:**`FDIV_SAFE( numerator, denominator [ , fallback_value ] )`

Divides `numerator` by `denominator`. Returns `fallback_value` if division by zero occurs. If the number `fallback_value` is omitted, it is assumed to be `NULL`.



## [FIND](FIND.md)

**Syntax:**`FIND( string, substring [ , start_index ] )`

Returns the index of the position of the first character of the substring `substring` in the string `string`.

If the `start_index` option is specified, the search starts from the specified position.



## [FIRST (window)](FIRST.md)

**Syntax:**<br/>`FIRST( value )`<br/>or<br/>`FIRST( value
       [ TOTAL | WITHIN ... | AMONG ... ]
       [ ORDER BY ... ]
       [ BEFORE FILTER BY ... ]
     )`

Returns the value of `value` from the first row in the window. See also [LAST](LAST.md).



## [FLOAT](FLOAT.md)

**Syntax:**`FLOAT( expression )`

Converts the `expression` expression to fractional number format according to the following rules:

| Type                                          | Value                                                                                                                                                                                                             |
|:----------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <code>Fractional number &#124; Integer</code> | Original value.                                                                                                                                                                                                   |
| <code>Date &#124; Datetime</code>             | [Unix time](https://en.wikipedia.org/wiki/Unix_time) corresponding to the date and time. If the value contains time zone data, it's used in the calculation. If the time zone is unknown, the time is set in UTC. |
| `String`                                      | A number from a decimal string.                                                                                                                                                                                   |
| `Boolean`                                     | `TRUE` — `1.0`, `FALSE` — `0.0`.                                                                                                                                                                                  |



## [FLOOR](FLOOR.md)

**Syntax:**`FLOOR( number )`

Rounds the value down to the nearest integer.



## [GEOPOINT](GEOPOINT.md)

**Syntax:**`GEOPOINT( value_1 [ , value_2 ] )`

Generates a Geopoint type value. For the input, it accepts a string, a "geopoint" type value, or coordinates — latitude `value_1` and longitude `value_2`. If a single string is input, it must contain a list of two numbers (latitude and longitude) in JSON syntax.



## [GEOPOLYGON](GEOPOLYGON.md)

**Syntax:**`GEOPOLYGON( value )`

Converts the `value` expression to [geopolygon](../concepts/data-types.md#geopolygon) format. At input, the function accepts strings in `[[[lat_1,lon_1], [lat_2,lon_2], ..., [lat_N-1,lon_N-1], [lat_N,lon_N]]]` format.



## [GET_ITEM](GET_ITEM.md)

**Syntax:**`GET_ITEM( array, index )`

Returns the element with the index `index` from the array `array`. Index must be any integer. Indexes in an array begin with one. Returns the last item from the array if `index` is `-1`.



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



## [IMAGE](IMAGE.md)

**Syntax:**`IMAGE( src [ , width [ , height [ , alt ] ] ] )`

Enables inserting an image located at the `src` address to the table. The `width` and `height` values are provided in pixels. If one of the dimensions is `NULL`, it will be calculated automatically in proportion to the other. If both dimensions are `NULL`, the image will be inserted with the original width and height. In case there are issues when uploading the image, the function will display the `alt` text.




Images can be added from the `*.yandex.ru`, `*.yandex.net`, `yastat.net`, `yastatic.net`, or `storage.yandexcloud.net` domains. The easiest way is to upload and publish the image in [Yandex Object Storage](../../storage/quickstart.md) (see the pricing [here](../../storage/pricing.md#prices-storage)).







## [IN](IN.md)

**Syntax:**`item [ NOT ] IN (<list>)`

Checks whether the value matches at least one of the values listed in `IN(...)`.

The option `item NOT IN (<`list`>)` returns the opposite value.



## [INT](INT.md)

**Syntax:**`INT( expression )`

Converts the `expression` expression to integer format according to the following rules:

| Type                              | Value                                                                                                                                                                                                             |
|:----------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Integer`                         | Original value.                                                                                                                                                                                                   |
| `Fractional number`               | Integer part of the number (rounded down).                                                                                                                                                                        |
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



## [LAG (window)](LAG.md)

**Syntax:**<br/>`LAG( value [ , offset [ , default ] ] )`<br/>or<br/>`LAG( value [ , offset [ , default ] ]
     [ TOTAL | WITHIN ... | AMONG ... ]
     [ ORDER BY ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns `value` re-evaluated against the row that is offset from the current row by `offset` within the specified window:
- Positive `offset` seeks among preceding rows.
- Negative `offset` seeks among following rows.

By default `offset` is `1`.

If there is no available value (`offset` reaches before the first row or after the last one), then `default` is returned. If `default` is not specified, then `NULL` is used.

See also [AGO](AGO.md) for a non-window function alternative.



## [LAST (window)](LAST.md)

**Syntax:**<br/>`LAST( value )`<br/>or<br/>`LAST( value
      [ TOTAL | WITHIN ... | AMONG ... ]
      [ ORDER BY ... ]
      [ BEFORE FILTER BY ... ]
    )`

Returns the value of `value` from the last row in the window. See also [FIRST](FIRST.md).



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



## [LEN (array)](LEN_ARRAY.md)

**Syntax:**`LEN( value )`

Returns the number of the `value` items.



## [LEN](LEN.md)

**Syntax:**`LEN( value )`

Returns the number of characters in the string or items in array `value`.



## [LIKE](LIKE.md)

**Syntax:**`string_1 [ NOT ] LIKE string_2`

Matches the string `string_1` to the template `string_2` and returns `TRUE` on match.
You can specify the value in `string_2` or use the `%` character to match a string of any length.

The `string_1 NOT LIKE` option returns the opposite value.

When comparing values, the function is case-sensitive. You can use `LIKE` along with [UPPER](UPPER.md) or [LOWER](LOWER.md) for case-insensitive comparison.



## [LN](LN.md)

**Syntax:**`LN( number )`

Returns the natural logarithm of the number `number`. Returns `NULL` if the number is less than or equal to 0.



## [LOG](LOG.md)

**Syntax:**`LOG( value, base )`

Returns the logarithm of `value` to base `base`. Returns `NULL` if the number `value` is less than or equal to 0.



## [LOG10](LOG10.md)

**Syntax:**`LOG10( number )`

Returns the logarithm of the number `number` to base 10. Returns `NULL` if the number is less than or equal to 0.



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

**Syntax:**<br/>`MAVG( value, rows_1 [ , rows_2 ] )`<br/>or<br/>`MAVG( value, rows_1 [ , rows_2 ]
      [ TOTAL | WITHIN ... | AMONG ... ]
      [ ORDER BY ... ]
      [ BEFORE FILTER BY ... ]
    )`

Returns the moving average of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md).

See also [AVG](AVG.md), [RAVG](RAVG.md).



## [MAX](MAX.md)

**Syntax:**<br/>`MAX( value )`<br/>or<br/>`MAX( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns the maximum value.

If `value`:
- number — Returns the largest number.
- date — Returns the latest date.
- string — Returns the last value in the alphabetic order.




## [MAX (window)](MAX_WINDOW.md)

**Syntax:**<br/>`MAX( value
     TOTAL | WITHIN ... | AMONG ...
   )`<br/>or<br/>`MAX( value
     TOTAL | WITHIN ... | AMONG ...
     [ BEFORE FILTER BY ... ]
   )`

Returns the maximum value.

If `value`:
- number — Returns the largest number.
- date — Returns the latest date.
- string — Returns the last value in the alphabetic order.




## [MCOUNT (window)](MCOUNT.md)

**Syntax:**<br/>`MCOUNT( value, rows_1 [ , rows_2 ] )`<br/>or<br/>`MCOUNT( value, rows_1 [ , rows_2 ]
        [ TOTAL | WITHIN ... | AMONG ... ]
        [ ORDER BY ... ]
        [ BEFORE FILTER BY ... ]
      )`

Returns the moving count of (non-`NULL`) values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [COUNT](COUNT.md), [RCOUNT](RCOUNT.md).



## [MEDIAN](MEDIAN.md)

**Syntax:**<br/>`MEDIAN( value )`<br/>or<br/>`MEDIAN( value
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Returns the [median](https://en.wikipedia.org/wiki/Median) value. For an even number of items, it returns the greatest of the neighboring items in the central position.



## [MIN](MIN.md)

**Syntax:**<br/>`MIN( value )`<br/>or<br/>`MIN( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns the minimum value.

If `value`:
- number — Returns the smallest number.
- date — Returns the earliest date.
- string — Returns the first value in the alphabetic order.




## [MIN (window)](MIN_WINDOW.md)

**Syntax:**<br/>`MIN( value
     TOTAL | WITHIN ... | AMONG ...
   )`<br/>or<br/>`MIN( value
     TOTAL | WITHIN ... | AMONG ...
     [ BEFORE FILTER BY ... ]
   )`

Returns the minimum value.

If `value`:
- number — Returns the smallest number.
- date — Returns the earliest date.
- string — Returns the first value in the alphabetic order.




## [MINUTE](MINUTE.md)

**Syntax:**`MINUTE( datetime )`

Returns the number of the minute in the hour of the specified date `datetime`. When the date is specified without time, it returns `0`.



## [MMAX (window)](MMAX.md)

**Syntax:**<br/>`MMAX( value, rows_1 [ , rows_2 ] )`<br/>or<br/>`MMAX( value, rows_1 [ , rows_2 ]
      [ TOTAL | WITHIN ... | AMONG ... ]
      [ ORDER BY ... ]
      [ BEFORE FILTER BY ... ]
    )`

Returns the moving maximum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MAVG](MAVG.md).

See also [MAX](MAX.md), [RMAX](RMAX.md).



## [MMIN (window)](MMIN.md)

**Syntax:**<br/>`MMIN( value, rows_1 [ , rows_2 ] )`<br/>or<br/>`MMIN( value, rows_1 [ , rows_2 ]
      [ TOTAL | WITHIN ... | AMONG ... ]
      [ ORDER BY ... ]
      [ BEFORE FILTER BY ... ]
    )`

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

**Syntax:**<br/>`MSUM( value, rows_1 [ , rows_2 ] )`<br/>or<br/>`MSUM( value, rows_1 [ , rows_2 ]
      [ TOTAL | WITHIN ... | AMONG ... ]
      [ ORDER BY ... ]
      [ BEFORE FILTER BY ... ]
    )`

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

Returns the current date and time, depending on the data source and connection type.



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

**Syntax:**<br/>`QUANTILE( value, quant )`<br/>or<br/>`QUANTILE( value, quant
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )`

Returns the precise `quant`-level quantile (`quant` should be in range from 0 to 1).



## [QUANTILE_APPROX](QUANTILE_APPROX.md)

**Syntax:**<br/>`QUANTILE_APPROX( value, quant )`<br/>or<br/>`QUANTILE_APPROX( value, quant
                 [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
                 [ BEFORE FILTER BY ... ]
               )`

Returns the approximate `quant`-level quantile (`quant` should be in range from 0 to 1).



## [QUARTER](QUARTER.md)

**Syntax:**`QUARTER( datetime )`

Returns the number of the quarter (from `1` to `4`) of the year of the specified date `datetime`.



## [RADIANS](RADIANS.md)

**Syntax:**`RADIANS( degrees )`

Converts `degrees` degrees to radians.



## [RANK (window)](RANK.md)

**Syntax:**<br/>`RANK( value [ , direction ] )`<br/>or<br/>`RANK( value [ , direction ]
      [ TOTAL | WITHIN ... | AMONG ... ]
      [ BEFORE FILTER BY ... ]
    )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value used for sorting have the same rank. If the first two rows both have rank of `1`, then the next row (if it features a different value) will have rank `3`, so, in effect, it is rank with gaps.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RANK_DENSE (window)](RANK_DENSE.md)

**Syntax:**<br/>`RANK_DENSE( value [ , direction ] )`<br/>or<br/>`RANK_DENSE( value [ , direction ]
            [ TOTAL | WITHIN ... | AMONG ... ]
            [ BEFORE FILTER BY ... ]
          )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value used for sorting have the same rank. If the first two rows both have rank of `1`, then the next row (if it features a different value) will have rank `2`, (rank without gaps).

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RANK_PERCENTILE (window)](RANK_PERCENTILE.md)

**Syntax:**<br/>`RANK_PERCENTILE( value [ , direction ] )`<br/>or<br/>`RANK_PERCENTILE( value [ , direction ]
                 [ TOTAL | WITHIN ... | AMONG ... ]
                 [ BEFORE FILTER BY ... ]
               )`

Returns the relative rank (from `0` to `1`) of the current row if ordered by the given argument. Calculated as `(RANK(...) - 1) / (row count) `.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md).



## [RANK_UNIQUE (window)](RANK_UNIQUE.md)

**Syntax:**<br/>`RANK_UNIQUE( value [ , direction ] )`<br/>or<br/>`RANK_UNIQUE( value [ , direction ]
             [ TOTAL | WITHIN ... | AMONG ... ]
             [ BEFORE FILTER BY ... ]
           )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value have different rank values. This means that rank values are sequential and different for all rows, always increasing by `1` for the next row.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RAVG (window)](RAVG.md)

**Syntax:**<br/>`RAVG( value [ , direction ] )`<br/>or<br/>`RAVG( value [ , direction ]
      [ TOTAL | WITHIN ... | AMONG ... ]
      [ ORDER BY ... ]
      [ BEFORE FILTER BY ... ]
    )`

Returns the average of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md).

See also [AVG](AVG.md), [MAVG](MAVG.md).



## [RCOUNT (window)](RCOUNT.md)

**Syntax:**<br/>`RCOUNT( value [ , direction ] )`<br/>or<br/>`RCOUNT( value [ , direction ]
        [ TOTAL | WITHIN ... | AMONG ... ]
        [ ORDER BY ... ]
        [ BEFORE FILTER BY ... ]
      )`

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

Returns the substring `string` that matches the regular expression `pattern`.



## [REGEXP_EXTRACT_ALL](REGEXP_EXTRACT_ALL.md)

**Syntax:**`REGEXP_EXTRACT_ALL( string, pattern )`

Returns all `string` substrings matching the `pattern` regex. For regexes with subgroups, it only works for the first subgroup.



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



## [REPLACE (array)](REPLACE_ARRAY.md)

**Syntax:**`REPLACE( array, old, new )`

Replaces each `array` element equal to `old` with `new`.



## [REPLACE (string)](REPLACE.md)

**Syntax:**`REPLACE( string, substring, replace_with )`

Searches for the substring `substring` in the string `string` and replaces it with the string `replace_with`.

If the substring is not found, the string is not changed.



## [RIGHT](RIGHT.md)

**Syntax:**`RIGHT( string, number )`

Returns a string that contains the number of characters specified in `number` from the end of the string `string`.



## [RMAX (window)](RMAX.md)

**Syntax:**<br/>`RMAX( value [ , direction ] )`<br/>or<br/>`RMAX( value [ , direction ]
      [ TOTAL | WITHIN ... | AMONG ... ]
      [ ORDER BY ... ]
      [ BEFORE FILTER BY ... ]
    )`

Returns the maximum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RAVG](RAVG.md).

See also [MAX](MAX.md), [MMAX](MMAX.md).



## [RMIN (window)](RMIN.md)

**Syntax:**<br/>`RMIN( value [ , direction ] )`<br/>or<br/>`RMIN( value [ , direction ]
      [ TOTAL | WITHIN ... | AMONG ... ]
      [ ORDER BY ... ]
      [ BEFORE FILTER BY ... ]
    )`

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

**Syntax:**<br/>`RSUM( value [ , direction ] )`<br/>or<br/>`RSUM( value [ , direction ]
      [ TOTAL | WITHIN ... | AMONG ... ]
      [ ORDER BY ... ]
      [ BEFORE FILTER BY ... ]
    )`

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



## [SIZE](SIZE.md)

**Syntax:**`SIZE( text, size )`

Enables specifying the size (in pixels) for the provided text.



## [SLICE](SLICE.md)

**Syntax:**`SLICE( array, offset, length )`

Returns the part of array `array` of length `length` starting from index `offset`. Indexes in an array begin with one.



## [SPACE](SPACE.md)

**Syntax:**`SPACE( value )`

Returns a string with the specified number of spaces.



## [SPLIT](SPLIT.md)

**Syntax:**`SPLIT( orig_string [ , delimiter [ , part_index ] ] )`

It splits `orig_string` into a sequence of substrings using the `delimiter` character as separator and returns the substring whose number is equal to the `part_index` parameter. By default, the delimiting character is comma. If `part_index` is negative, the substring to return is counted from the end of `orig_string`. If the number of substrings is less than the `part_index` [absolute value](https://en.wikipedia.org/wiki/Absolute_value), the function returns an empty string. If `part_index` was not provided, the function returns an array of the substrings (only for `ClickHouse`, `PostgreSQL` sources).



## [SQRT](SQRT.md)

**Syntax:**`SQRT( number )`

Returns the square root of the specified number.



## [SQUARE](SQUARE.md)

**Syntax:**`SQUARE( number )`

Returns the number `number` raised to the power of 2.



## [STARTSWITH (array)](STARTSWITH_ARRAY.md)

**Syntax:**`STARTSWITH( array_1, array_2 )`

Returns `TRUE` if `array_1` starts with `array_2`.



## [STARTSWITH (string)](STARTSWITH.md)

**Syntax:**`STARTSWITH( string, substring )`

Returns `TRUE` if `string` starts with `substring`. For case-insensitive searches, see [ISTARTSWITH](ISTARTSWITH.md).



## [STDEV](STDEV.md)

**Syntax:**<br/>`STDEV( value )`<br/>or<br/>`STDEV( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )`

Returns the statistical [standard deviation](https://en.wikipedia.org/wiki/Standard_deviation) of all values in the expression based on a selection from the population.



## [STDEVP](STDEVP.md)

**Syntax:**<br/>`STDEVP( value )`<br/>or<br/>`STDEVP( value
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Returns the statistical [standard deviation](https://en.wikipedia.org/wiki/Standard_deviation) of all values in the expression based on the biased population. The function shows how far data points are from their average. In other words, standard deviation shows to what extent values in a dataset deviate from their average.



## [STR](STR.md)

**Syntax:**`STR( expression )`

Converts the `expression` expression to string type.



## [SUBSTR](SUBSTR.md)

**Syntax:**`SUBSTR( string, from_index [ , length ] )`

Returns the substring `string` starting from the index `from_index`. The numbering starts with one.

If an additional argument `length` is specified, a substring of the specified length is returned.



## [SUM](SUM.md)

**Syntax:**<br/>`SUM( value )`<br/>or<br/>`SUM( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns the sum of all expression values. Applicable to numeric data types only.



## [SUM (window)](SUM_WINDOW.md)

**Syntax:**<br/>`SUM( value
     TOTAL | WITHIN ... | AMONG ...
   )`<br/>or<br/>`SUM( value
     TOTAL | WITHIN ... | AMONG ...
     [ BEFORE FILTER BY ... ]
   )`

Returns the sum of all expression values. Applicable to numeric data types only.



## [SUM_IF](SUM_IF.md)

**Syntax:**<br/>`SUM_IF( expression, condition )`<br/>or<br/>`SUM_IF( expression, condition
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.



## [SUM_IF (window)](SUM_IF_WINDOW.md)

**Syntax:**<br/>`SUM_IF( expression, condition
        TOTAL | WITHIN ... | AMONG ...
      )`<br/>or<br/>`SUM_IF( expression, condition
        TOTAL | WITHIN ... | AMONG ...
        [ BEFORE FILTER BY ... ]
      )`

Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.



## [TAN](TAN.md)

**Syntax:**`TAN( number )`

Returns the tangent of `number` in radians.



## [TODAY](TODAY.md)

**Syntax:**`TODAY()`

Returns the current date, depending on the data source and connection type.



## [TOP_CONCAT](TOP_CONCAT.md)

**Syntax:**<br/>`TOP_CONCAT( expression, amount [ , separator ] )`<br/>or<br/>`TOP_CONCAT( expression, amount [ , separator ]
            [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
            [ BEFORE FILTER BY ... ]
          )`

Returns a string that contains top `amount` unique values of `expression` delimited by `separator` (if `separator` is not specified, a comma is used).



## [TREE](TREE.md)

**Syntax:**`TREE( array )`

Converts the `array` expression to `Tree of strings` format. Can be used to create [tree hierarchies](../concepts/data-types.md#tree-hierarchy).



## [TRIM](TRIM.md)

**Syntax:**`TRIM( string )`

Returns the string `string` without spaces at the beginning or end of the string.



## [UNNEST](UNNEST.md)

**Syntax:**`UNNEST( array )`

Expands the `array` array expression to a set of rows.



## [UPPER](UPPER.md)

**Syntax:**`UPPER( string )`

Returns the string `string` in uppercase.



## [URL](URL.md)

**Syntax:**`URL( address, text )`

Wraps `text` into a hyperlink to URL `address`. When you click on the link, the page opens in a new browser tab.



## [USER_INFO](USER_INFO.md)

**Syntax:**`USER_INFO( user_id, user_info_type )`

Returns the marked up text by `user_id` to display username or email depending on the `user_info_type` value:

* `email`: Returns email.
* `name`: Returns name.

If the user has not been found, the function will return the original string from the source.



## [UTF8](UTF8.md)

**Syntax:**`UTF8( string, old_encoding )`

Converts the `string` string encoding to `UTF8`.



## [VAR](VAR.md)

**Syntax:**<br/>`VAR( value )`<br/>or<br/>`VAR( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns the statistical variance of all values in an expression based on a selection from the population.



## [VARP](VARP.md)

**Syntax:**<br/>`VARP( value )`<br/>or<br/>`VARP( value
      [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
      [ BEFORE FILTER BY ... ]
    )`

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


