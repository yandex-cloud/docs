---
title: Mathematical functions
editable: false
sourcePath: en/_api-ref/datalens/function-ref/numeric-functions.md
---

# Mathematical functions


## [ABS](ABS.md)

**Syntax:**`ABS( number )`

Returns the absolute value of `number`.



## [ACOS](ACOS.md)

**Syntax:**`ACOS( number )`

Returns the arccosine of `number` in radians.



## [ASIN](ASIN.md)

**Syntax:**`ASIN( number )`

Returns the arcsine of `number` in radians.



## [ATAN](ATAN.md)

**Syntax:**`ATAN( number )`

Returns the arctangent of `number` in radians.



## [ATAN2](ATAN2.md)

**Syntax:**`ATAN2( x, y )`

Returns the arctangent in radians for the specified coordinates `x` and `y`.



## [CEILING](CEILING.md)

**Syntax:**`CEILING( number )`

Rounds the value up to the nearest integer.



## [COMPARE](COMPARE.md)

**Syntax:**`COMPARE( left, right, epsilon )`

Returns:
* 0 if `left` and `right` differs by not more than `epsilon`.
* -1 if `left` is less than `right` by more than `epsilon`.
* 1 if `left` is greater than `right` by more than `epsilon`.



## [COS](COS.md)

**Syntax:**`COS( number )`

Returns the cosine of `number` in radians.



## [COT](COT.md)

**Syntax:**`COT( number )`

Returns the cotangent of `number` in radians.



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



## [EXP](EXP.md)

**Syntax:**`EXP( number )`

Returns the result of raising the number 'e' to the power of `number`.



## [FDIV_SAFE](FDIV_SAFE.md)

**Syntax:**`FDIV_SAFE( numerator, denominator [ , fallback_value ] )`

Divides `numerator` by `denominator`. Returns `fallback_value` if division by zero occurs. If the number `fallback_value` is omitted, it is assumed to be `NULL`.



## [FLOOR](FLOOR.md)

**Syntax:**`FLOOR( number )`

Rounds the value down to the nearest integer.



## [GREATEST](GREATEST.md)

**Syntax:**`GREATEST( value_1, value_2, value_3 [ , ... ] )`

Returns the greatest value.

See also [LEAST](LEAST.md).

Depending on the specified data type, it returns:
- The greatest number.
- The last string in alphabetical order.
- The latest date.
- `TRUE` when selecting between `TRUE` and `FALSE` for Boolean type.



## [LEAST](LEAST.md)

**Syntax:**`LEAST( value_1, value_2, value_3 [ , ... ] )`

Returns the smallest value.

See also [GREATEST](GREATEST.md).

Depending on the specified data type, it returns:
- The smallest number.
- The first string in alphabetical order.
- The earliest date.
- `FALSE` when selecting between `TRUE` and `FALSE` for Boolean type.



## [LN](LN.md)

**Syntax:**`LN( number )`

Returns the natural logarithm of the number `number`. Returns `NULL` if the number is less than or equal to 0.



## [LOG](LOG.md)

**Syntax:**`LOG( value, base )`

Returns the logarithm of `value` to base `base`. Returns `NULL` if the number `value` is less than or equal to 0.



## [LOG10](LOG10.md)

**Syntax:**`LOG10( number )`

Returns the logarithm of the number `number` to base 10. Returns `NULL` if the number is less than or equal to 0.



## [PI](PI.md)

**Syntax:**`PI()`

Returns PI. The accuracy depends on the data source.



## [POWER](POWER.md)

**Syntax:**`POWER( base, power )`

Raises `base` to the power of `power`.



## [RADIANS](RADIANS.md)

**Syntax:**`RADIANS( degrees )`

Converts `degrees` degrees to radians.



## [ROUND](ROUND.md)

**Syntax:**`ROUND( number [ , precision ] )`

Rounds the number `number` to the number of decimal digits specified in `precision`.
If the number `precision` is omitted, `number` is rounded to the nearest integer.



## [SIGN](SIGN.md)

**Syntax:**`SIGN( number )`

Returns the sign of the number `number`:
- `-1` if the number is negative.
`0` if the number is zero.
- `1` if the number is positive.



## [SIN](SIN.md)

**Syntax:**`SIN( number )`

Returns the sine of `number` in radians.



## [SQRT](SQRT.md)

**Syntax:**`SQRT( number )`

Returns the square root of the specified number.



## [SQUARE](SQUARE.md)

**Syntax:**`SQUARE( number )`

Returns the number `number` raised to the power of 2.



## [TAN](TAN.md)

**Syntax:**`TAN( number )`

Returns the tangent of `number` in radians.


