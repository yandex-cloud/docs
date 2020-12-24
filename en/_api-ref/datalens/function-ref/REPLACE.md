---
editable: false
---

# REPLACE



#### Syntax {#syntax}


```
REPLACE( string, substring, replace_with )
```

#### Description {#description}
Searches for the substring `substring` in the string `string` and replaces it with the string `replace_with`.

If the substring is not found, the string is not changed.

**Argument types:**
- `string` — `String`
- `substring` — `String`
- `replace_with` — `String`


**Return type**: `String`

#### Examples {#examples}

```
REPLACE("350 RUB", "RUB", "USD") = "350 USD"
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
