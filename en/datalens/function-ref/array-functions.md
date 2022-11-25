---
title: Array functions
editable: false
sourcePath: en/_api-ref/datalens/function-ref/array-functions.md
---

# Array functions


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



## [CAST_ARR_FLOAT](CAST_ARR_FLOAT.md)

**Syntax:**`CAST_ARR_FLOAT( array )`

Converts `array` to an array of fractional numbers. The conversion rules are the same as for [FLOAT](FLOAT.md).



## [CAST_ARR_INT](CAST_ARR_INT.md)

**Syntax:**`CAST_ARR_INT( array )`

Converts `array` to an array of integers. The conversion rules are the same as for [INT](INT.md).



## [CAST_ARR_STR](CAST_ARR_STR.md)

**Syntax:**`CAST_ARR_STR( array )`

Converts `array` to an array of strings. The conversion rules are the same as for [STR](STR.md).



## [CONTAINS](CONTAINS_ARRAY.md)

**Syntax:**`CONTAINS( array, value )`

Returns `TRUE` if `array` contains `value`.



## [COUNT_ITEM](COUNT_ITEM.md)

**Syntax:**`COUNT_ITEM( array, value )`

Returns the number of elements in the array `array` equal to `value`. The type of `value` must match the type of the `array` elements.



## [GET_ITEM](GET_ITEM.md)

**Syntax:**`GET_ITEM( array, index )`

Returns the element with the index `index` from the array `array`. Index must be any integer. Indexes in an array begin with one.



## [REPLACE](REPLACE_ARRAY.md)

**Syntax:**`REPLACE( array, old, new )`

Replaces each `array` element equal to `old` with `new`.



## [SLICE](SLICE.md)

**Syntax:**`SLICE( array, offset, length )`

Returns the part of array `array` of length `length` starting from index `offset`. Indexes in an array begin with one.



## [STARTSWITH](STARTSWITH_ARRAY.md)

**Syntax:**`STARTSWITH( array_1, array_2 )`

Returns `TRUE` if `array_1` starts with `array_2`.



## [UNNEST](UNNEST.md)

**Syntax:**`UNNEST( array )`

Expands the `array` array expression to a set of rows.


