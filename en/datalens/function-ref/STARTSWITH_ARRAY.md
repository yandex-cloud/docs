---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/STARTSWITH_ARRAY.md
---

# STARTSWITH (array)

_Function `STARTSWITH` is also found in the following categories: [String functions](STARTSWITH.md)._

#### Syntax {#syntax}


```
STARTSWITH( array_1, array_2 )
```

#### Description {#description}
Returns `TRUE` if `array_1` starts with `array_2`.

**Argument types:**
- `array_1` — `Array of fractional numbers | Array of integers | Array of strings`
- `array_2` — `Array of fractional numbers | Array of integers | Array of strings`


**Return type**: `Boolean`

#### Examples {#examples}

```
STARTSWITH(ARRAY(1, 2, 3), ARRAY(1, 2)) = TRUE
```

```
STARTSWITH(ARRAY(1, 2, 3), ARRAY(2, 3)) = FALSE
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `PostgreSQL 9.3`, `Yandex Documents`.
