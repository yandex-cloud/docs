---
title: Time series functions
description: Time series functions provide various ways to look up values corresponding to a specific time or offset along a given time axis.
editable: false
sourcePath: en/_api-ref/datalens/function-ref/time-series-functions.md
---

# Time series functions
Time series functions provide various ways to look up values corresponding to a specific time or offset along a given time axis.

In a certain way this functionality is similar to the window function [LAG](LAG.md).
The main difference is that `LAG` is indifferent to the actual values of the dimensions being used, and operates over positional offsets specified in _rows_, while time series functions use specific values and value offsets in date/time units like days, hours or seconds. This makes them sensitive to missing values in data. As a result of this `AGO(SUM([Sales]), [Date], "year")` will return `NULL` if the same-date row for the previous year is missing.

Time series functions work with specific values or deviations specified in time units (days, hours, or seconds). Due to that, they become sensitive to missing values in data. As the result, the `AGO(SUM([Sales]), [Date], "year")` formula will return `NULL` if there is no data for the same date in the previous year. Also, note that when you use data in date and time format, you might have data for the same date, but not for the exact same second. Besides, when rounding dates to weeks, a shift in years will also return `NULL`.

## Syntax {#syntax}

Time series functions support extended syntax:
```
<FUNCTION_NAME>(
    arg1, arg2, ...

    [ BEFORE FILTER BY filtered_field_1, ... ]
    [ IGNORE DIMENSIONS dimension_1, ... ]
)
```

### BEFORE FILTER BY {#syntax-before-filter-by}

If any fields are listed in `BEFORE FILTER BY`, then the function is calculated before data is filtered using these fields.
Let's say you are trying to calculate the value of `[Sales]` a year ago from today's date:
```
AGO([Sales], [Date], "year", 1)
```
and also have a filter in the chart limiting the dates to a specific year (`2018 < [Year] <= 2019`, where `Year` is calculated as `YEAR([Date])`). All data pertaining to the year 2018 will be omitted from the result. Because of this the function will return `NULL`.

If `BEFORE FILTER BY` is added to the function:
```
AGO([Sales], [Date], "year", 1 BEFORE FILTER BY [Year])
```
it will return the value of `[Sales]`.

The date/time dimension specified as the second argument of time series functions is implicitly added to the `BEFORE FILTER BY` clause. For example, the following to formulas are equivalent:
```
AGO([Sales], [Date], "week")
```
```
AGO([Sales], [Date], "week" BEFORE FILTER BY [Date])
```

### IGNORE DIMENSIONS {#syntax-ignore-dimensions}

The `IGNORE DIMENSIONS` clause allows the exclusion of dimensions from the search criteria. When looking up a value for a certain date, the search is done by matching dimension values in each row against the values of the same dimensions in the original row. If any of the other dimensions correlate with the date dimension, then the data query may return an empty result (`NULL`).

For example, if the data request contains `[Date]`, `[Month]` and `AGO([Sales], [Date], "month")`, then it will be impossible to find a row with `[Date]` being a month earlier, but the value of `[Month]` being the same as in the current row. This will result in `AGO` always returning `NULL`.

To get the correct value of `[Sales]` exclude `[Month]` using the `IGNORE DIMENSIONS` clause:
```
AGO([Sales], [Date], "month" IGNORE DIMENSIONS [Month])
```



## [AGO](AGO.md)

**Syntax:**<br/>`AGO( measure, date_dimension [ , unit [ , number ] ] )`<br/>or<br/>`AGO( measure, date_dimension [ , unit [ , number ] ]
     [ BEFORE FILTER BY ... ]
     [ IGNORE DIMENSIONS ... ]
   )`

Re-evaluate `measure` for a date/time with a given offset.
The `date_dimension` argument is the dimension along which the offset is made.
The `number` argument is an integer. It can be negative.
The `unit` argument takes the following values:
- `"year"`;
- `"month"`;
- `"week"`;
- `"day"`;
- `"hour"`;
- `"minute"`;
- `"second"`.

Can also be used as `AGO( measure, date_dimension, number )`. In this case, the third argument is interpreted as the number of days.

See also [AT_DATE](AT_DATE.md), [LAG](LAG.md).



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


