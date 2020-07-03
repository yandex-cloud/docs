---
editable: false
---

# RTRIM

_String functions_

#### Syntax {#syntax}


```
RTRIM( string )
```

#### Description {#description}
Returns the string `string` without spaces at the end of the string.

**Argument types:**
- `string` — `String`


**Return type**: `String`

#### Examples {#examples}

```
RTRIM("Computer ") = "Computer"
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
