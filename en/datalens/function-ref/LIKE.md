---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/LIKE.md
---

# LIKE



#### Syntax {#syntax}


```
string_1 [ NOT ] LIKE string_2
```

#### Description {#description}
Matches the string `string_1` to the template `string_2` and returns `TRUE` on match.
You can specify the value in `string_2` or use the `%` character to match a string of any length.

The `string_1 NOT LIKE` option returns the opposite value.

When comparing values, the function is case-sensitive. You can use `LIKE` along with [UPPER](UPPER.md) or [LOWER](LOWER.md) for case-insensitive comparison.

**Argument types:**
- `string_1` — `String`
- `string_2` — `String`


**Return type**: `Boolean`

#### Examples {#examples}

```
"raspberry" LIKE "%spb%" = TRUE
```

```
"raspberry" LIKE "%SPB%" = FALSE
```

```
"raspberry" NOT LIKE "%spb%" = FALSE
```

```
IIF([Country] LIKE 'RU', 'Y', 'N')
```

```
IIF([Phone] LIKE '+7%', 'RU', 'notRU')
```

```
UPPER("raspberry") LIKE "%SPB%" = TRUE
```

```
UPPER("West") LIKE "WEST" = TRUE
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
