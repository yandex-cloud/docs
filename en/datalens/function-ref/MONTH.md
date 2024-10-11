---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/MONTH.md
---

# MONTH



#### Syntax {#syntax}


```
MONTH( datetime )
```

#### Description {#description}
Returns the number of the month in the year of the specified date `datetime`.

**Argument types:**
- `datetime` — `Date | Datetime`


**Return type**: `Integer`

#### Example {#examples}




Formulas:

- **Date**: `[Date]` ;
- **Month**: `MONTH([Date])` ;
- **Month name**: `CASE(MONTH([Date]), 1, "January", 2, "February", 3, "March", 4, "April", 5, "May", 6, "June", 7, "July", 8, "August", 9, "September", 10, "October", 11, "November", 12, "December", "Undefined")` .

| **Date**     | **Month**   | **Month name**   |
|:-------------|:------------|:-----------------|
| `2014-10-06` | `10`        | `'October'`      |
| `2014-10-07` | `10`        | `'October'`      |
| `2017-03-08` | `3`         | `'March'`        |
| `2024-02-12` | `2`         | `'February'`     |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
