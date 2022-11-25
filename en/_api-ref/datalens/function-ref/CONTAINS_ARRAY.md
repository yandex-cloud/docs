---
editable: false
---

# CONTAINS (array)

_Function `CONTAINS` is also found in the following categories: [String functions](CONTAINS.md)._

#### Syntax {#syntax}


```
CONTAINS( array, value )
```

#### Description {#description}
Returns `TRUE` if `array` contains `value`.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`
- `value` — `Fractional number | Integer | String`


**Return type**: `Boolean`

#### Examples {#examples}

```
CONTAINS(ARRAY(1, 2, 3), 2) = TRUE
```

```
CONTAINS(ARRAY(1, 2, 3), 4) = FALSE
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `PostgreSQL 9.3`.
