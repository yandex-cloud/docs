---
title: Native functions
description: Functions for calling native database functions by its name.
keywords:
  - native
  - database
  - function
  - call
editable: false
---

# Native functions
Functions for calling native database functions by its name.


## [DB_CALL_AGG_FLOAT](DB_CALL_AGG_FLOAT.md)

**Syntax:**<br/>`DB_CALL_AGG_FLOAT( db_agg_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )`<br/>or<br/>`DB_CALL_AGG_FLOAT( db_agg_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ]
                   [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
                   [ BEFORE FILTER BY ... ]
                 )`

Calls a native database aggregate function by its name. Native function should return a value of type `Fractional number`. The function is executed as an aggregation across grouped rows.

The first argument `db_agg_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.



## [DB_CALL_AGG_INT](DB_CALL_AGG_INT.md)

**Syntax:**<br/>`DB_CALL_AGG_INT( db_agg_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )`<br/>or<br/>`DB_CALL_AGG_INT( db_agg_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ]
                 [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
                 [ BEFORE FILTER BY ... ]
               )`

Calls a native database aggregate function by its name. Native function should return a value of type `Integer`. The function is executed as an aggregation across grouped rows.

The first argument `db_agg_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.



## [DB_CALL_AGG_STRING](DB_CALL_AGG_STRING.md)

**Syntax:**<br/>`DB_CALL_AGG_STRING( db_agg_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )`<br/>or<br/>`DB_CALL_AGG_STRING( db_agg_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ]
                    [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
                    [ BEFORE FILTER BY ... ]
                  )`

Calls a native database aggregate function by its name. Native function should return a value of type `String`. The function is executed as an aggregation across grouped rows.

The first argument `db_agg_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.



## [DB_CALL_ARRAY_FLOAT](DB_CALL_ARRAY_FLOAT.md)

**Syntax:**`DB_CALL_ARRAY_FLOAT( db_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )`

Calls a native database function by its name. Native function should return a value of type `Array of fractional numbers`. The function is executed for every row in the dataset (non-aggregated).

The first argument `db_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.



## [DB_CALL_ARRAY_INT](DB_CALL_ARRAY_INT.md)

**Syntax:**`DB_CALL_ARRAY_INT( db_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )`

Calls a native database function by its name. Native function should return a value of type `Array of integers`. The function is executed for every row in the dataset (non-aggregated).

The first argument `db_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.



## [DB_CALL_ARRAY_STRING](DB_CALL_ARRAY_STRING.md)

**Syntax:**`DB_CALL_ARRAY_STRING( db_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )`

Calls a native database function by its name. Native function should return a value of type `Array of strings`. The function is executed for every row in the dataset (non-aggregated).

The first argument `db_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.



## [DB_CALL_BOOL](DB_CALL_BOOL.md)

**Syntax:**`DB_CALL_BOOL( db_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )`

Calls a native database function by its name. Native function should return a value of type `Boolean`. The function is executed for every row in the dataset (non-aggregated).

The first argument `db_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.



## [DB_CALL_FLOAT](DB_CALL_FLOAT.md)

**Syntax:**`DB_CALL_FLOAT( db_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )`

Calls a native database function by its name. Native function should return a value of type `Fractional number`. The function is executed for every row in the dataset (non-aggregated).

The first argument `db_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.



## [DB_CALL_INT](DB_CALL_INT.md)

**Syntax:**`DB_CALL_INT( db_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )`

Calls a native database function by its name. Native function should return a value of type `Integer`. The function is executed for every row in the dataset (non-aggregated).

The first argument `db_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.



## [DB_CALL_STRING](DB_CALL_STRING.md)

**Syntax:**`DB_CALL_STRING( db_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )`

Calls a native database function by its name. Native function should return a value of type `String`. The function is executed for every row in the dataset (non-aggregated).

The first argument `db_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.


