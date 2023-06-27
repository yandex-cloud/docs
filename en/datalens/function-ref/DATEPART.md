---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DATEPART.md
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
- `"quarter"` — the number of the quarter (from `1` to `4`) of the year (see [QUARTER](QUARTER.md));
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


**Return type**: `Integer`

{% note info %}

Only constant values are accepted for the arguments (`firstday`).

{% endnote %}


#### Examples {#examples}

{% cut "Example with date" %}


Formulas:

- **Date**: `[Date]` ;
- **Year**: `DATEPART([Date], "year")` ;
- **Month**: `DATEPART([Date], "month")` ;
- **Day**: `DATEPART([Date], "day")` ;
- **DayOfWeek**: `DATEPART([Date], "dayofweek")` ;
- **DOW**: `DATEPART([Date], "dow")` .

| **Date**     | **Year**   | **Month**   | **Day**   | **DayOfWeek**   | **DOW**   |
|:-------------|:-----------|:------------|:----------|:----------------|:----------|
| `2014-10-06` | `2014`     | `10`        | `6`       | `1`             | `1`       |
| `2014-10-07` | `2014`     | `10`        | `7`       | `2`             | `2`       |
| `2017-03-08` | `2017`     | `3`         | `8`       | `3`             | `3`       |
| `2024-02-12` | `2024`     | `2`         | `12`      | `1`             | `1`       |

{% endcut %}

{% cut "Example with custom first day of the week" %}


Formulas:

- **Date**: `[Date]` ;
- **DOW**: `DATEPART([Date], "dow")` ;
- **DOW sun**: `DATEPART([Date], "dow", "sun")` ;
- **DOW Monday**: `DATEPART([Date], "dow", "Monday")` ;
- **DOW wed**: `DATEPART([Date], "dow", "wed")` .

| **Date**     | **DOW**   | **DOW sun**   | **DOW Monday**   | **DOW wed**   |
|:-------------|:----------|:--------------|:-----------------|:--------------|
| `2014-10-06` | `1`       | `2`           | `1`              | `6`           |
| `2014-10-07` | `2`       | `3`           | `2`              | `7`           |
| `2017-03-08` | `3`       | `4`           | `3`              | `1`           |
| `2024-02-12` | `1`       | `2`           | `1`              | `6`           |

{% endcut %}

{% cut "Example with date and time" %}


Formulas:

- **DateTime**: `[DateTime]` ;
- **Year**: `DATEPART([DateTime], "year")` ;
- **Month**: `DATEPART([DateTime], "month")` ;
- **Day**: `DATEPART([DateTime], "day")` ;
- **Hour**: `DATEPART([DateTime], "hour")` ;
- **Minute**: `DATEPART([DateTime], "minute")` ;
- **Second**: `DATEPART([DateTime], "second")` .

| **DateTime**          | **Year**   | **Month**   | **Day**   | **Hour**   | **Minute**   | **Second**   |
|:----------------------|:-----------|:------------|:----------|:-----------|:-------------|:-------------|
| `2014-10-06T07:45:12` | `2014`     | `10`        | `6`       | `7`        | `45`         | `12`         |
| `2014-10-07T11:10:15` | `2014`     | `10`        | `7`       | `11`       | `10`         | `15`         |
| `2017-03-08T23:59:59` | `2017`     | `3`         | `8`       | `23`       | `59`         | `59`         |
| `2024-02-12T07:40:33` | `2024`     | `2`         | `12`      | `7`        | `40`         | `33`         |

{% endcut %}


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
