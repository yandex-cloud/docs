---
title: Operators
editable: false
sourcePath: en/_api-ref/datalens/function-ref/operator-functions.md
---

# Operators


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
| <code>Datetime &#124; Datetime (deprecated)</code>                                        | <code>Fractional number &#124; Integer</code>                                             | The date with time, `value_2` days greater than `value_1`. If `value_2` contains a fractional part, it is converted hours (`1/24`), minutes (`1/1440`), and seconds (`1/86400`). |
| `String`                                                                                  | `String`                                                                                  | The merging (concatenation) of strings `value_1` and `value_2`.                                                                                                                  |
| <code>Array of fractional numbers &#124; Array of integers &#124; Array of strings</code> | <code>Array of fractional numbers &#124; Array of integers &#124; Array of strings</code> | The merging (concatenation) of arrays `value_1` and `value_2`.                                                                                                                   |

Changing the order of arguments does not affect the result.



## [Subtraction (-)](OP_MINUS.md)

**Syntax:**`value_1 - value_2`

Behaves differently depending on the argument types. Possible options are listed in the table:

| Type of `value_1`                                  | Type of `value_2`                             | Return value                                                                                                                                                                                                       |
|:---------------------------------------------------|:----------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <code>Fractional number &#124; Integer</code>      | <code>Fractional number &#124; Integer</code> | The difference between the numbers `value_1` and `value_2`.                                                                                                                                                        |
| `Date`                                             | <code>Fractional number &#124; Integer</code> | The date that is `value_2` days smaller than `value_1` (rounded down to an integer number of days).                                                                                                                |
| <code>Datetime &#124; Datetime (deprecated)</code> | <code>Fractional number &#124; Integer</code> | The date with time, `value_2` days smaller than `value_1`. If `value_2` contains a fractional part, it is converted to hours (`1/24`), minutes (`1/1440`), and seconds (`1/86400`).                                |
| `Date`                                             | `Date`                                        | The difference between two dates in days.                                                                                                                                                                          |
| `Datetime (deprecated)`                            | `Datetime (deprecated)`                       | The difference between two dates in days: the integer part — the number of whole days, the fractional part — the number of hours, minutes and seconds expressed as a fraction of the whole day (1 hour is '1/24'). |
| `Datetime`                                         | `Datetime`                                    | The difference between two dates in days: the integer part — the number of whole days, the fractional part — the number of hours, minutes and seconds expressed as a fraction of the whole day (1 hour is '1/24'). |



## [Division (/)](OP_DIV.md)

**Syntax:**`number_1 / number_2`

Divides the number `number_1` by the number `number_2`.



## [Comparison](OP_COMPARISON.md)

**Syntax:**<br/>`value_1 = value_2`<br/>or<br/>`value_1 != value_2`<br/>or<br/>`value_1 < value_2`<br/>or<br/>`value_1 <= value_2`<br/>or<br/>`value_1 > value_2`<br/>or<br/>`value_1 >= value_2`

Compares the value `value_1` with the value `value_2`.



## [Power (^)](OP_POWER.md)

**Syntax:**`base ^ power`

Raises `base` to the power of `power`.



## [AND](AND.md)

**Syntax:**`value_1 AND value_2`

Performs a Boolean join of two expressions with the `AND` condition.



## [BETWEEN](BETWEEN.md)

**Syntax:**`value [ NOT ] BETWEEN low AND high`

Returns `TRUE` if `value` is in the range from `low` to `high`.

The option `value NOT BETWEEN low AND high` returns the opposite value.



## [IN](IN.md)

**Syntax:**`item [ NOT ] IN (<list>)`

Checks whether the value matches at least one of the values listed in `IN(...)`.

The option `item NOT IN (<`list`>)` returns the opposite value.



## [IS FALSE](ISFALSE.md)

**Syntax:**`value IS [ NOT ] FALSE`

Checks whether the `value` value is false (`FALSE`).

The `value IS NOT FALSE` option returns the opposite value.



## [IS TRUE](ISTRUE.md)

**Syntax:**`value IS [ NOT ] TRUE`

Checks whether the value of `value` is true (`TRUE`).

The `value IS NOT TRUE` option returns the opposite value.



## [LIKE](LIKE.md)

**Syntax:**`string_1 [ NOT ] LIKE string_2`

Matches the string `string_1` to the template `string_2` and returns `TRUE` on match.
You can specify the value in `string_2` or use the `%` character to match a string of any length.

The `string_1 NOT LIKE` option returns the opposite value.



## [Negation (-)](OP_NEGATION.md)

**Syntax:**`-value`

Returns the number `value` with the opposite sign.



## [NOT](OP_NOT.md)

**Syntax:**`NOT value`

Inverts a Boolean value.



## [OR](OR.md)

**Syntax:**`value_1 OR value_2`

Performs a Boolean join of two expressions with the `OR` condition.


