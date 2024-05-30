---
title: Date/Time functions
editable: false
sourcePath: en/_api-ref/datalens/function-ref/date-functions.md
---

# Date/Time functions


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




## [HOUR](HOUR.md)

**Syntax:**`HOUR( datetime )`

Returns the number of the hour in the day of the specified date and time `datetime`. When the date is specified without time, it returns `0`.



## [MINUTE](MINUTE.md)

**Syntax:**`MINUTE( datetime )`

Returns the number of the minute in the hour of the specified date `datetime`. When the date is specified without time, it returns `0`.



## [MONTH](MONTH.md)

**Syntax:**`MONTH( datetime )`

Returns the number of the month in the year of the specified date `datetime`.



## [NOW](NOW.md)

**Syntax:**`NOW()`

Returns the current date and time, depending on the data source and connection type.



## [QUARTER](QUARTER.md)

**Syntax:**`QUARTER( datetime )`

Returns the number of the quarter (from `1` to `4`) of the year of the specified date `datetime`.



## [SECOND](SECOND.md)

**Syntax:**`SECOND( datetime )`

Returns the number of the second in the minute of the specified date `datetime`. When the date is specified without time, it returns `0`.



## [TODAY](TODAY.md)

**Syntax:**`TODAY()`

Returns the current date, depending on the data source and connection type.



## [WEEK](WEEK.md)

**Syntax:**`WEEK( value )`

The number of the week according to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601). The first week is the week that contains the first Thursday of the year or January 4th.



## [YEAR](YEAR.md)

**Syntax:**`YEAR( datetime )`

Returns the year number in the specified date `datetime`.


