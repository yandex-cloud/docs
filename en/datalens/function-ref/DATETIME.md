---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DATETIME.md
---

# DATETIME



#### Syntax {#syntax}


```
DATETIME( expression [ , timezone ] )
```

#### Description {#description}
Converts the `expression` expression to date and time format. When converting `Date` to `DateTime`, the time is set to '00:00:00'.
The date must be in the format `YYYY-MM-DDThh:mm:ss` or `YYYY-MM-DD hh:mm:ss`.
Numeric values are rendered as time in [Unix time](https://en.wikipedia.org/wiki/Unix_time) format or equal to the number of seconds elapsed since 00:00:00 on January 1, 1970, less the adjustments for leap seconds.

The date and time can be converted to the specified [time zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List) when the `timezone` option is available. The `timezone` parameter must be specified in `Region/Data_Zone` format.

**Argument types:**
- `expression` — `Date | Datetime | Fractional number | Integer | String`
- `timezone` — `String`


**Return type**: `Datetime`

{% note info %}

Only constant values are accepted for the arguments (`timezone`).

{% endnote %}

{% note info %}

Argument `timezone` is available only for `ClickHouse` sources.

{% endnote %}


#### Examples {#examples}

```
DATETIME("2019-01-23 15:07:47") = #2019-01-23 15:07:47#
```

```
DATETIME("2019.01.02 03:04:05") = #2019-01-02 03:04:05#
```

```
DATETIME("2019-01-23") = #2019-01-23 00:00:00#
```

```
DATETIME(1576807650) = #2019-12-20 02:07:30#
```

```
DATETIME(1576807650.793) = #2019-12-20 02:07:30#
```

```
DATETIME(1576807650.793, 'Asia/Hong_Kong') = #2019-12-20 10:07:30#
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
