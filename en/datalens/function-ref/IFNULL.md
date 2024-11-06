---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/IFNULL.md
---

# IFNULL



#### Syntax {#syntax}


```
IFNULL( check_value, alt_value )
```

#### Description {#description}
Returns `check_value` if it's not `NULL`. Otherwise returns `alt_value`.

**Argument types:**
- `check_value` — `Any`
- `alt_value` — `Any`


**Return type**: Same type as (`check_value`, `alt_value`)

{% note info %}

Arguments (`check_value`, `alt_value`) must be of the same type.

{% endnote %}


#### Example {#examples}



| **[sales]**   | **IFNULL([sales], -100.0)**   |
|:--------------|:------------------------------|
| `432.40`      | `432.40`                      |
| `77.00`       | `77.00`                       |
| `12000.00`    | `12000.00`                    |
| `NULL`        | `-100.00`                     |
| `34.25`       | `34.25`                       |
| `128.00`      | `128.00`                      |
| `0.00`        | `0.00`                        |
| `NULL`        | `-100.00`                     |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
