---
editable: false
---

# REPLACE (array)

_Function `REPLACE` is also found in the following categories: [String functions](REPLACE.md)._

#### Syntax {#syntax}


```
REPLACE( array, old, new )
```

#### Description {#description}
Replaces each `array` element equal to `old` with `new`.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`
- `old` — `Fractional number | Integer | String`
- `new` — `Fractional number | Integer | String`


**Return type**: Same type as (`array`)

#### Examples {#examples}

```
REPLACE(ARRAY(1, 2, 4), 4, 3) = [1, 2, 3]
```

```
REPLACE(ARRAY(1, NULL, NULL), NULL, 0) = [1, 0, 0]
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `PostgreSQL 9.3`.
