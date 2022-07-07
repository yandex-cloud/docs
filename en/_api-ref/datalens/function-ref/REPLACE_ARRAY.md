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

#### Example {#examples}



| **[array]**               | **REPLACE([array], 300, -1)**   | **REPLACE([array], NULL, 0)**   |
|:--------------------------|:--------------------------------|:--------------------------------|
| `'[100,300,200,100,300]'` | `'[100,-1,200,100,-1]'`         | `'[100,300,200,100,300]'`       |
| `'[100,300,NULL,NULL]'`   | `'[100,-1,NULL,NULL]'`          | `'[100,300,0,0]'`               |
| `'[150,NULL,130,192]'`    | `'[150,NULL,130,192]'`          | `'[150,0,130,192]'`             |




#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `PostgreSQL 9.3`.
