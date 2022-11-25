---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DAYOFWEEK.md
---

# DAYOFWEEK



#### Syntax {#syntax}


```
DAYOFWEEK( datetime [ , firstday ] )
```

#### Description {#description}
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


**Argument types:**
- `datetime` — `Date | Datetime`
- `firstday` — `String`


**Return type**: `Integer`

{% note info %}

Only constant values are accepted for the arguments (`firstday`).

{% endnote %}


#### Examples {#examples}

```
DAYOFWEEK(#1971-01-14 01:02:03#) = 4
```

```
DAYOFWEEK(#1971-01-14#, "wed") = 2
```

```
DAYOFWEEK(#1971-01-14#, "wednesday") = 2
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
