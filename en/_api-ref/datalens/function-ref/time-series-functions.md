---
editable: false
---

# Time series functions
Time series functions provide various ways to look up values corresponding to a specific time or offset along a given time axis.

In a certain way this functionality is similar to the window function [LAG](LAG.md).
The main difference is that `LAG` is indifferent to the actual values of the dimensions being used, and operates over positional offsets specified in _rows_, while time series functions use specific values and value offsets in date/time units like days, hours or seconds. This makes them sensitive to missing values in data. As a result of this `AGO(SUM([Sales]), [Date], "year")` will return `NULL` if the same-date row for the previous year is missing.


## [AGO](AGO.md)

**Syntax:**`AGO( measure, date_dimension [ , unit [ , number ] ] )`

Re-evaluate `measure` for a date/time with a given offset.
The `date_dimension` argument is the dimension along which the offset is made.
The `number` argument is an integer. It can be negative.
The `unit` argument takes the following values:
- `"year"`;
- `"month"`;
- `"day"`;
- `"hour"`;
- `"minute"`;
- `"second"`.

Can also be used as `AGO( measure, date_dimension, number )`. In this case, the third argument is interpreted as the number of days.

This non-window function does not support window options such as `BEFORE FILTER BY`.

See also [AT_DATE](AT_DATE.md), [LAG](LAG.md).



## [AT_DATE](AT_DATE.md)

**Syntax:**`AT_DATE( measure, date_dimension, date_expr )`

Re-evaluate `measure` for a date/time specified by `date_expr`.
The `date_dimension` argument is the dimension along which the offset is made.

See also [AGO](AGO.md), [LAG](LAG.md).


