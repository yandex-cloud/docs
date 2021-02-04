---
editable: false
---

# DATEPART



#### Syntax {#syntax}


```
DATEPART( datetime, unit [ , firstday ] )
```

#### Description {#description}
Returns a part of the date as an integer.

Depending on the argument, `unit` returns the following values:
- `"year"` — the year number (see [YEAR](YEAR.md));
- `"month"` — the number of the month in the year (see [MONTH](MONTH.md));
- `"week"` — the number of the week in the year according to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) (see [WEEK](WEEK.md));
- `"dayofweek"`, `"dow"` — the number of the day of the week (see [DAYOFWEEK](DAYOFWEEK.md));
- `"day"` — the number of the day in the month (see [DAY](DAY.md));
- `"hour"` — the number of the hour in the day (see [HOUR](HOUR.md));
- `"minute"` — the number of the minute in the hour (see [MINUTE](MINUTE.md));
- `"second"` — the number of the second in the minute (see [SECOND](SECOND.md)).

If you select `"dayofweek"`, you can use the additional parameter `firstday` to specify the first day of the week (Monday by default). Learn more about this parameter in the [DAYOFWEEK](DAYOFWEEK.md) function description.


**Argument types:**
- `datetime` — `Date | Datetime`
- `unit` — `String`
- `firstday` — `String`


**Return type**: `Number (whole)`

{% note info %}

Only constant values are accepted for arguments (`firstday`).

{% endnote %}


#### Examples {#examples}

```
DATEPART(#2019-01-23#, "year") = 2019
```

```
DATEPART(#2019-01-23#, "month") = 1
```

```
DATEPART(#2019-01-23#, "day") = 23
```

```
DATEPART(#2019-01-23 11:47:07#, "hour") = 11
```

```
DATEPART(#2019-01-23 11:47:07#, "minute") = 47
```

```
DATEPART(#2019-01-23 11:47:07#, "second") = 7
```

```
DATEPART(#1971-01-14 01:02:03#, "dayofweek") = 4
```

```
DATEPART(#1971-01-14 01:02:03#, "dayofweek", "wed") = 2
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
