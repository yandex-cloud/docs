---
editable: false
---

# RIGHT

_String functions_

#### Syntax {#syntax}


```
RIGHT( string, number )
```

#### Description {#description}
Returns a string that contains the number of characters specified in `number` from the end of the string `string`.

**Argument types:**
- `string` — `String`
- `number` — `Number (whole)`


**Return type**: `String`

#### Examples {#examples}

```
RIGHT("Computer", 3) = "ter"
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
